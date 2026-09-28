module threshold_calculator #(
    parameter integer N_NOISE_SAMPLES_MAX = 1024,
    parameter integer N_DATA_SAMPLES      = 1024,
    parameter integer NB_DATA             = 12,
    parameter integer NBF_DATA            = 9,
    parameter integer NB_THRESHOLD        = 65,
    parameter integer NBF_THRESHOLD       = 62
) (
    input  logic                                                          clock,
    input  logic                                                          i_enable,
    input  logic                                                          i_reset,
    input  logic                                                          i_scd_mode,

    input  logic        [1                                           : 0] i_win_sel,
    input  logic        [$clog2(N_NOISE_SAMPLES_MAX)                 : 0] i_noise_size,
    input  logic        [$clog2(N_DATA_SAMPLES)                      : 0] i_data_size,
    input  logic signed [NB_DATA                                 - 1 : 0] i_data_sample,
    input  logic        [3                                           : 0] i_pfa,

    output logic signed [NB_THRESHOLD                            - 1 : 0] o_estimated_threshold,
    output logic signed [2*NB_DATA + $clog2(N_NOISE_SAMPLES_MAX) - 1 : 0] o_estimared_noise_power,

    // sticky status for PS polling, goes high only when the final threshold has been calculated and registered cleared only by i_reset
    output logic                                                          o_thres_est_done
);

    // =========================================================================
    // Fixed-point widths
    // =========================================================================

    localparam integer NB_MACC_OUT        = 2*NB_DATA + $clog2(N_NOISE_SAMPLES_MAX); // MACC N samples, NB_DATA bits each.
    localparam integer NBF_MACC_OUT       = 2*NBF_DATA;
    localparam integer N_PFA              = 10;
    localparam integer NB_BASE_THRESHOLD  = NB_THRESHOLD;
    localparam integer NBF_BASE_THRESHOLD = NBF_THRESHOLD;
    localparam integer NB_VAR_SQ          = 2*NB_MACC_OUT; // variance^2 full-precision width
    localparam integer NB_PROD            = NB_VAR_SQ + NB_BASE_THRESHOLD; // final product: base_threshold * variance * variance
    localparam integer NBF_PROD           = 2*NBF_MACC_OUT + NBF_BASE_THRESHOLD;
    localparam integer NBI_TRUNC          = (NB_PROD - NBF_PROD) - ((NB_THRESHOLD - NBF_THRESHOLD) - 1); // truncation/saturation rule.
    localparam integer SEQ_MULT_CNT_W     = $clog2(NB_BASE_THRESHOLD); // sequential multiplier iterates over the base-threshold operand.

    // =========================================================================
    // Noise estimator / ROM signals
    // =========================================================================

    logic signed [NB_MACC_OUT       - 1 : 0] r_estimated_var;
    logic signed [NB_BASE_THRESHOLD - 1 : 0] r_base_threshold;
    logic                                    w_var_done;

    // =========================================================================
    // stage 1: variance^2
    //
    // this multiplier is intentionally kept parallel, it is much smaller than
    // the former 65x68 threshold product and executes only once per H0 estimate
    // =========================================================================

    logic signed [NB_VAR_SQ - 1 : 0] r_var_sq;
    logic                            r_var_sq_valid;

    // =========================================================================
    // stage 2: sequential base_threshold * variance^2
    //
    // both operands are non-negative by construction:
    //   - variance^2 >= 0
    //   - base thresholds stored in ROM are positive
    //
    // therefore an unsigned bit-serial shift/add multiplication preserves the
    // exact full-precision product bits while avoiding the large parallel
    // multiplier that previously consumed many DSP48s
    // =========================================================================

    logic [NB_PROD           - 1 : 0] r_seq_accum;
    logic [NB_PROD           - 1 : 0] r_seq_multiplicand;
    logic [NB_BASE_THRESHOLD - 1 : 0] r_seq_multiplier;
    logic [SEQ_MULT_CNT_W    - 1 : 0] r_seq_count;
    logic                             r_seq_busy;
    logic                             r_seq_done;

    // prevent vivado from trying to map arithmetic in this iterative datapath into DSP resources. 
    // no '*' operator exists in this stage
    (* use_dsp = "no" *) logic [NB_PROD - 1 : 0] w_seq_accum_next;

    assign w_seq_accum_next = r_seq_accum + (r_seq_multiplier[0] ? r_seq_multiplicand : {NB_PROD{1'b0}});

    // =========================================================================
    // final product / resize
    // =========================================================================

    logic signed [NB_PROD      - 1 : 0] r_threshold_value;
    logic                               r_prod_valid;
    logic signed [NB_THRESHOLD - 1 : 0] w_threshold;
    logic signed [NB_THRESHOLD - 1 : 0] r_threshold;

    // =========================================================================
    // threshold calculation pipeline
    //
    //   - noise variance valid
    //   - variance * variance         -> parallel, registered
    //   - base_threshold * variance^2 -> sequential shift/add (~65 clocks)
    //   - full product register
    //   - truncate / saturate
    //   - final threshold + sticky done
    // =========================================================================

    always_ff @(posedge clock) begin : threshold_pipeline
        if (i_reset) begin
            r_var_sq            <= '0;
            r_var_sq_valid      <= '0;

            r_seq_accum         <= '0;
            r_seq_multiplicand  <= '0;
            r_seq_multiplier    <= '0;
            r_seq_count         <= '0;
            r_seq_busy          <= '0;
            r_seq_done          <= '0;

            r_threshold_value   <= '0;
            r_prod_valid        <= '0;

            r_threshold         <= '0;
            o_thres_est_done    <= '0;
        end
        else begin
            // internal valid/done signals are one-clock pulses.
            r_var_sq_valid <= w_var_done;
            r_seq_done     <= '0;
            r_prod_valid   <= '0;

            // -----------------------------------------------------------------
            // stage 1: sigma^2 * sigma^2
            // -----------------------------------------------------------------
            if (w_var_done) r_var_sq <= r_estimated_var * r_estimated_var;

            // -----------------------------------------------------------------
            // stage 2 start:
            // capture both operands so ROM/config inputs may change later
            // without affecting an active multiplication.
            // -----------------------------------------------------------------
            if (r_var_sq_valid && !r_seq_busy) begin
                r_seq_accum <= '0;

                r_seq_multiplicand <= {{NB_BASE_THRESHOLD{1'b0}}, r_var_sq};
                r_seq_multiplier   <= r_base_threshold[NB_BASE_THRESHOLD-1:0];

                r_seq_count <= '0;
                r_seq_busy  <= 1'b1;
            end

            // -----------------------------------------------------------------
            // stage 2 iteration:
            // one multiplier bit is consumed per clock.
            //
            // for NB_THRESHOLD = 65 this takes exactly 65 cycles.
            // -----------------------------------------------------------------
            else if (r_seq_busy) begin
                r_seq_accum        <= w_seq_accum_next;
                r_seq_multiplicand <= r_seq_multiplicand << 1;
                r_seq_multiplier   <= r_seq_multiplier >> 1;

                if (r_seq_count == NB_BASE_THRESHOLD-1) begin
                    r_seq_busy <= 1'b0;
                    r_seq_done <= 1'b1;

                    // w_seq_accum_next includes the contribution of the final multiplier bit, unlike r_seq_accum at this clock edge.
                    r_threshold_value <= $signed(w_seq_accum_next);
                    r_prod_valid      <= 1'b1;
                end
                else r_seq_count <= r_seq_count + 1'b1;
            end

            // -----------------------------------------------------------------
            // stage 3:
            // register the resized threshold only after the complete sequential
            // product is available.
            //
            // o_thres_est_done remains sticky for easy PS polling.
            // -----------------------------------------------------------------
            if (r_prod_valid) begin
                r_threshold      <= w_threshold;
                o_thres_est_done <= 1'b1;
            end
        end
    end

    // =========================================================================
    // same truncation/saturation behavior as the original implementation
    // =========================================================================

    assign w_threshold = (~|r_threshold_value[NB_PROD - 1 -: NBI_TRUNC] || &r_threshold_value[NB_PROD - 1 -: NBI_TRUNC]) ? r_threshold_value[NB_PROD - NBI_TRUNC -: NB_THRESHOLD]
                       : (r_threshold_value[NB_PROD - 1]) ? {1'b1, {NB_THRESHOLD - 1{1'b0}}} : {1'b0, {NB_THRESHOLD - 1{1'b1}}};

    assign o_estimated_threshold   = r_threshold;
    assign o_estimared_noise_power = r_estimated_var;

    // =========================================================================
    // threshold ROM
    // =========================================================================

    threshold_rom #(
        .N_PFA  (N_PFA            ),
        .NB_OUT (NB_BASE_THRESHOLD)) 
    threshold_rom_inst (
        .clock       (clock           ),
        .i_scd_mode  (i_scd_mode      ),
        .i_pfa_value (i_pfa           ),
        .i_win_sel   (i_win_sel       ),
        .i_data_size (i_data_size     ),
        .o_threshold (r_base_threshold));

    // =========================================================================
    // noise variance estimator
    // =========================================================================

    noise_calc #(
        .NB_DATA   (NB_DATA            ),
        .N_SAMPLES (N_NOISE_SAMPLES_MAX),
        .NB_OUT    (NB_MACC_OUT        )) 
    noise_calc_inst (
        .clk          (clock          ),
        .i_reset      (i_reset        ),
        .i_cenable    (i_enable       ),
        .i_noise_size (i_noise_size   ),
        .i_data       (i_data_sample  ),
        .o_variance   (r_estimated_var),
        .o_div_done   (w_var_done     ));

endmodule
