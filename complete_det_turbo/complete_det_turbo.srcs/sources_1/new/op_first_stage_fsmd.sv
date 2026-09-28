module first_stage_fsmd_4fft_no_ram #(
    parameter P_MAX            = 128,
              NP               = 32,
              NB_DATA          = 16,
              NBF_DATA         = 13,
              NB_WIN           = 8,
              NBF_WIN          = 7,
              N_FFT            = 4,
              AXI_CONFIG_WIDTH = 7
) (
    input  logic                            clock,
    input  logic                            i_reset,
    input  logic                            i_enable,
    input  logic                            i_scd_done,
    input  logic [$clog2(P_MAX)        : 0] i_p_frames,

    input  logic                            i_window_prod_valid_re,
    input  logic                            i_window_prod_valid_im,
    input  logic signed [NB_DATA   - 1 : 0] i_window_prod_re [NP],
    input  logic signed [NB_DATA   - 1 : 0] i_window_prod_im [NP],
    output logic                            o_input_win_enable,

    // Diagnostic: asserted for one clock if a new window is produced while the FFT selected by the round-robin dispatcher cannot accept a new frame
    output logic                            o_frame_overflow,

    input  logic                            i_s_axis_data_tready [N_FFT],
    output logic                            o_s_axis_data_tlast  [N_FFT],
    output logic                            o_s_axis_data_tvalid [N_FFT],
    output logic [2*NB_DATA        - 1 : 0] o_s_axis_data_tdata  [N_FFT],

    input  logic                            i_s_axis_config_tready [N_FFT],
    output logic                            o_s_axis_config_tvalid [N_FFT],
    output logic [AXI_CONFIG_WIDTH - 1 : 0] o_s_axis_config_tdata
);

    localparam INDX_WIDTH = $clog2(NP);
    localparam SEL_WIDTH  = $clog2(N_FFT);
    
    localparam AXI_CONFIG_FWIN_WIDTH = 1;
    localparam AXI_CONFIG_SCAL_WIDTH = 6;
    
    localparam logic [AXI_CONFIG_FWIN_WIDTH - 1 : 0] FWD_INV   = 1'b1;
    localparam logic [AXI_CONFIG_SCAL_WIDTH - 1 : 0] SCALE_SCH = 6'b010111;
    
    typedef enum logic [2:0] {
        S_IDLE,
        S_CONFIG,
        S_RUN,
        S_DRAIN,
        S_DONE} state_type;
    
    state_type state_reg, state_next;

    // -------------------------------------------------------------------------
    // Per-FFT frame buffers and serializer state
    // -------------------------------------------------------------------------
    logic [2*NB_DATA  - 1 : 0] r_fft_buffer [N_FFT][NP];
    logic [2*NB_DATA  - 1 : 0] r_fft_data   [N_FFT];
    logic [INDX_WIDTH - 1 : 0] r_fft_index  [N_FFT];
    logic                      r_fft_busy   [N_FFT];

    // Each FFT is configured independently, but all receive the same config word
    logic r_fft_config_done [N_FFT];

    // Round-robin frame dispatcher and accepted-frame counter
    logic [SEL_WIDTH - 1 : 0] r_fft_sel;
    logic [$clog2(P_MAX) : 0] r_frame_count;

    logic w_window_frame_valid;
    logic w_selected_fft_available;

    // -------------------------------------------------------------------------
    // One-frame pending mechanism for FFT Realtime mode
    //
    // The input-window block can be stalled through o_input_win_enable.
    // When a complete window arrives while its round-robin FFT is still finishing the previous frame, the window is marked pending and the input-window path is
    // frozen. The window data itself remains stable at i_window_prod_re/im while the input-window path is stalled, so no extra NP-sample storage is needed.
    // -------------------------------------------------------------------------
    logic r_pending_frame;
    logic w_direct_frame_accept;
    logic w_pending_frame_accept;
    logic w_pending_frame_capture;
    logic w_frame_accept;
    logic w_input_stall;

    logic w_all_fft_idle;
    logic w_all_config_done;

    // -------------------------------------------------------------------------
    // Common FFT configuration
    // -------------------------------------------------------------------------
    assign o_s_axis_config_tdata = {SCALE_SCH, FWD_INV};

    // -------------------------------------------------------------------------
    // Window/frame dispatcher combinational logic
    // -------------------------------------------------------------------------
    assign w_window_frame_valid = i_window_prod_valid_re && i_window_prod_valid_im;

    // A core can accept a new frame when it is idle OR when its previous frame is transferring its final sample in this same clock cycle.
    // This permits back-to-back frame ownership every NP cycles with no dead cycle.

    always_comb begin
        w_selected_fft_available = 1'b0;
        for (int fft = 0; fft < N_FFT; fft++) begin
            if (r_fft_sel == fft[SEL_WIDTH - 1 : 0]) begin
                w_selected_fft_available = !r_fft_busy[fft] || (r_fft_busy[fft] && i_s_axis_data_tready[fft] && (r_fft_index[fft] == NP-1));
            end
        end
    end

    // A newly-produced window can be dispatched immediately when the selected FFT is available
    //
    // Timing optimization: r_frame_count is intentionally kept out of this high-fanout load path. 
    // While state_reg == S_RUN, more frames are required, accepting the final frame transitions directly to S_DRAIN.
    assign w_direct_frame_accept = (state_reg == S_RUN) && i_enable && !r_pending_frame && w_window_frame_valid && w_selected_fft_available;

    // A previously blocked window is dispatched as soon as the same selected FFT becomes available. 
    // r_fft_sel is intentionally not advanced while a frame is pending.
    assign w_pending_frame_accept = (state_reg == S_RUN) && i_enable && r_pending_frame && w_selected_fft_available;

    // Capture the blocked condition. The actual window vectors do not need to be copied: 
    // o_input_win_enable is stopped in this same cycle, which freezes the input-window datapath and therefore keeps i_window_prod_re/im stable.
    assign w_pending_frame_capture = (state_reg == S_RUN) && i_enable && !r_pending_frame && w_window_frame_valid && !w_selected_fft_available;

    assign w_frame_accept = w_direct_frame_accept || w_pending_frame_accept;

    // Stop consuming new time-domain samples only from the registered pending state. 
    // This intentionally removes r_fft_sel from the combinational path that drives o_input_win_enable and therefore the CEs of the large input-window datapath.
    //
    // When a blocked frame is first detected, r_pending_frame is asserted on that clock edge. The input-window datapath therefore advances one final
    // clock before being frozen. This is safe here because w_window_frame_valid corresponds to the already-registered window output; that output remains
    // stable through this extra clock. While r_pending_frame is high, the input path stays frozen until the frame is dispatched.
    //
    // The input path resumes on the clock after the pending frame is accepted, adding at most one harmless idle cycle after a stall event.
    assign w_input_stall = r_pending_frame;

    always_comb begin
        w_all_fft_idle    = 1'b1;
        w_all_config_done = 1'b1;
        for (int fft = 0; fft < N_FFT; fft++) begin
            if (r_fft_busy[fft]        ) w_all_fft_idle    = 1'b0;
            if (!r_fft_config_done[fft]) w_all_config_done = 1'b0;
        end
    end

    // -------------------------------------------------------------------------
    // State register
    // -------------------------------------------------------------------------
    always_ff @(posedge clock) begin
        if (i_reset) state_reg <= S_IDLE;
        else state_reg <= state_next;
    end

    // -------------------------------------------------------------------------
    // FSM next-state logic
    // -------------------------------------------------------------------------
    always_comb begin
        state_next = state_reg;
        case (state_reg)
            S_IDLE: begin
                if (i_enable) state_next = S_CONFIG;
                else state_next = S_IDLE;
            end
            S_CONFIG: begin
                // Configuration handshakes are registered below, therefore this transitions one cycle after the last core accepts its config.
                if (w_all_config_done) state_next = S_RUN;
                else state_next = S_CONFIG;
            end
            S_RUN: begin
                if (w_frame_accept && (r_frame_count == i_p_frames - 1'b1)) state_next = S_DRAIN;
                else state_next = S_RUN;
            end
            S_DRAIN: begin
                if (w_all_fft_idle) state_next = S_DONE;
                else state_next = S_DRAIN;
            end
            S_DONE: begin
                if (i_scd_done) state_next = S_IDLE;
                else state_next = S_DONE;
            end
            default: state_next = S_IDLE;
        endcase
    end

    // Input window runs while S_RUN is active and no frame is waiting in the registered pending state. 
    // Both r_frame_count and the combinational selected-FFT availability logic are intentionally kept out of this high-fanout enable path.
    assign o_input_win_enable = (state_reg == S_RUN) && i_enable && !w_input_stall;

    // -------------------------------------------------------------------------
    // FFT configuration handshakes
    // -------------------------------------------------------------------------
    generate
        genvar cfg;
        for (cfg = 0; cfg < N_FFT; cfg++) begin : GEN_CONFIG_OUTPUTS
            assign o_s_axis_config_tvalid[cfg] = (state_reg == S_CONFIG) && i_enable && !r_fft_config_done[cfg];
        end
    endgenerate

    always_ff @(posedge clock) begin : fft_configuration_control
        if (i_reset) begin
            for (int fft = 0; fft < N_FFT; fft++) begin
                r_fft_config_done[fft] <= 1'b0;
            end
        end
        else begin
            // A new run starts with all cores unconfigured
            if (state_reg == S_IDLE) begin
                for (int fft = 0; fft < N_FFT; fft++) begin
                    r_fft_config_done[fft] <= 1'b0;
                end
            end
            else if ((state_reg == S_CONFIG) && i_enable) begin
                for (int fft = 0; fft < N_FFT; fft++) begin
                    if (!r_fft_config_done[fft] && i_s_axis_config_tready[fft]) r_fft_config_done[fft] <= 1'b1;
                end
            end
            else begin 
                for (int fft = 0; fft < N_FFT; fft++) begin
                    r_fft_config_done[fft] <= r_fft_config_done[fft];
                end
            end
        end
    end

    // -------------------------------------------------------------------------
    // Round-robin control / frame count / pending-frame control
    // -------------------------------------------------------------------------
    //
    // o_frame_overflow is now a defensive diagnostic only. 
    // A normal temporary lack of FFT availability is absorbed by r_pending_frame and must NOT be reported as overflow. 
    // Overflow is asserted only if another complete window somehow appears while one is already pending.
    // -------------------------------------------------------------------------
    always_ff @(posedge clock) begin : frame_dispatch_control
        if (i_reset) begin
            r_fft_sel         <= '0;
            r_frame_count     <= '0;
            r_pending_frame   <= '0;
            o_frame_overflow  <= '0;
        end
        else begin
            o_frame_overflow <= '0;
            if (state_reg == S_IDLE) begin
                r_fft_sel       <= '0;
                r_frame_count   <= '0;
                r_pending_frame <= '0;
            end
            else if ((state_reg == S_RUN) && i_enable) begin
                // A complete window arrived but the selected FFT is not yet available. 
                // Freeze the window source and remember that this frame still has to be dispatched.
                if (w_pending_frame_capture) r_pending_frame <= 1'b1;

                // Dispatch either a fresh window or the pending one
                if (w_frame_accept) begin
                    r_frame_count <= r_frame_count + 1'b1;
                    // Pending frame has now been consumed
                    if (w_pending_frame_accept) r_pending_frame <= 1'b0;
                    
                    if (r_fft_sel == N_FFT-1) r_fft_sel <= '0;
                    else                      r_fft_sel <= r_fft_sel + 1'b1;
                end
                // Defensive check: this should never happen because the input-window path is frozen while r_pending_frame is set.
                if (r_pending_frame && w_window_frame_valid && !w_pending_frame_accept) o_frame_overflow <= 1'b1;
            end
        end
    end

    // -------------------------------------------------------------------------
    // Independent FFT input serializers
    // -------------------------------------------------------------------------
    // Each accepted window (fresh or previously pending) is copied in one clock to the selected local frame buffer. 
    // While a frame is pending, the input-window datapath is frozen, so i_window_prod_re/im continue to hold that exact window until w_pending_frame_accept is asserted.
    //
    // Each FFT then streams one complex sample per successful AXI handshake.
    // New-frame capture has priority so that a core completing its previous frame can accept the next round-robin frame on the same edge.
    
    always_ff @(posedge clock) begin : fft_input_serializer_control
        if (i_reset) begin
            for (int fft = 0; fft < N_FFT; fft++) begin
                r_fft_busy[fft]  <= '0;
                r_fft_index[fft] <= '0;
                r_fft_data[fft]  <= '0;
            end
        end
        else if (i_enable) begin
            for (int fft = 0; fft < N_FFT; fft++) begin
                // Normal AXI-stream transfer from this core's local buffer
                if (r_fft_busy[fft] && i_s_axis_data_tready[fft]) begin
                    if (r_fft_index[fft] == NP-1) begin
                        r_fft_busy[fft]  <= '0;
                        r_fft_index[fft] <= '0;
                    end
                    else begin
                        r_fft_index[fft] <= r_fft_index[fft] + 1'b1;
                        r_fft_data[fft]  <= r_fft_buffer[fft][r_fft_index[fft] + 1'b1];
                    end
                end
                // Capture a complete new window into the selected FFT buffer.
                if (w_frame_accept && (r_fft_sel == fft[SEL_WIDTH-1:0])) begin
                    for (int sample = 0; sample < NP; sample++) begin
                        r_fft_buffer[fft][sample] <= {i_window_prod_im[sample],i_window_prod_re[sample]};
                    end
                    r_fft_data[fft]  <= {i_window_prod_im[0],i_window_prod_re[0]};
                    r_fft_index[fft] <= '0;
                    r_fft_busy[fft]  <= 1'b1;
                end
            end
        end
    end

    // -------------------------------------------------------------------------
    // AXI-stream data outputs
    // -------------------------------------------------------------------------
    generate
        genvar out;
        for (out = 0; out < N_FFT; out++) begin : GEN_FFT_DATA_OUTPUTS
            assign o_s_axis_data_tdata[out]  = r_fft_data[out];
            assign o_s_axis_data_tvalid[out] = r_fft_busy[out] && i_enable;
            assign o_s_axis_data_tlast[out]  = r_fft_busy[out] && (r_fft_index[out] == NP-1);
        end
    endgenerate

endmodule
