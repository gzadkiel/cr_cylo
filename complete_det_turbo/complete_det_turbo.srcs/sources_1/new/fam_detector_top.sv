module fam_detector_top #(
    parameter integer N_DESIRED_MAX        = 1024,
    parameter integer NP                   = 32,
    parameter integer P_MIN                = 8,
    parameter integer P_MAX                = 128,
    parameter integer N_BANKS              = 4,
    parameter integer N_ENGINES            = 4,

    parameter integer NB_SAMPLE_DATA       = 12,
    parameter integer NBF_SAMPLE_DATA      = 9,
    parameter integer NB_WINDOW_COEFF      = 8,
    parameter integer NBF_WINDOW_COEFF     = 7,
    parameter integer FFT1_COMP_W          = 16,
    parameter integer FFT1_COMP_F          = 13,

    parameter integer N_NOISE_SAMPLES_MAX  = 1024,
    parameter integer NBF_NOISE_DATA       = 9,
    parameter integer NB_THRESHOLD         = 65,
    parameter integer NBF_THRESHOLD        = 62,

    parameter integer FFT2_COMP_W          = 32,
    parameter integer FFT2_DATA_WIDTH      = 2 * FFT2_COMP_W,
    parameter integer POWER_WIDTH          = 2 * FFT2_COMP_W + 1,
    parameter integer NB_DETECT            = 16,

    parameter integer FFT1_CONFIG_WIDTH    = 7,
    parameter integer FFT2_CONFIG_WIDTH    = 17,

    // detector can operate in either:
    //  full mode    -> P   bins / pair
    //  reduced mode -> P/2 bins / pair
    // size the completion counter for the larger, full-mode case:
    parameter integer PAIR_COUNT           = (NP * (NP - 1)) / 2,
    parameter integer MAX_OUTPUT_BINS      = P_MAX,
    parameter integer MAX_POWER_SAMPLES    = PAIR_COUNT * MAX_OUTPUT_BINS,
    parameter integer POWER_COUNT_W        = (MAX_POWER_SAMPLES <= 1) ? 1 : $clog2(MAX_POWER_SAMPLES + 1),
    
    parameter integer NOISE_POWER_WIDTH    = 2*NB_SAMPLE_DATA + $clog2(N_NOISE_SAMPLES_MAX)
) (
    input  logic                                          clock,
    input  logic                                          i_reset,
    input  logic                                          i_enable,

    // same high-level control philosophy as the original top
    // these are transaction-level flags, not AXI-stream-ish valid signals
    input  logic                                          i_noise_data_valid,
    input  logic                                          i_signal_data_valid,

    input  logic        [1                           : 0] i_window_sel,
    input  logic        [$clog2(N_DESIRED_MAX)       : 0] i_data_size,
    input  logic        [$clog2(N_NOISE_SAMPLES_MAX) : 0] i_noise_size,
    input  logic signed [NB_SAMPLE_DATA          - 1 : 0] i_data_re,
    input  logic signed [NB_SAMPLE_DATA          - 1 : 0] i_data_im,
    input  logic        [3                           : 0] i_pfa_value,
    input  logic                                          i_scd_mode,

    // High-level outputs only.
    output logic signed [NB_THRESHOLD            - 1 : 0] o_threshold,
    output logic signed [NOISE_POWER_WIDTH       - 1 : 0] o_noise_pow,
    output logic        [NB_DETECT               - 1 : 0] o_detect,
    output logic                                          o_detection_done,
    output logic                                          o_threshold_est_done,
    output logic                                          o_error,
    
    // rxternal source handshake for ComBlock/FIFO adapters.
    // asserted exactly when one real external signal sample is consumed.
    output logic                                          o_signal_sample_request
);

    // =========================================================================
    // Local configuration register replicas
    //
    // These registers intentionally create local copies of the transaction
    // configuration for the main detector regions. This avoids distributing
    // the ComBlock adapter configuration registers directly across the device
    // and gives Vivado independent register sources that can be placed close
    // to each consumer block.
    //
    // Configuration is already stable well before NOISE/SIGNAL streaming
    // begins in the ComBlock adapter, so this additional register boundary
    // does not change the detector transaction behavior.
    // =========================================================================

    // Threshold estimator copies.
    (* keep = "true" *)
    logic        [$clog2(N_DESIRED_MAX)       : 0] r_cfg_th_data_size;
    (* keep = "true" *)
    logic        [$clog2(N_NOISE_SAMPLES_MAX) : 0] r_cfg_th_noise_size;
    (* keep = "true" *)
    logic        [1                           : 0] r_cfg_th_window_sel;
    (* keep = "true" *)
    logic        [3                           : 0] r_cfg_th_pfa_value;
    (* keep = "true" *)
    logic                                          r_cfg_th_scd_mode;

    // First-stage copies.
    (* keep = "true" *)
    logic        [$clog2(N_DESIRED_MAX)       : 0] r_cfg_fs_data_size;
    (* keep = "true" *)
    logic        [1                           : 0] r_cfg_fs_window_sel;

    // Second-stage copies.
    (* keep = "true" *)
    logic        [$clog2(N_DESIRED_MAX)       : 0] r_cfg_ss_data_size;
    (* keep = "true" *)
    logic                                          r_cfg_ss_scd_mode;

    // Input/sample-control copies.
    (* keep = "true" *)
    logic        [$clog2(N_DESIRED_MAX)       : 0] r_cfg_input_data_size;

    // Detection-completion copies.
    (* keep = "true" *)
    logic        [$clog2(N_DESIRED_MAX)       : 0] r_cfg_det_data_size;
    (* keep = "true" *)
    logic                                          r_cfg_det_scd_mode;

    always_ff @(posedge clock) begin : CONFIG_REGISTER_REPLICATION
        if (i_reset) begin
            r_cfg_th_data_size    <= '0;
            r_cfg_th_noise_size   <= '0;
            r_cfg_th_window_sel   <= '0;
            r_cfg_th_pfa_value    <= '0;
            r_cfg_th_scd_mode     <= '0;

            r_cfg_fs_data_size    <= '0;
            r_cfg_fs_window_sel   <= '0;

            r_cfg_ss_data_size    <= '0;
            r_cfg_ss_scd_mode     <= '0;

            r_cfg_input_data_size <= '0;

            r_cfg_det_data_size   <= '0;
            r_cfg_det_scd_mode    <= '0;
        end
        else begin
            // Each destination region receives its own physical register copy.
            r_cfg_th_data_size    <= i_data_size;
            r_cfg_th_noise_size   <= i_noise_size;
            r_cfg_th_window_sel   <= i_window_sel;
            r_cfg_th_pfa_value    <= i_pfa_value;
            r_cfg_th_scd_mode     <= i_scd_mode;

            r_cfg_fs_data_size    <= i_data_size;
            r_cfg_fs_window_sel   <= i_window_sel;

            r_cfg_ss_data_size    <= i_data_size;
            r_cfg_ss_scd_mode     <= i_scd_mode;

            r_cfg_input_data_size <= i_data_size;

            r_cfg_det_data_size   <= i_data_size;
            r_cfg_det_scd_mode    <= i_scd_mode;
        end
    end

    // =========================================================================
    // runtime FAM dimensions
    // =========================================================================
    localparam integer L     = NP / 4;
    localparam integer L_DIV = $clog2(L);

    // P = N/L. Keep independent copies for the physical regions that use P.
    // This avoids recreating another high-fanout cross-device configuration net.
    logic [$clog2(P_MAX) : 0] w_p_frames_fs;
    logic [$clog2(P_MAX) : 0] w_p_frames_ss;
    logic [$clog2(P_MAX) : 0] w_p_frames_input;
    logic [$clog2(P_MAX) : 0] w_p_frames_det;

    // Total number of time-domain samples required by overlapping windows:
    // N_tot = (P-1)L + NP.
    localparam integer INPUT_COUNT_W = $clog2(N_DESIRED_MAX + NP + 1);

    logic [INPUT_COUNT_W - 1 : 0] w_n_tot;

    assign w_p_frames_fs    = r_cfg_fs_data_size    >> L_DIV;
    assign w_p_frames_ss    = r_cfg_ss_data_size    >> L_DIV;
    assign w_p_frames_input = r_cfg_input_data_size >> L_DIV;
    assign w_p_frames_det   = r_cfg_det_data_size   >> L_DIV;

    assign w_n_tot = ((w_p_frames_input - 1'b1) << L_DIV) + NP;

    // =========================================================================
    // high-level SCD run control
    // =========================================================================
    logic r_signal_valid_d;
    logic r_scd_run;
    logic w_scd_start;
    logic w_scd_core_done;
    logic w_scd_error;

    assign w_scd_start = i_enable && i_signal_data_valid && !r_signal_valid_d;

    always_ff @(posedge clock) begin
        if (i_reset) begin
            r_signal_valid_d <= '0;
            r_scd_run        <= '0;
        end
        else begin
            r_signal_valid_d <= i_signal_data_valid;

            if      (!i_enable      ) r_scd_run <= '0;
            else if (w_scd_start    ) r_scd_run <= '1;
            else if (w_scd_core_done) r_scd_run <= '0;
        end
    end

    // =========================================================================
    // threshold estimator
    // =========================================================================
    logic signed [NB_THRESHOLD      - 1 : 0] w_threshold;
    logic signed [NOISE_POWER_WIDTH - 1 : 0] w_noise_power;
    logic                                    w_threshold_done;

    threshold_calculator #(
        .N_NOISE_SAMPLES_MAX (N_NOISE_SAMPLES_MAX),
        .N_DATA_SAMPLES      (N_DESIRED_MAX      ),
        .NB_DATA             (NB_SAMPLE_DATA     ),
        .NBF_DATA            (NBF_NOISE_DATA     ),
        .NB_THRESHOLD        (NB_THRESHOLD       ),
        .NBF_THRESHOLD       (NBF_THRESHOLD      )) 
    u_threshold_calculator (
        .clock                   (clock                         ),
        .i_enable                (i_enable && i_noise_data_valid),
        .i_reset                 (i_reset                       ),
        .i_scd_mode              (r_cfg_th_scd_mode             ),
        .i_win_sel               (r_cfg_th_window_sel           ),
        .i_noise_size            (r_cfg_th_noise_size           ),
        .i_data_size             (r_cfg_th_data_size            ),
        .i_data_sample           (i_data_re                     ),
        .i_pfa                   (r_cfg_th_pfa_value            ),
        .o_estimated_threshold   (w_threshold                   ),
        .o_estimared_noise_power (w_noise_power                 ),
        .o_thres_est_done        (w_threshold_done              ));

    assign o_threshold          = w_threshold;
    assign o_noise_pow          = w_noise_power;
    assign o_threshold_est_done = w_threshold_done;

    // =========================================================================
    // SCD input sample controller / zero padding
    // =========================================================================
    //
    // the external source provides exactly i_data_size complex samples.
    // the FAM windowing process requires:
    //
    //      N_tot = (P-1)*L + NP
    //
    // time-domain sample positions in order to generate P complete,
    // overlapping NP-point windows. Once the N real input samples have been
    // consumed, the remaining N_tot-N positions are generated internally as
    // complex zeros
    //
    // Example for N = 1024, NP = 32, L = 8:
    //
    //      P     = 128
    //      N_tot = 1048
    //
    // so the source supplies 1024 samples and this top appends 24 zeros.
    //
    // The counter advances ONLY when first_stage_wrapper actually consumes a
    // sample. This excludes its FFT configuration/startup cycles.
    // =========================================================================

    logic        [INPUT_COUNT_W  - 1 : 0] r_scd_input_count;

    logic signed [NB_SAMPLE_DATA - 1 : 0] w_scd_input_re;
    logic signed [NB_SAMPLE_DATA - 1 : 0] w_scd_input_im;

    logic w_first_stage_input_enable;

    // internal source-side handshake useful for the future FIFO/ComBlock controller
    //  w_take_signal_sample = 1 -> consume one external input sample
    //  w_padding_sample     = 1 -> inject an internally generated complex zero

    logic w_take_signal_sample;
    logic w_padding_sample;

    assign w_take_signal_sample = r_scd_run && w_first_stage_input_enable && (r_scd_input_count < r_cfg_input_data_size);
    assign w_padding_sample     = r_scd_run && w_first_stage_input_enable && (r_scd_input_count >= r_cfg_input_data_size) && (r_scd_input_count < w_n_tot);
    
    assign o_signal_sample_request = w_take_signal_sample;

    always_comb begin
        if (r_scd_input_count < r_cfg_input_data_size) begin
            w_scd_input_re = i_data_re;
            w_scd_input_im = i_data_im;
        end
        else begin
            // zero padding after the N external samples have been consumed.
            // if the first-stage pipeline remains enabled for a couple of
            // drain cycles after N_tot, keeping zeros here is also harmless.
            w_scd_input_re = '0;
            w_scd_input_im = '0;
        end
    end

    always_ff @(posedge clock) begin : scd_input_sample_counter
        if      (i_reset || w_scd_start                                                  ) r_scd_input_count <= '0;
        else if (r_scd_run && w_first_stage_input_enable && (r_scd_input_count < w_n_tot)) r_scd_input_count <= r_scd_input_count + 1'b1;
    end

    // =========================================================================
    // first-stage <-> second-stage streams
    // =========================================================================
    logic [2*FFT1_COMP_W - 1 : 0] w_fft1_tdata  [N_BANKS];
    logic                         w_fft1_tvalid [N_BANKS];
    logic                         w_fft1_tlast  [N_BANKS];
    logic                         w_fft1_tready [N_BANKS];
    logic                         w_first_stage_overflow;

    first_stage_wrapper #(
        .NP               (NP               ),
        .P_MAX            (P_MAX            ),
        .NB_SAMPLES       (NB_SAMPLE_DATA   ),
        .NBF_SAMPLES      (NBF_SAMPLE_DATA  ),
        .NB_WINDOWS       (NB_WINDOW_COEFF  ),
        .NBF_WINDOWS      (NBF_WINDOW_COEFF ),
        .NB_DATA          (FFT1_COMP_W      ),
        .NBF_DATA         (FFT1_COMP_F      ),
        .N_FFT            (N_BANKS          ),
        .AXI_CONFIG_WIDTH (FFT1_CONFIG_WIDTH)) 
    u_first_stage (
        .clock                     (clock                     ),
        .i_reset                   (i_reset                   ),
        .i_enable                  (r_scd_run                 ),
        .i_scd_done                (w_scd_core_done           ),
        .i_p_frames                (w_p_frames_fs             ),
        .i_window_sel              (r_cfg_fs_window_sel       ),
        .i_x_re                    (w_scd_input_re            ),
        .i_x_im                    (w_scd_input_im            ),

        .o_fft1_m_axis_data_tdata  (w_fft1_tdata              ),
        .o_fft1_m_axis_data_tvalid (w_fft1_tvalid             ),
        .o_fft1_m_axis_data_tlast  (w_fft1_tlast              ),
        .i_fft1_m_axis_data_tready (w_fft1_tready             ),

        .o_frame_overflow          (w_first_stage_overflow    ),
        .o_input_sample_enable     (w_first_stage_input_enable));

    // =========================================================================
    // second-stage -> detector streams
    // =========================================================================
    localparam integer Q_WIDTH           = $clog2(P_MAX) + 2;
    localparam integer FFT_BIN_IDX_WIDTH = $clog2(P_MAX);
    localparam integer BIN_WIDTH         = $clog2(NP);
    localparam integer PAIR_ID_WIDTH     = $clog2(PAIR_COUNT);
    localparam integer DONE_COUNT_WIDTH  = $clog2(PAIR_COUNT + 1);

    logic [FFT2_DATA_WIDTH - 1 : 0] w_scd_tdata  [N_ENGINES];
    logic                           w_scd_tvalid [N_ENGINES];
    logic                           w_scd_tlast  [N_ENGINES];
    logic                           w_scd_tready [N_ENGINES];

    // Internal debug/metadata. Available hierarchically in simulation/ILA.
    logic        [FFT_BIN_IDX_WIDTH - 1 : 0] w_fft_bin_index [N_ENGINES];
    logic signed [Q_WIDTH           - 1 : 0] w_q_index       [N_ENGINES];

    logic [BIN_WIDTH     - 1 : 0] w_pair_i     [N_ENGINES];
    logic [BIN_WIDTH     - 1 : 0] w_pair_j     [N_ENGINES];
    logic [PAIR_ID_WIDTH - 1 : 0] w_pair_id    [N_ENGINES];
    logic                         w_pair_tlast [N_ENGINES];

    logic                            w_second_busy;
    logic                            w_second_load_done;
    logic                            w_second_pair_done;
    logic                            w_second_config_done;
    logic [DONE_COUNT_WIDTH - 1 : 0] w_fft2_frames_done;

    logic w_backpressure_error;
    logic w_fft2_tlast_unexpected;
    logic w_fft2_tlast_missing;

    second_stage_wrapper #(
        .N_BANKS           (N_BANKS          ),
        .N_ENGINES         (N_ENGINES        ),
        .NP                (NP               ),
        .P_MIN             (P_MIN            ),
        .P_MAX             (P_MAX            ),
        .NB_DATA           (FFT1_COMP_W      ),
        .FFT2_CONFIG_WIDTH (FFT2_CONFIG_WIDTH),
        .FFT2_DATA_WIDTH   (FFT2_DATA_WIDTH  )) 
    u_second_stage (
        .clock                       (clock                     ),
        .i_reset                     (i_reset                   ),
        .i_enable                    (r_scd_run                 ),
        .i_p_frames                  (w_p_frames_ss             ),
        .i_scd_mode                  (r_cfg_ss_scd_mode         ),

        .i_fft1_m_axis_data_tdata    (w_fft1_tdata              ),
        .i_fft1_m_axis_data_tvalid   (w_fft1_tvalid             ),
        .i_fft1_m_axis_data_tlast    (w_fft1_tlast              ),
        .o_fft1_m_axis_data_tready   (w_fft1_tready             ),

        .o_scd_tdata                 (w_scd_tdata               ),
        .o_scd_tvalid                (w_scd_tvalid              ),
        .o_scd_tlast                 (w_scd_tlast               ),
        .i_scd_tready                (w_scd_tready              ),

        .o_fft_bin_index             (w_fft_bin_index           ),
        .o_q_index                   (w_q_index                 ),

        .o_pair_i                    (w_pair_i                  ),
        .o_pair_j                    (w_pair_j                  ),
        .o_pair_id                   (w_pair_id                 ),
        .o_pair_tlast                (w_pair_tlast              ),

        .o_busy                      (w_second_busy             ),
        .o_done                      (w_scd_core_done           ),
        .o_error                     (w_scd_error               ),
        .o_load_done                 (w_second_load_done        ),
        .o_pair_done                 (w_second_pair_done        ),
        .o_config_done               (w_second_config_done      ),
        .o_fft2_frames_done          (w_fft2_frames_done        ),

        .o_backpressure_error        (w_backpressure_error      ),
        .o_fft2_tlast_unexpected     (w_fft2_tlast_unexpected   ),
        .o_fft2_tlast_missing        (w_fft2_tlast_missing      ));

    // =========================================================================
    // detection compare
    // =========================================================================

    logic [POWER_WIDTH - 1 : 0] w_power_tdata  [N_ENGINES];
    logic                       w_power_tvalid [N_ENGINES];
    logic                       w_power_tlast  [N_ENGINES];
    logic                       w_power_tready [N_ENGINES];
    logic                       w_detect       [N_ENGINES];

    logic [NB_DETECT  - 1  : 0] w_detect_counter;

    generate
        for (genvar eng = 0; eng < N_ENGINES; eng++) begin : GEN_POWER_READY
            // the real detector always consumes every computed power sample.
            assign w_power_tready[eng] = 1'b1;
        end
    endgenerate

    detection_compare_parallel #(
        .N_ENGINES   (N_ENGINES      ),
        .COMPONENT_W (FFT2_COMP_W    ),
        .DATA_WIDTH  (FFT2_DATA_WIDTH),
        .POWER_WIDTH (POWER_WIDTH    ),
        .NB_DETECT   (NB_DETECT      )) 
    u_detection_compare (
        .clock            (clock           ),
        .i_reset          (i_reset         ),
        .i_clear          (w_scd_start     ),
        .i_enable         (1'b1            ),

        .i_threshold      (w_threshold     ),

        .i_s_axis_tdata   (w_scd_tdata     ),
        .i_s_axis_tvalid  (w_scd_tvalid    ),
        .i_s_axis_tlast   (w_scd_tlast     ),
        .o_s_axis_tready  (w_scd_tready    ),

        .o_power_tdata    (w_power_tdata   ),
        .o_power_tvalid   (w_power_tvalid  ),
        .o_power_tlast    (w_power_tlast   ),
        .i_power_tready   (w_power_tready  ),

        .o_detect         (w_detect        ),
        .o_detect_counter (w_detect_counter));

    assign o_detect = w_detect_counter;

    // =========================================================================
    // robust final detection completion
    // =========================================================================
    // number of detector samples per (i,j) pair depends on i_scd_mode:
    //
    //  i_scd_mode = 0 (full)    -> P samples
    //  i_scd_mode = 1 (reduced) -> P/2 samples
    //
    // rherefore:
    //
    //  full    : PAIR_COUNT * P
    //  reduced : PAIR_COUNT * P/2
    //
    // count actual detector outputs rather than assuming a fixed pipeline delay.
    logic [POWER_COUNT_W      - 1 : 0] r_power_count;
    logic [POWER_COUNT_W      - 1 : 0] w_expected_power_samples;
    logic [$clog2(N_ENGINES+1)- 1 : 0] w_power_valid_count;

    assign w_expected_power_samples = r_cfg_det_scd_mode ? (PAIR_COUNT * (w_p_frames_det >> 1))  // reduced: P/2
                                                        : (PAIR_COUNT *  w_p_frames_det      ); // full: P

    always_comb begin
        w_power_valid_count = '0;
        for (int eng = 0; eng < N_ENGINES; eng++) begin
            if (w_power_tvalid[eng] && w_power_tready[eng]) w_power_valid_count = w_power_valid_count + 1'b1;
        end
    end

    always_ff @(posedge clock) begin
        if (i_reset) begin
            r_power_count    <= '0;
            o_detection_done <= '0;
        end
        else begin
            // match the software handshake used by the original design:
            // detection_done remains high while SIGNAL_VALID is held high,
            // and clears after software/testbench lowers it.
            if (!i_signal_data_valid) o_detection_done <= 1'b0;

            if (w_scd_start) begin
                r_power_count    <= '0;
                o_detection_done <= '0;
            end
            else if (!o_detection_done && (w_power_valid_count != 0)) begin
                if ((r_power_count + w_power_valid_count) >= w_expected_power_samples) begin
                    r_power_count    <= r_power_count + w_power_valid_count;
                    o_detection_done <= 1'b1;
                end
                else r_power_count <= r_power_count + w_power_valid_count;
            end
        end
    end

    // =========================================================================
    // consolidated top-level error
    // =========================================================================
    assign o_error = w_scd_error             ||
                     w_first_stage_overflow  ||
                     w_backpressure_error    ||
                     w_fft2_tlast_unexpected ||
                     w_fft2_tlast_missing;

endmodule
