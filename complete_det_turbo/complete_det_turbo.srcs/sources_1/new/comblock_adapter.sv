`timescale 1ns / 1ps

module comblock_adapter #(
    parameter integer NB_SAMPLE_DATA = 12,
    parameter integer N_SAMPLES_MAX  = 1024
)(
    input  logic clock,

    // =========================================================================
    // ComBlock OUT FIFO (PS -> PL)
    // =========================================================================
    input  logic                          i_cb_OUT_FIFO_0_fifo_aempty_o,
    input  logic [2*NB_SAMPLE_DATA-1 : 0] i_cb_OUT_FIFO_0_fifo_data_o,
    input  logic                          i_cb_OUT_FIFO_0_fifo_empty_o,
    input  logic                          i_cb_OUT_FIFO_0_fifo_underflow_o,
    input  logic                          i_cb_OUT_FIFO_0_fifo_valid_o,
    output logic                          o_cb_OUT_FIFO_0_fifo_re_i,

    // =========================================================================
    // ComBlock OUT registers (PS -> PL)
    // =========================================================================
    input  logic [31:0] i_cb_OUT_REGS_0_reg0_o,
    input  logic [31:0] i_cb_OUT_REGS_0_reg1_o,

    // =========================================================================
    // ComBlock IN registers (PL -> PS)
    // =========================================================================
    output logic [31:0] o_cb_IN_REGS_0_reg0_i,
    output logic [31:0] o_cb_IN_REGS_0_reg1_i,
    output logic [31:0] o_cb_IN_REGS_0_reg2_i,
    output logic [31:0] o_cb_IN_REGS_0_reg3_i,
    output logic [31:0] o_cb_IN_REGS_0_reg4_i,
    output logic [31:0] o_cb_IN_REGS_0_reg5_i,

    // =========================================================================
    // fam_detector_top inputs
    // =========================================================================
    output logic top_mux_reset,
    output logic top_mux_enable,
    output logic top_mux_noise_data_valid,
    output logic top_mux_signal_data_valid,

    output logic [10 : 0] top_mux_data_size,
    output logic [10 : 0] top_mux_noise_size,
    output logic [1  : 0] top_mux_window_sel,
    output logic [3  : 0] top_mux_pfa_value,
    output logic          top_mux_scd_mode,

    output logic signed [NB_SAMPLE_DATA - 1 : 0] top_mux_data_re,
    output logic signed [NB_SAMPLE_DATA - 1 : 0] top_mux_data_im,

    // Asserted by the detector exactly when one external signal sample is consumed by the first stage.
    input  logic top_mux_signal_sample_request,

    // =========================================================================
    // fam_detector_top outputs
    // =========================================================================
    input  logic signed [64:0] top_mux_threshold,
    input  logic signed [33:0] top_mux_noise_power,

    input  logic [15:0] top_mux_detect,
    input  logic        top_mux_detection_done,
    input  logic        top_mux_threshold_est_done,
    input  logic        top_mux_error
);

    localparam integer SAMPLE_WIDTH = 2 * NB_SAMPLE_DATA;
    localparam integer ADDR_WIDTH   = $clog2(N_SAMPLES_MAX);
    localparam integer COUNT_WIDTH  = $clog2(N_SAMPLES_MAX + 1);

    // =========================================================================
    // Decode PS configuration
    // =========================================================================
    logic        w_cmd_reset;
    logic        w_cmd_enable;
    logic        w_cmd_noise;
    logic        w_cmd_signal;
    logic [10:0] w_cfg_data_size;
    logic [10:0] w_cfg_noise_size;
    logic [1:0]  w_cfg_window_sel;
    logic [3:0]  w_cfg_pfa_value;
    logic        w_cfg_scd_mode;

    assign w_cmd_reset      = i_cb_OUT_REGS_0_reg0_o[0];
    assign w_cmd_enable     = i_cb_OUT_REGS_0_reg0_o[1];
    assign w_cmd_noise      = i_cb_OUT_REGS_0_reg0_o[2];
    assign w_cmd_signal     = i_cb_OUT_REGS_0_reg0_o[3];

    assign w_cfg_data_size  = i_cb_OUT_REGS_0_reg0_o[14:4];
    assign w_cfg_noise_size = i_cb_OUT_REGS_0_reg0_o[25:15];
    assign w_cfg_window_sel = i_cb_OUT_REGS_0_reg0_o[27:26];
    assign w_cfg_pfa_value  = i_cb_OUT_REGS_0_reg0_o[31:28];

    assign w_cfg_scd_mode   = i_cb_OUT_REGS_0_reg1_o[0];

    // Preserve the original registered control/configuration interface.
    always_ff @(posedge clock) begin
        top_mux_reset      <= w_cmd_reset;
        top_mux_enable     <= w_cmd_enable;
        top_mux_data_size  <= w_cfg_data_size;
        top_mux_noise_size <= w_cfg_noise_size;
        top_mux_window_sel <= w_cfg_window_sel;
        top_mux_pfa_value  <= w_cfg_pfa_value;
        top_mux_scd_mode   <= w_cfg_scd_mode;
    end

    // =========================================================================
    // Local sample buffer
    //
    // PS -> ComBlock FIFO -> local BRAM -> detector
    //
    // A complete transaction is copied from the ComBlock FIFO to this BRAM before being replayed to the detector. 
    // This decouples FIFO timing from the FFT configuration/startup latency inside fam_detector_top.
    // =========================================================================

    (* ram_style = "block" *) logic [SAMPLE_WIDTH - 1 : 0] r_sample_mem [0 : N_SAMPLES_MAX - 1];

    // First register receives the synchronous BRAM read result.
    // The second register is the detector-facing pipeline stage. This explicitly breaks the BRAM -> detector arithmetic timing path.
    logic [SAMPLE_WIDTH - 1 : 0] r_mem_rd_data;
    logic [SAMPLE_WIDTH - 1 : 0] r_mem_pipe_data;

    assign top_mux_data_re = $signed(r_mem_pipe_data[NB_SAMPLE_DATA-1:0]);
    assign top_mux_data_im = $signed(r_mem_pipe_data[SAMPLE_WIDTH-1:NB_SAMPLE_DATA]);

    // =========================================================================
    // Adapter FSM
    // =========================================================================

    typedef enum logic [3:0] {
        S_IDLE,
        S_LOAD_NOISE,
        S_NOISE_PREFETCH,
        S_NOISE_PIPE,
        S_NOISE_STREAM,
        S_NOISE_WAIT_DONE,
        S_NOISE_WAIT_RELEASE,
        S_LOAD_SIGNAL,
        S_SIGNAL_PREFETCH,
        S_SIGNAL_PIPE,
        S_SIGNAL_STREAM,
        S_SIGNAL_PROCESS,
        S_SIGNAL_WAIT_RELEASE} state_t;

    state_t r_state, w_state;

    logic [COUNT_WIDTH-1:0] r_fifo_issue_count;
    logic [COUNT_WIDTH-1:0] r_fifo_recv_count;
    logic [COUNT_WIDTH-1:0] r_play_count;
    logic [COUNT_WIDTH-1:0] r_target_count;
    logic [COUNT_WIDTH-1:0] w_next_play_count;
    logic [COUNT_WIDTH-1:0] w_next2_play_count;

    logic                  w_mem_rd_en;
    logic [ADDR_WIDTH-1:0] w_mem_rd_addr;

    logic r_adapter_error;
    logic w_adapter_busy;

    assign w_next_play_count  = r_play_count + 1'b1;
    assign w_next2_play_count = r_play_count + 2'd2;
    assign w_adapter_busy = (r_state != S_IDLE);

    // =========================================================================
    // FIFO read control
    //
    // Count read requests separately from returned fifo_valid_o samples.
    // =========================================================================
    always_comb begin
        o_cb_OUT_FIFO_0_fifo_re_i = 1'b0;
        if ((r_state == S_LOAD_NOISE || r_state == S_LOAD_SIGNAL) && !i_cb_OUT_FIFO_0_fifo_empty_o && (r_fifo_issue_count < r_target_count)) begin
            o_cb_OUT_FIFO_0_fifo_re_i = 1'b1;
        end
    end

    // =========================================================================
    // Synchronous BRAM read scheduler
    // =========================================================================
    always_comb begin
        w_mem_rd_en   = 1'b0;
        w_mem_rd_addr = '0;

        case (r_state)
            // First BRAM access: fetch sample 0.
            S_NOISE_PREFETCH, S_SIGNAL_PREFETCH: begin
                w_mem_rd_en   = 1'b1;
                w_mem_rd_addr = '0;
            end
            // Move sample 0 toward the detector and, when present, prefetch sample 1 into the BRAM read register.
            S_NOISE_PIPE, S_SIGNAL_PIPE: begin
                if (r_target_count > 1) begin
                    w_mem_rd_en   = 1'b1;
                    w_mem_rd_addr = 1'b1;
                end
            end
            // During streaming, r_mem_pipe_data contains sample k and r_mem_rd_data contains sample k+1. 
            // Request sample k+2 so the detector can still receive one sample every clock.
            S_NOISE_STREAM: begin
                if (w_next2_play_count < r_target_count) begin
                    w_mem_rd_en   = 1'b1;
                    w_mem_rd_addr = w_next2_play_count[ADDR_WIDTH-1:0];
                end
            end
            // Signal RAM advances only when the detector consumes a sample.
            S_SIGNAL_STREAM: begin
                if (top_mux_signal_sample_request && (w_next2_play_count < r_target_count)) begin
                    w_mem_rd_en   = 1'b1;
                    w_mem_rd_addr = w_next2_play_count[ADDR_WIDTH-1:0];
                end
            end
            default: begin
                w_mem_rd_en   = '0;
                w_mem_rd_addr = '0;
            end

        endcase
    end

    // Synchronous BRAM read port. This register acts as the look-ahead stage.
    always_ff @(posedge clock) begin
        if (w_mem_rd_en) r_mem_rd_data <= r_sample_mem[w_mem_rd_addr];
    end

    // Additional detector-facing output register. It adds one cycle of startup latency but keeps one-sample-per-cycle throughput once streaming starts.
    always_ff @(posedge clock) begin
        if (w_cmd_reset) begin
            r_mem_pipe_data <= '0;
        end
        else begin
            // Sample 0 was fetched during *_PREFETCH.
            if ((r_state == S_NOISE_PIPE) || (r_state == S_SIGNAL_PIPE)) r_mem_pipe_data <= r_mem_rd_data;
            // Noise samples are consumed on every STREAM cycle.
            else if (r_state == S_NOISE_STREAM) begin
                if (w_next_play_count < r_target_count) r_mem_pipe_data <= r_mem_rd_data;
            end
            // Signal samples advance only when the detector consumes the current sample.
            else if (r_state == S_SIGNAL_STREAM) begin
                if (top_mux_signal_sample_request && (w_next_play_count < r_target_count)) r_mem_pipe_data <= r_mem_rd_data;
            end
        end
    end

    // =========================================================================
    // Detector transaction-level VALID outputs
    // =========================================================================
    always_comb begin
        top_mux_noise_data_valid  = '0;
        top_mux_signal_data_valid = '0;
        // Threshold estimator consumes one sample for each asserted cycle.
        if (r_state == S_NOISE_STREAM) top_mux_noise_data_valid = 1'b1;
        // Signal valid is transaction-level in fam_detector_top. Keep it high during sample delivery, internal zero padding, and FAM processing.
        if ((r_state == S_SIGNAL_STREAM) || (r_state == S_SIGNAL_PROCESS) || (r_state == S_SIGNAL_WAIT_RELEASE)) top_mux_signal_data_valid = 1'b1;
    end

    // =========================================================================
    // FSM next-state logic
    // =========================================================================
    always_comb begin : FSM_NEXT_STATE
        w_state = r_state;
        case (r_state)
            S_IDLE: begin
                if (w_cmd_enable && w_cmd_noise) begin
                    if ((w_cfg_noise_size != 0) && (w_cfg_noise_size <= N_SAMPLES_MAX)) w_state = S_LOAD_NOISE;
                end
                else if (w_cmd_enable && w_cmd_signal) begin
                    if ((w_cfg_data_size != 0) && (w_cfg_data_size <= N_SAMPLES_MAX)) w_state = S_LOAD_SIGNAL;
                end
            end
            // -------------------------------------------------------------
            // NOISE TRANSACTION
            // -------------------------------------------------------------
            S_LOAD_NOISE: begin
                if (i_cb_OUT_FIFO_0_fifo_valid_o && ((r_fifo_recv_count + 1'b1) >= r_target_count)) w_state = S_NOISE_PREFETCH;
            end
            S_NOISE_PREFETCH: begin
                w_state = S_NOISE_PIPE;
            end
            S_NOISE_PIPE: begin
                w_state = S_NOISE_STREAM;
            end
            S_NOISE_STREAM: begin
                if (w_next_play_count >= r_target_count) w_state = S_NOISE_WAIT_DONE;
            end
            S_NOISE_WAIT_DONE: begin
                if (top_mux_threshold_est_done) w_state = S_NOISE_WAIT_RELEASE;
            end
            S_NOISE_WAIT_RELEASE: begin
                if (!w_cmd_noise) w_state = S_IDLE;
            end
            // -------------------------------------------------------------
            // SIGNAL TRANSACTION
            // -------------------------------------------------------------
            S_LOAD_SIGNAL: begin
                if (i_cb_OUT_FIFO_0_fifo_valid_o && ((r_fifo_recv_count + 1'b1) >= r_target_count)) w_state = S_SIGNAL_PREFETCH;
            end
            S_SIGNAL_PREFETCH: begin
                w_state = S_SIGNAL_PIPE;
            end
            S_SIGNAL_PIPE: begin
                w_state = S_SIGNAL_STREAM;
            end
            S_SIGNAL_STREAM: begin
                if (top_mux_signal_sample_request && (w_next_play_count >= r_target_count)) w_state = S_SIGNAL_PROCESS;
            end
            S_SIGNAL_PROCESS: begin
                if (top_mux_detection_done) w_state = S_SIGNAL_WAIT_RELEASE;
            end
            S_SIGNAL_WAIT_RELEASE: begin
                if (!w_cmd_signal) w_state = S_IDLE;
            end
            default: begin
                w_state = S_IDLE;
            end
        endcase
    end

    // =========================================================================
    // FSM state register
    // =========================================================================
    always_ff @(posedge clock) begin : FSM_STATE_REGISTER
        if (w_cmd_reset) r_state <= S_IDLE;
        else r_state <= w_state;
    end

    // =========================================================================
    // Sequential datapath / counters / memory write
    // =========================================================================
    always_ff @(posedge clock) begin : FSM_SEQUENTIAL_DATAPATH
        if (w_cmd_reset) begin
            r_fifo_issue_count <= '0;
            r_fifo_recv_count  <= '0;
            r_play_count       <= '0;
            r_target_count     <= '0;
            r_adapter_error    <= '0;
        end
        else begin
            // -------------------------------------------------------------
            // Sticky diagnostics
            // -------------------------------------------------------------
            if (i_cb_OUT_FIFO_0_fifo_underflow_o) r_adapter_error <= 1'b1;
            // Invalid transaction size.
            if (r_state == S_IDLE) begin
                if      (w_cmd_enable && w_cmd_noise && ((w_cfg_noise_size == 0) || (w_cfg_noise_size > N_SAMPLES_MAX))) r_adapter_error <= 1'b1;
                else if (w_cmd_enable && w_cmd_signal && ((w_cfg_data_size == 0) || (w_cfg_data_size > N_SAMPLES_MAX)) ) r_adapter_error <= 1'b1;
            end

            // -------------------------------------------------------------
            // FIFO request counter
            // -------------------------------------------------------------
            if       (r_state == S_IDLE       ) r_fifo_issue_count <= '0;
            else if (o_cb_OUT_FIFO_0_fifo_re_i) r_fifo_issue_count <= r_fifo_issue_count + 1'b1;

            // -------------------------------------------------------------
            // FIFO receive counter + BRAM write
            // -------------------------------------------------------------
            if (r_state == S_IDLE) r_fifo_recv_count <= '0;
            else if ((r_state == S_LOAD_NOISE || r_state == S_LOAD_SIGNAL) && i_cb_OUT_FIFO_0_fifo_valid_o) begin
                if (r_fifo_recv_count < r_target_count) begin
                    r_sample_mem[r_fifo_recv_count[ADDR_WIDTH-1:0]] <= i_cb_OUT_FIFO_0_fifo_data_o[SAMPLE_WIDTH-1:0];
                    r_fifo_recv_count                               <= r_fifo_recv_count + 1'b1;
                end
                else  r_adapter_error <= 1'b1;
            end

            // -------------------------------------------------------------
            // Latch transaction length when command is accepted
            // -------------------------------------------------------------
            if (r_state == S_IDLE) begin
                if      (w_cmd_enable && w_cmd_noise ) r_target_count <= w_cfg_noise_size;
                else if (w_cmd_enable && w_cmd_signal) r_target_count <= w_cfg_data_size;
            end

            // -------------------------------------------------------------
            // Playback counter
            // -------------------------------------------------------------
            if (r_state == S_IDLE || r_state == S_NOISE_PREFETCH || r_state == S_NOISE_PIPE || r_state == S_SIGNAL_PREFETCH || r_state == S_SIGNAL_PIPE) begin
                r_play_count <= '0;
            end
            else if (r_state == S_NOISE_STREAM) begin
                r_play_count <= w_next_play_count;
            end
            else if ((r_state == S_SIGNAL_STREAM) && top_mux_signal_sample_request) begin
                r_play_count <= w_next_play_count;
            end

        end
    end

    // =========================================================================
    // PL -> PS status/result registers
    //
    // IN_REG0 preserves original fields:
    //   [15:0] detection count
    //   [16]   detection_done
    //   [17]   threshold_est_done
    //
    // Added diagnostics:
    //   [18] detector error
    //   [19] adapter error
    //   [20] FIFO underflow
    //   [21] adapter busy
    // =========================================================================

    always_comb begin
        o_cb_IN_REGS_0_reg0_i = '0;
        o_cb_IN_REGS_0_reg0_i[15:0] = top_mux_detect;
        o_cb_IN_REGS_0_reg0_i[16]   = top_mux_detection_done;
        o_cb_IN_REGS_0_reg0_i[17]   = top_mux_threshold_est_done;
        o_cb_IN_REGS_0_reg0_i[18]   = top_mux_error;
        o_cb_IN_REGS_0_reg0_i[19]   = r_adapter_error;
        o_cb_IN_REGS_0_reg0_i[20]   = i_cb_OUT_FIFO_0_fifo_underflow_o;
        o_cb_IN_REGS_0_reg0_i[21]   = w_adapter_busy;
        
        o_cb_IN_REGS_0_reg1_i = top_mux_noise_power[31:0];

        // Correct high word: bit 31 is already present in IN_REG1.
        o_cb_IN_REGS_0_reg2_i      = '0;
        o_cb_IN_REGS_0_reg2_i[1:0] = top_mux_noise_power[33:32];

        o_cb_IN_REGS_0_reg3_i = top_mux_threshold[31:0];
        o_cb_IN_REGS_0_reg4_i = top_mux_threshold[63:32];

        o_cb_IN_REGS_0_reg5_i    = '0;
        o_cb_IN_REGS_0_reg5_i[0] = top_mux_threshold[64];
    end

    // Informational only.
    logic w_unused_aempty;
    assign w_unused_aempty = i_cb_OUT_FIFO_0_fifo_aempty_o;

endmodule
