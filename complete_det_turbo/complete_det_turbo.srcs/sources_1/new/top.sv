`timescale 1ns / 1ps

module fam_detector_system_top #(
    parameter integer NB_SAMPLE_DATA = 12,
    parameter integer N_SAMPLES_MAX  = 1024
)(
    // physical PS pins: pass straight through
    inout [14 : 0] DDR_addr,
    inout [2  : 0] DDR_ba,
    inout          DDR_cas_n,
    inout          DDR_ck_n,
    inout          DDR_ck_p,
    inout          DDR_cke,
    inout          DDR_cs_n,
    inout [3  : 0] DDR_dm,
    inout [31 : 0] DDR_dq,
    inout [3  : 0] DDR_dqs_n,
    inout [3  : 0] DDR_dqs_p,
    inout          DDR_odt,
    inout          DDR_ras_n,
    inout          DDR_reset_n,
    inout          DDR_we_n,
    inout          FIXED_IO_ddr_vrn,
    inout          FIXED_IO_ddr_vrp,
    inout [53 : 0] FIXED_IO_mio,
    inout          FIXED_IO_ps_clk,
    inout          FIXED_IO_ps_porb,
    inout          FIXED_IO_ps_srstb
);

    // =========================================================================
    // PS / ComBlock signals
    // =========================================================================

    logic        w_ps_clock;

    logic [31:0] w_cb_in_reg0;
    logic [31:0] w_cb_in_reg1;
    logic [31:0] w_cb_in_reg2;
    logic [31:0] w_cb_in_reg3;
    logic [31:0] w_cb_in_reg4;
    logic [31:0] w_cb_in_reg5;

    logic [31:0] w_cb_out_reg0;
    logic [31:0] w_cb_out_reg1;

    logic        w_cb_fifo_aempty;
    logic [23:0] w_cb_fifo_data;
    logic        w_cb_fifo_empty;
    logic        w_cb_fifo_re;
    logic        w_cb_fifo_underflow;
    logic        w_cb_fifo_valid;
    logic        w_cb_fifo_clear;

    // =========================================================================
    // ComBlock adapter <-> detector signals
    // =========================================================================

    logic        w_detector_reset;
    logic        w_detector_enable;
    logic        w_detector_noise_valid;
    logic        w_detector_signal_valid;

    logic [10:0] w_detector_data_size;
    logic [10:0] w_detector_noise_size;
    logic [1:0]  w_detector_window_sel;
    logic [3:0]  w_detector_pfa;
    logic        w_detector_scd_mode;

    logic signed [NB_SAMPLE_DATA-1:0] w_detector_data_re;
    logic signed [NB_SAMPLE_DATA-1:0] w_detector_data_im;

    logic signed [64:0] w_detector_threshold;
    logic signed [33:0] w_detector_noise_power;

    logic [15:0] w_detector_detect;
    logic        w_detector_detection_done;
    logic        w_detector_threshold_done;
    logic        w_detector_error;
    logic        w_detector_signal_sample_request;

    // Use the same PL clock for the ComBlock FPGA-side FIFO interface,
    // adapter, and detector. PS_CLOCK0 must be configured to the desired
    // detector clock frequency in the block design.
    assign w_cb_fifo_clear = w_detector_reset;

    // =========================================================================
    // Processing System + ComBlock block-design wrapper
    // =========================================================================

    ps_comblock_setup_wrapper u_ps_comblock_setup (
        .DDR_addr                       (DDR_addr),
        .DDR_ba                         (DDR_ba),
        .DDR_cas_n                      (DDR_cas_n),
        .DDR_ck_n                       (DDR_ck_n),
        .DDR_ck_p                       (DDR_ck_p),
        .DDR_cke                        (DDR_cke),
        .DDR_cs_n                       (DDR_cs_n),
        .DDR_dm                         (DDR_dm),
        .DDR_dq                         (DDR_dq),
        .DDR_dqs_n                      (DDR_dqs_n),
        .DDR_dqs_p                      (DDR_dqs_p),
        .DDR_odt                        (DDR_odt),
        .DDR_ras_n                      (DDR_ras_n),
        .DDR_reset_n                    (DDR_reset_n),
        .DDR_we_n                       (DDR_we_n),

        .FIXED_IO_ddr_vrn               (FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp               (FIXED_IO_ddr_vrp),
        .FIXED_IO_mio                   (FIXED_IO_mio),
        .FIXED_IO_ps_clk                (FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb               (FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb              (FIXED_IO_ps_srstb),

        .IN_REGS_0_reg0_i               (w_cb_in_reg0),
        .IN_REGS_0_reg1_i               (w_cb_in_reg1),
        .IN_REGS_0_reg2_i               (w_cb_in_reg2),
        .IN_REGS_0_reg3_i               (w_cb_in_reg3),
        .IN_REGS_0_reg4_i               (w_cb_in_reg4),
        .IN_REGS_0_reg5_i               (w_cb_in_reg5),

        .OUT_FIFO_0_fifo_aempty_o       (w_cb_fifo_aempty),
        .OUT_FIFO_0_fifo_data_o         (w_cb_fifo_data),
        .OUT_FIFO_0_fifo_empty_o        (w_cb_fifo_empty),
        .OUT_FIFO_0_fifo_re_i           (w_cb_fifo_re),
        .OUT_FIFO_0_fifo_underflow_o    (w_cb_fifo_underflow),
        .OUT_FIFO_0_fifo_valid_o        (w_cb_fifo_valid),

        .OUT_REGS_0_reg0_o              (w_cb_out_reg0),
        .OUT_REGS_0_reg1_o              (w_cb_out_reg1),

        .PS_CLOCK0                      (w_ps_clock),
        .fifo_clear_i_0                 (w_cb_fifo_clear),
        .fifo_clk_i_0                   (w_ps_clock)
    );

    // =========================================================================
    // ComBlock adapter
    // =========================================================================

    comblock_adapter #(
        .NB_SAMPLE_DATA (NB_SAMPLE_DATA),
        .N_SAMPLES_MAX  (N_SAMPLES_MAX)
    ) u_comblock_adapter (
        .clock                              (w_ps_clock),

        .i_cb_OUT_FIFO_0_fifo_aempty_o      (w_cb_fifo_aempty),
        .i_cb_OUT_FIFO_0_fifo_data_o        (w_cb_fifo_data),
        .i_cb_OUT_FIFO_0_fifo_empty_o       (w_cb_fifo_empty),
        .i_cb_OUT_FIFO_0_fifo_underflow_o   (w_cb_fifo_underflow),
        .i_cb_OUT_FIFO_0_fifo_valid_o       (w_cb_fifo_valid),
        .o_cb_OUT_FIFO_0_fifo_re_i          (w_cb_fifo_re),

        .i_cb_OUT_REGS_0_reg0_o             (w_cb_out_reg0),
        .i_cb_OUT_REGS_0_reg1_o             (w_cb_out_reg1),

        .o_cb_IN_REGS_0_reg0_i              (w_cb_in_reg0),
        .o_cb_IN_REGS_0_reg1_i              (w_cb_in_reg1),
        .o_cb_IN_REGS_0_reg2_i              (w_cb_in_reg2),
        .o_cb_IN_REGS_0_reg3_i              (w_cb_in_reg3),
        .o_cb_IN_REGS_0_reg4_i              (w_cb_in_reg4),
        .o_cb_IN_REGS_0_reg5_i              (w_cb_in_reg5),

        .top_mux_reset                      (w_detector_reset),
        .top_mux_enable                     (w_detector_enable),
        .top_mux_noise_data_valid           (w_detector_noise_valid),
        .top_mux_signal_data_valid          (w_detector_signal_valid),

        .top_mux_data_size                  (w_detector_data_size),
        .top_mux_noise_size                 (w_detector_noise_size),
        .top_mux_window_sel                 (w_detector_window_sel),
        .top_mux_pfa_value                  (w_detector_pfa),
        .top_mux_scd_mode                   (w_detector_scd_mode),

        .top_mux_data_re                    (w_detector_data_re),
        .top_mux_data_im                    (w_detector_data_im),
        .top_mux_signal_sample_request      (w_detector_signal_sample_request),

        .top_mux_threshold                  (w_detector_threshold),
        .top_mux_noise_power                (w_detector_noise_power),
        .top_mux_detect                     (w_detector_detect),
        .top_mux_detection_done             (w_detector_detection_done),
        .top_mux_threshold_est_done         (w_detector_threshold_done),
        .top_mux_error                      (w_detector_error)
    );

    // =========================================================================
    // FAM detector
    // =========================================================================

    fam_detector_top #(
        .N_DESIRED_MAX        (N_SAMPLES_MAX),
        .P_MAX                (128),
        .NB_SAMPLE_DATA       (NB_SAMPLE_DATA),
        .NBF_SAMPLE_DATA      (9),
        .N_NOISE_SAMPLES_MAX  (N_SAMPLES_MAX),
        .NBF_NOISE_DATA       (9),
        .NB_THRESHOLD         (65),
        .NBF_THRESHOLD        (62),
        .NB_DETECT            (16),
        .FFT2_CONFIG_WIDTH    (17)
    ) u_fam_detector (
        .clock                   (w_ps_clock),
        .i_reset                 (w_detector_reset),
        .i_enable                (w_detector_enable),

        .i_noise_data_valid      (w_detector_noise_valid),
        .i_signal_data_valid     (w_detector_signal_valid),

        .i_window_sel            (w_detector_window_sel),
        .i_data_size             (w_detector_data_size),
        .i_noise_size            (w_detector_noise_size),
        .i_data_re               (w_detector_data_re),
        .i_data_im               (w_detector_data_im),
        .i_pfa_value             (w_detector_pfa),
        .i_scd_mode              (w_detector_scd_mode),

        .o_threshold             (w_detector_threshold),
        .o_noise_pow             (w_detector_noise_power),
        .o_detect                (w_detector_detect),
        .o_detection_done        (w_detector_detection_done),
        .o_threshold_est_done    (w_detector_threshold_done),
        .o_error                 (w_detector_error),
        .o_signal_sample_request (w_detector_signal_sample_request)
    );

endmodule
