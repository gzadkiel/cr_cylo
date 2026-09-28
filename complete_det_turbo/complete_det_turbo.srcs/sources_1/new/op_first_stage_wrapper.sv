module first_stage_wrapper #(
    parameter integer NP               = 32,
    parameter integer P_MAX            = 128,
    parameter integer NB_SAMPLES       = 12,
    parameter integer NBF_SAMPLES      = 9,
    parameter integer NB_WINDOWS       = 8,
    parameter integer NBF_WINDOWS      = 7,
    parameter integer NB_DATA          = 16,
    parameter integer NBF_DATA         = 13,
    parameter integer N_FFT            = 4,
    parameter integer AXI_CONFIG_WIDTH = 7
) (
    input  logic                            clock,
    input  logic                            i_reset,
    input  logic                            i_enable,
    input  logic                            i_scd_done,

    input  logic        [$clog2(P_MAX) : 0] i_p_frames,
    input  logic        [1             : 0] i_window_sel,

    input  logic signed [NB_SAMPLES - 1 :0] i_x_re,
    input  logic signed [NB_SAMPLES - 1 :0] i_x_im,

    output logic        [2*NB_DATA  -1 : 0] o_fft1_m_axis_data_tdata  [N_FFT],
    output logic                            o_fft1_m_axis_data_tvalid [N_FFT],
    output logic                            o_fft1_m_axis_data_tlast  [N_FFT],

    // In FFT Realtime mode this signal no longer drives the FFT core because
    // m_axis_data_tready is not present. It is intentionally retained here as
    // a diagnostic indication of whether the downstream second stage would
    // have applied backpressure to the FFT1 output.
    input  logic                            i_fft1_m_axis_data_tready [N_FFT],

    output logic                            o_frame_overflow,

    // High while the input-window datapath is consuming one new time-domain
    // sample per clock, used by the system-level top to count the N external
    // samples and then insert the required zero padding up to N_tot.
    output logic                            o_input_sample_enable
);

    // -------------------------------------------------------------------------
    // input-window signals
    // -------------------------------------------------------------------------
    logic                          w_input_win_enable;
    logic signed [NB_DATA - 1 : 0] w_window_prod_re [NP];
    logic signed [NB_DATA - 1 : 0] w_window_prod_im [NP];
    logic                          w_window_prod_valid_re;
    logic                          w_window_prod_valid_im;

    // -------------------------------------------------------------------------
    // FSM -> FFT1 AXI-Stream input interfaces
    // -------------------------------------------------------------------------
    logic [2*NB_DATA - 1 : 0] w_fft1_s_axis_data_tdata  [N_FFT];
    logic                     w_fft1_s_axis_data_tvalid [N_FFT];
    logic                     w_fft1_s_axis_data_tready [N_FFT];
    logic                     w_fft1_s_axis_data_tlast  [N_FFT];

    logic [AXI_CONFIG_WIDTH - 1 : 0] w_fft1_s_axis_config_tdata;
    logic                            w_fft1_s_axis_config_tvalid [N_FFT];
    logic                            w_fft1_s_axis_config_tready [N_FFT];

    // -------------------------------------------------------------------------
    // Realtime-mode diagnostics
    //
    // w_fft1_event_data_in_halt:
    //   Direct FFT event. Must remain 0. If asserted, the Realtime FFT needed
    //   an input sample and the upstream source did not supply it.
    //
    // w_fft1_output_backpressure:
    //   Since Realtime FFT has no m_axis_data_tready, the downstream path
    //   cannot stall FFT1. This diagnostic must remain 0 whenever FFT1 TVALID
    //   is asserted.
    //
    // The aggregate signals are convenient to add to the simulation waveform.
    // -------------------------------------------------------------------------
    logic w_fft1_event_data_in_halt    [N_FFT];
    logic w_fft1_output_backpressure   [N_FFT];

    logic w_fft1_any_input_halt;
    logic w_fft1_any_output_backpressure;

    always_comb begin
        w_fft1_any_input_halt           = 1'b0;
        w_fft1_any_output_backpressure  = 1'b0;

        for (int fft = 0; fft < N_FFT; fft++) begin
            w_fft1_output_backpressure[fft] =
                o_fft1_m_axis_data_tvalid[fft] &&
                !i_fft1_m_axis_data_tready[fft];

            w_fft1_any_input_halt |=
                w_fft1_event_data_in_halt[fft];

            w_fft1_any_output_backpressure |=
                w_fft1_output_backpressure[fft];
        end
    end

    // Export the actual sample-consume enable to the system-level controller.
    assign o_input_sample_enable = w_input_win_enable;

    // -------------------------------------------------------------------------
    // real input-window path
    // -------------------------------------------------------------------------
    input_window_pipelined #(
        .NP          (NP         ),
        .NB_SAMPLES  (NB_SAMPLES ),
        .NBF_SAMPLES (NBF_SAMPLES),
        .NB_WINDOWS  (NB_WINDOWS ),
        .NBF_WINDOWS (NBF_WINDOWS),
        .NB_OUTPUT   (NB_DATA    ),
        .NBF_OUTPUT  (NBF_DATA   )
    ) u_input_window_re (
        .clock        (clock                 ),
        .i_reset      (i_reset               ),
        .i_enable     (w_input_win_enable    ),
        .i_window_sel (i_window_sel          ),
        .i_x          (i_x_re                ),
        .o_product    (w_window_prod_re      ),
        .o_valid      (w_window_prod_valid_re)
    );

    // -------------------------------------------------------------------------
    // imaginary input-window path
    // -------------------------------------------------------------------------
    input_window_pipelined #(
        .NP          (NP         ),
        .NB_SAMPLES  (NB_SAMPLES ),
        .NBF_SAMPLES (NBF_SAMPLES),
        .NB_WINDOWS  (NB_WINDOWS ),
        .NBF_WINDOWS (NBF_WINDOWS),
        .NB_OUTPUT   (NB_DATA    ),
        .NBF_OUTPUT  (NBF_DATA   )
    ) u_input_window_im (
        .clock        (clock                 ),
        .i_reset      (i_reset               ),
        .i_enable     (w_input_win_enable    ),
        .i_window_sel (i_window_sel          ),
        .i_x          (i_x_im                ),
        .o_product    (w_window_prod_im      ),
        .o_valid      (w_window_prod_valid_im)
    );

    // -------------------------------------------------------------------------
    // first-stage controller
    // -------------------------------------------------------------------------
    first_stage_fsmd_4fft_no_ram #(
        .P_MAX            (P_MAX           ),
        .NP               (NP              ),
        .NB_DATA          (NB_DATA         ),
        .NBF_DATA         (NBF_DATA        ),
        .NB_WIN           (NB_WINDOWS      ),
        .NBF_WIN          (NBF_WINDOWS     ),
        .N_FFT            (N_FFT           ),
        .AXI_CONFIG_WIDTH (AXI_CONFIG_WIDTH)
    ) u_first_stage_fsmd (
        .clock                      (clock                      ),
        .i_reset                    (i_reset                    ),
        .i_enable                   (i_enable                   ),
        .i_scd_done                 (i_scd_done                 ),
        .i_p_frames                 (i_p_frames                 ),

        .i_window_prod_valid_re     (w_window_prod_valid_re     ),
        .i_window_prod_valid_im     (w_window_prod_valid_im     ),
        .i_window_prod_re           (w_window_prod_re           ),
        .i_window_prod_im           (w_window_prod_im           ),
        .o_input_win_enable         (w_input_win_enable         ),
        .o_frame_overflow           (o_frame_overflow           ),

        .i_s_axis_data_tready       (w_fft1_s_axis_data_tready  ),
        .o_s_axis_data_tlast        (w_fft1_s_axis_data_tlast   ),
        .o_s_axis_data_tvalid       (w_fft1_s_axis_data_tvalid  ),
        .o_s_axis_data_tdata        (w_fft1_s_axis_data_tdata   ),

        .i_s_axis_config_tready     (w_fft1_s_axis_config_tready),
        .o_s_axis_config_tvalid     (w_fft1_s_axis_config_tvalid),
        .o_s_axis_config_tdata      (w_fft1_s_axis_config_tdata )
    );

    // -------------------------------------------------------------------------
    // FFT1 cores - Realtime mode
    //
    // In Realtime mode:
    //   * s_axis_data_tready remains present.
    //   * m_axis_data_tvalid remains present.
    //   * m_axis_data_tready is removed.
    //   * event_data_in_channel_halt remains present.
    //   * event_data_out_channel_halt and event_status_channel_halt are removed.
    // -------------------------------------------------------------------------
    generate
        for (genvar fft = 0; fft < N_FFT; fft++) begin : GEN_FFT1
            xfft_0 u_fft1 (
                .aclk                       (clock                            ),
                .aresetn                    (!i_reset                         ),

                .s_axis_config_tdata        (w_fft1_s_axis_config_tdata       ),
                .s_axis_config_tvalid       (w_fft1_s_axis_config_tvalid[fft] ),
                .s_axis_config_tready       (w_fft1_s_axis_config_tready[fft] ),

                .s_axis_data_tdata          (w_fft1_s_axis_data_tdata[fft]    ),
                .s_axis_data_tvalid         (w_fft1_s_axis_data_tvalid[fft]   ),
                .s_axis_data_tready         (w_fft1_s_axis_data_tready[fft]   ),
                .s_axis_data_tlast          (w_fft1_s_axis_data_tlast[fft]    ),

                .m_axis_data_tdata          (o_fft1_m_axis_data_tdata[fft]    ),
                .m_axis_data_tvalid         (o_fft1_m_axis_data_tvalid[fft]   ),
                .m_axis_data_tlast          (o_fft1_m_axis_data_tlast[fft]    ),

                .event_frame_started        (),
                .event_tlast_unexpected     (),
                .event_tlast_missing        (),
                .event_data_in_channel_halt (w_fft1_event_data_in_halt[fft]   )
            );
        end
    endgenerate

endmodule
