module second_stage_controller #(
    parameter integer NP          = 32,
    parameter integer N_ENGINES   = 4,
    parameter integer PAIR_COUNT  = (NP * (NP - 1)) / 2,
    parameter integer COUNT_WIDTH = $clog2(PAIR_COUNT + 1),
    parameter integer DONE_INC_W  = $clog2(N_ENGINES + 1)
) (
    input  logic                       clock,
    input  logic                       i_reset,
    input  logic                       i_enable,

    // Status from the datapath blocks
    input  logic                       i_config_done,
    input  logic                       i_load_done,
    input  logic                       i_pair_done,
    input  logic                       i_fft2_frame_done [N_ENGINES],
    input  logic                       i_error,

    // One-cycle / level controls toward the datapath
    output logic                       o_clear,
    output logic                       o_phase_enable,
    output logic                       o_config_start,
    output logic                       o_pair_start,

    // Top-level status
    output logic                       o_busy,
    output logic                       o_done,
    output logic                       o_error,
    output logic [COUNT_WIDTH - 1 : 0] o_fft2_frames_done
);

    typedef enum logic [3:0] {
        S_IDLE,
        S_CONFIG_START,
        S_CONFIG_WAIT,
        S_LOAD,
        S_PAIR_START,
        S_PROCESS,
        S_DONE,
        S_ERROR} state_type;

    state_type state_reg, state_next;

    logic [COUNT_WIDTH-1  : 0] r_fft2_frames_done;
    logic                      r_pair_done_seen;
    logic [DONE_INC_W - 1 : 0] w_done_inc;
    logic [COUNT_WIDTH    : 0] w_done_sum;
    logic                      w_all_fft2_done;
    logic                      w_pair_side_done;

    // Count how many independent FFT2 engines complete a frame this cycle
    always_comb begin
        w_done_inc = '0;
        for (int eng = 0; eng < N_ENGINES; eng++) begin
            if (i_fft2_frame_done[eng]) w_done_inc = w_done_inc + 1'b1;
        end
    end

    assign w_done_sum = {1'b0, r_fft2_frames_done} + w_done_inc;

    // Include completions occurring in the current cycle so there is no extra wait cycle after the final FFT2 frame handshake.
    assign w_all_fft2_done    = (r_fft2_frames_done >= PAIR_COUNT) || (w_done_sum >= PAIR_COUNT);
    assign w_pair_side_done   = r_pair_done_seen || i_pair_done;
    assign o_fft2_frames_done = r_fft2_frames_done;

    // -------------------------------------------------------------------------
    // State register
    // -------------------------------------------------------------------------
    always_ff @(posedge clock) begin
        if (i_reset) state_reg <= S_IDLE;
        else state_reg <= state_next;
    end

    // -------------------------------------------------------------------------
    // State transitions
    // -------------------------------------------------------------------------    
    always_comb begin
        state_next = state_reg;
        // Any structural/runtime error aborts the current run.
        if (i_error && (state_reg != S_IDLE) && (state_reg != S_DONE)) state_next = S_ERROR;
        else begin
            case (state_reg)
                S_IDLE: begin
                    if (i_enable) begin
                        if (i_error) state_next = S_ERROR;
                        else state_next = S_CONFIG_START;
                    end
                end
                S_CONFIG_START: begin
                    // fft2_config_parallel samples o_config_start here.
                    state_next = S_CONFIG_WAIT;
                end
                S_CONFIG_WAIT: begin
                    if (i_config_done) state_next = S_LOAD;
                end
                S_LOAD: begin
                    // The four corrected FFT1 streams are accepted into the banked storage during this state.
                    if (i_load_done) state_next = S_PAIR_START;
                end

                S_PAIR_START: begin
                    // scd_pair_streamer_parallel samples o_pair_start here.
                    state_next = S_PROCESS;
                end

                S_PROCESS: begin
                    // pair_done only means all RAM-side requests have left the scheduler the FFT2 pipelines are considered drained only after PAIR_COUNT output frames have completed as well.
                    if (w_pair_side_done && w_all_fft2_done) state_next = S_DONE;
                end

                S_DONE: begin
                    // i_enable is treated as a run-level request. 
                    // hold DONE until the enclosing controller drops it, then re-arm in IDLE.
                    if (!i_enable) state_next = S_IDLE;
                end

                S_ERROR: begin
                    if (!i_enable) state_next = S_IDLE;
                end

                default: state_next = S_IDLE;
            endcase
        end
    end

    // -------------------------------------------------------------------------
    // Moore outputs
    // -------------------------------------------------------------------------
    always_comb begin
        o_clear        = '0;
        o_phase_enable = '0;
        o_config_start = '0;
        o_pair_start   = '0;
        o_busy         = '0;
        o_done         = '0;
        o_error        = '0;

        case (state_reg)
            S_IDLE: begin
                // clear all sticky flags, counters and storage addressing while waiting for a new run
                o_clear = 1'b1;
            end

            S_CONFIG_START: begin
                o_busy         = 1'b1;
                o_config_start = 1'b1;
            end

            S_CONFIG_WAIT: begin
                o_busy = 1'b1;
            end

            S_LOAD: begin
                o_busy         = 1'b1;
                o_phase_enable = 1'b1;
            end

            S_PAIR_START: begin
                o_busy       = 1'b1;
                o_pair_start = 1'b1;
            end

            S_PROCESS: begin
                o_busy = 1'b1;
            end

            S_DONE: begin
                o_done = 1'b1;
            end

            S_ERROR: begin
                o_error = 1'b1;
            end

            default: begin
                o_clear = 1'b1;
            end
        endcase
    end

    // -------------------------------------------------------------------------
    // Completion bookkeeping
    // -------------------------------------------------------------------------

    always_ff @(posedge clock) begin
        if (i_reset || o_clear) begin
            r_fft2_frames_done <= '0;
            r_pair_done_seen   <= '0;
        end
        else begin
            if (state_reg == S_PROCESS) begin
                if (i_pair_done) r_pair_done_seen <= 1'b1;
                
                if (w_done_inc != 0) begin
                    if (w_done_sum >= PAIR_COUNT) r_fft2_frames_done <= PAIR_COUNT[COUNT_WIDTH-1:0];
                    else                          r_fft2_frames_done <= w_done_sum[COUNT_WIDTH-1:0];
                end
            end
        end
    end

endmodule
