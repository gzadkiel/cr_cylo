module detection_compare_parallel #(
    parameter integer N_ENGINES    = 4,
    parameter integer COMPONENT_W  = 32,
    parameter integer DATA_WIDTH   = 2 * COMPONENT_W,
    parameter integer POWER_WIDTH  = 2 * COMPONENT_W + 1,
    parameter integer NB_DETECT    = 16
) (
    input  logic                       clock,
    input  logic                       i_reset,
    input  logic                       i_clear,
    input  logic                       i_enable,

    // Squared-SCD threshold. For COMPONENT_W=32, POWER_WIDTH=65.
    input  logic [POWER_WIDTH - 1 : 0] i_threshold,

    // Reduced FFT2/SCD streams coming from fft2_bin_filter_parallel.
    // Complex format: {imag, real}.
    input  logic [DATA_WIDTH  - 1 : 0] i_s_axis_tdata  [N_ENGINES],
    input  logic                       i_s_axis_tvalid [N_ENGINES],
    input  logic                       i_s_axis_tlast  [N_ENGINES],
    output logic                       o_s_axis_tready [N_ENGINES],

    // |SCD|^2 output stream.
    output logic [POWER_WIDTH - 1 : 0] o_power_tdata  [N_ENGINES],
    output logic                       o_power_tvalid [N_ENGINES],
    output logic                       o_power_tlast  [N_ENGINES],
    input  logic                       i_power_tready [N_ENGINES],

    // Per-sample detection flag, aligned with o_power_*.
    output logic                       o_detect [N_ENGINES],

    // Total number of accepted samples whose |SCD|^2 exceeds i_threshold.
    output logic [NB_DETECT   - 1 : 0] o_detect_counter
);

    // -------------------------------------------------------------------------
    // Fixed-throughput four-stage pipeline
    //
    //   Stage 0 : register FFT2/bin-filter Re/Im
    //   Stage 1 : Re^2 and Im^2
    //   Stage 2 : Re^2 + Im^2
    //   Stage 3 : threshold comparison
    //
    // Unlike the previous elastic implementation, the datapath does not use valid/ready-derived clock enables. 
    // Data registers advance every enabled clock and validity is carried in a parallel pipeline.
    //
    // This is appropriate for the current architecture because:
    //   - FFT2 is configured in realtime mode, so its output cannot be stalled.
    //   - The system-level top ties i_power_tready high.
    //
    // Therefore this block is intentionally a fixed-throughput pipeline: One sample per engine per clock, with bubbles represented only by VALID=0.
    // -------------------------------------------------------------------------

    // Stage 0: registered FFT2/bin-filter components.
    logic signed [COMPONENT_W - 1 : 0] r_re_s0    [N_ENGINES];
    logic signed [COMPONENT_W - 1 : 0] r_im_s0    [N_ENGINES];
    logic                              r_valid_s0 [N_ENGINES];
    logic                              r_last_s0  [N_ENGINES];

    // Stage 1: component squares.
    logic [2*COMPONENT_W - 1 : 0] r_square_re [N_ENGINES];
    logic [2*COMPONENT_W - 1 : 0] r_square_im [N_ENGINES];
    logic                         r_valid_s1  [N_ENGINES];
    logic                         r_last_s1   [N_ENGINES];

    // Stage 2: power sum.
    logic [POWER_WIDTH - 1 : 0] r_power_s2 [N_ENGINES];
    logic                       r_valid_s2 [N_ENGINES];
    logic                       r_last_s2  [N_ENGINES];

    // Stage 3: threshold comparison and output alignment.
    logic [POWER_WIDTH - 1 : 0] r_power_s3  [N_ENGINES];
    logic                       r_valid_s3  [N_ENGINES];
    logic                       r_last_s3   [N_ENGINES];
    logic                       r_detect_s3 [N_ENGINES];

    // Number of detections accepted during the current clock cycle.
    logic [$clog2(N_ENGINES+1) - 1 : 0] w_detect_inc;

    // -------------------------------------------------------------------------
    // Fixed-throughput interface assignments.
    // -------------------------------------------------------------------------
    always_comb begin
        for (int eng = 0; eng < N_ENGINES; eng++) begin
            // No internal backpressure path: when enabled, the detector accepts every sample presented by the FFT2/bin-filter chain.
            o_s_axis_tready[eng] = i_enable;
            o_power_tdata[eng]   = r_power_s3[eng];
            o_power_tvalid[eng]  = r_valid_s3[eng];
            o_power_tlast[eng]   = r_last_s3[eng] && r_valid_s3[eng];
            o_detect[eng]        = r_detect_s3[eng] && r_valid_s3[eng];
        end
    end

    // -------------------------------------------------------------------------
    // Fixed pipeline.
    //
    // Important timing property:
    // Datapath registers are updated every enabled clock, independent of VALID.
    // Invalid cycles simply propagate VALID = 0 and their numerical data is ignored. 
    // This prevents VALID/configuration logic from becoming a CE path into the wide DSP/register structures.
    // -------------------------------------------------------------------------
    always_ff @(posedge clock) begin : POWER_PIPELINE

        if (i_reset || i_clear) begin
            for (int eng = 0; eng < N_ENGINES; eng++) begin

                // Stage 0
                r_re_s0[eng]    <= '0;
                r_im_s0[eng]    <= '0;
                r_valid_s0[eng] <= '0;
                r_last_s0[eng]  <= '0;

                // Stage 1
                r_square_re[eng] <= '0;
                r_square_im[eng] <= '0;
                r_valid_s1[eng]  <= '0;
                r_last_s1[eng]   <= '0;

                // Stage 2
                r_power_s2[eng] <= '0;
                r_valid_s2[eng] <= '0;
                r_last_s2[eng]  <= '0;

                // Stage 3
                r_power_s3[eng]  <= '0;
                r_valid_s3[eng]  <= '0;
                r_last_s3[eng]   <= '0;
                r_detect_s3[eng] <= '0;
            end
        end
        else if (i_enable) begin
            for (int eng = 0; eng < N_ENGINES; eng++) begin

                // -------------------------------------------------------------
                // Stage 3: threshold comparison.
                // -------------------------------------------------------------
                r_power_s3[eng]  <= r_power_s2[eng];
                r_detect_s3[eng] <= (r_power_s2[eng] > i_threshold);

                r_valid_s3[eng] <= r_valid_s2[eng];
                r_last_s3[eng]  <= r_last_s2[eng];

                // -------------------------------------------------------------
                // Stage 2: add squared real and imaginary components.
                // -------------------------------------------------------------
                r_power_s2[eng] <= {1'b0, r_square_re[eng]} + {1'b0, r_square_im[eng]};
                r_valid_s2[eng] <= r_valid_s1[eng];
                r_last_s2[eng]  <= r_last_s1[eng];

                // -------------------------------------------------------------
                // Stage 1: square registered real and imaginary components.
                // -------------------------------------------------------------
                r_square_re[eng] <= $signed(r_re_s0[eng]) * $signed(r_re_s0[eng]);
                r_square_im[eng] <= $signed(r_im_s0[eng]) * $signed(r_im_s0[eng]);

                r_valid_s1[eng] <= r_valid_s0[eng];
                r_last_s1[eng]  <= r_last_s0[eng];

                // -------------------------------------------------------------
                // Stage 0: register FFT2/bin-filter input.
                // -------------------------------------------------------------
                r_re_s0[eng] <= $signed(i_s_axis_tdata[eng][COMPONENT_W-1:0]);
                r_im_s0[eng] <= $signed(i_s_axis_tdata[eng][DATA_WIDTH-1:COMPONENT_W]);

                r_valid_s0[eng] <= i_s_axis_tvalid[eng];
                r_last_s0[eng]  <= i_s_axis_tlast[eng] && i_s_axis_tvalid[eng];
            end
        end
    end

    // -------------------------------------------------------------------------
    // Detection counter.
    //
    // The current system always keeps i_power_tready asserted. 
    // Keeping the ready term here preserves the original meaning: count only output samples accepted by the downstream block.
    // -------------------------------------------------------------------------
    always_comb begin
        w_detect_inc = '0;
        for (int eng = 0; eng < N_ENGINES; eng++) begin
            if (r_valid_s3[eng] && i_power_tready[eng] && r_detect_s3[eng]) w_detect_inc = w_detect_inc + 1'b1;
        end
    end

    always_ff @(posedge clock) begin : DETECTION_COUNTER
        if      (i_reset || i_clear             ) o_detect_counter <= '0;
        else if (i_enable && (w_detect_inc != 0)) o_detect_counter <= o_detect_counter + w_detect_inc;
        else                                      o_detect_counter <= o_detect_counter;
    end

endmodule
