module second_stage_wrapper #(
    parameter integer N_BANKS           = 4,
    parameter integer N_ENGINES         = 4,
    parameter integer NP                = 32,
    parameter integer P_MIN             = 8,
    parameter integer P_MAX             = 128,
    parameter integer NB_DATA           = 16,
    parameter bit     SATURATE_NEG      = 1'b1,

    // Xilinx CMULT2 IP configuration used by cmpy_0:
    //   input  = 16-bit real + 16-bit imag = 32-bit TDATA
    //   output = 33-bit real / imag, each aligned inside a 40-bit field
    //            -> 80-bit TDATA total.
    parameter integer CMULT_RAW_WIDTH    = 80,
    parameter integer CMULT_FULL_COMP_W  = 33,
    parameter integer CMULT_OUT_COMP_W   = 32,
    parameter integer CMULT_REAL_LSB     = 0,
    parameter integer CMULT_IMAG_LSB     = 40,

    // Xilinx FFT2 IP configuration used by xfft_1.
    parameter integer FFT2_CONFIG_WIDTH  = 17,
    parameter integer FFT2_DATA_WIDTH    = 64,

    parameter integer FFT1_DATA_WIDTH    = 2 * NB_DATA,
    parameter integer FFT2_IN_WIDTH      = 2 * CMULT_OUT_COMP_W,
    parameter integer BANK_DEPTH         = P_MAX / N_BANKS,
    parameter integer MEM_DEPTH          = NP * BANK_DEPTH,
    parameter integer MEM_ADDR_WIDTH     = $clog2(MEM_DEPTH),
    parameter integer BIN_WIDTH          = $clog2(NP),
    parameter integer PAIR_COUNT         = (NP * (NP - 1)) / 2,
    parameter integer PAIR_ID_WIDTH      = $clog2(PAIR_COUNT),
    parameter integer FFT_BIN_IDX_WIDTH  = $clog2(P_MAX),
    parameter integer Q_WIDTH            = $clog2(P_MAX) + 2,
    parameter integer DONE_COUNT_WIDTH   = $clog2(PAIR_COUNT + 1)
) (
    input  logic                                    clock,
    input  logic                                    i_reset,
    input  logic                                    i_enable,
    input  logic [$clog2(P_MAX)                : 0] i_p_frames,

    // SCD comparison mode:
    //   0 = full FFT2 output (P bins per pair)
    //   1 = reduced output (P/2 bins per pair)
    input  logic                                    i_scd_mode,

    // four FFT1 streams from first_stage_wrapper.
    input  logic        [FFT1_DATA_WIDTH   - 1 : 0] i_fft1_m_axis_data_tdata  [N_BANKS],
    input  logic                                    i_fft1_m_axis_data_tvalid [N_BANKS],
    input  logic                                    i_fft1_m_axis_data_tlast  [N_BANKS],
    output logic                                    o_fft1_m_axis_data_tready [N_BANKS],

    // selectable SCD streams after FFT2 bin selection.
    // i_scd_mode = 0 -> all P bins.
    // i_scd_mode = 1 -> P/4 bins on each side of q=0 -> P/2 total.
    output logic        [FFT2_DATA_WIDTH   - 1 : 0] o_scd_tdata  [N_ENGINES],
    output logic                                    o_scd_tvalid [N_ENGINES],
    output logic                                    o_scd_tlast  [N_ENGINES],
    input  logic                                    i_scd_tready [N_ENGINES],

    output logic        [FFT_BIN_IDX_WIDTH - 1 : 0] o_fft_bin_index [N_ENGINES],
    output logic signed [Q_WIDTH           - 1 : 0] o_q_index       [N_ENGINES],

    // pair metadata for debug / future detector tagging.
    output logic        [BIN_WIDTH         - 1 : 0] o_pair_i     [N_ENGINES],
    output logic        [BIN_WIDTH         - 1 : 0] o_pair_j     [N_ENGINES],
    output logic        [PAIR_ID_WIDTH     - 1 : 0] o_pair_id    [N_ENGINES],
    output logic                                    o_pair_tlast [N_ENGINES],

    // control / diagnostics.
    output logic                                    o_busy,
    output logic                                    o_done,
    output logic                                    o_error,
    output logic                                    o_load_done,
    output logic                                    o_pair_done,
    output logic                                    o_config_done,
    output logic        [DONE_COUNT_WIDTH  - 1 : 0] o_fft2_frames_done,

    output logic                                    o_backpressure_error,

    // FFT2 IP event diagnostics.
    output logic                                    o_fft2_tlast_unexpected,
    output logic                                    o_fft2_tlast_missing
);

    // -------------------------------------------------------------------------
    // controller signals
    // -------------------------------------------------------------------------
    
    logic w_stage_clear;
    logic w_phase_enable;
    logic w_config_start;
    logic w_pair_start;
    logic w_controller_error;

    // -------------------------------------------------------------------------
    // phase-corrected FFT1 streams
    // -------------------------------------------------------------------------
    
    logic [FFT1_DATA_WIDTH - 1 : 0] w_phase_tdata  [N_BANKS];
    logic                           w_phase_tvalid [N_BANKS];
    logic                           w_phase_tlast  [N_BANKS];
    logic                           w_phase_tready [N_BANKS];

    // -------------------------------------------------------------------------
    // banked memory read interfaces
    // -------------------------------------------------------------------------
    
    logic                           w_bank_rd_en     [N_BANKS];
    logic [MEM_ADDR_WIDTH  - 1 : 0] w_bank_rd_addr_a [N_BANKS];
    logic [MEM_ADDR_WIDTH  - 1 : 0] w_bank_rd_addr_b [N_BANKS];
    logic [FFT1_DATA_WIDTH - 1 : 0] w_bank_rd_data_a [N_BANKS];
    logic [FFT1_DATA_WIDTH - 1 : 0] w_bank_rd_data_b [N_BANKS];

    logic w_store_bad_p;
    logic w_pair_bad_p;
    logic w_config_bad_p;
    logic w_filter_bad_p;

    // -------------------------------------------------------------------------
    // pair streamer outputs
    // -------------------------------------------------------------------------
    
    logic [FFT1_DATA_WIDTH - 1 : 0] w_pair_a_tdata [N_ENGINES];
    logic [FFT1_DATA_WIDTH - 1 : 0] w_pair_b_tdata [N_ENGINES];
    logic                           w_pair_tvalid  [N_ENGINES];
    logic                           w_pair_busy;

    // -------------------------------------------------------------------------
    // CMULT2 IP-side signals
    // -------------------------------------------------------------------------
    
    logic [CMULT_RAW_WIDTH - 1 : 0] w_cmult_raw_tdata  [N_ENGINES];
    logic                           w_cmult_raw_tvalid [N_ENGINES];
    logic                           w_cmult_raw_tlast  [N_ENGINES];

    logic [FFT2_IN_WIDTH - 1 : 0] w_cmult_resized_tdata  [N_ENGINES];
    logic                         w_cmult_resized_tvalid [N_ENGINES];

    // -------------------------------------------------------------------------
    // Local FFT2 reset replicas
    //
    // Timing optimization: give each FFT2 core an independent registered reset
    // source so Vivado can place that source close to the corresponding core
    // instead of routing the external reset across the whole second stage.
    //
    // The local reset follows i_reset by one clock. The FFT2 configuration
    // interface already holds TVALID until TREADY, so the extra reset cycle does
    // not lose configuration data.
    // -------------------------------------------------------------------------
    (* keep = "true", dont_touch = "true" *)
    logic r_fft2_reset [N_ENGINES];

    always_ff @(posedge clock) begin : FFT2_LOCAL_RESET_REGISTERS
        for (int eng = 0; eng < N_ENGINES; eng++) begin
            r_fft2_reset[eng] <= i_reset;
        end
    end

    // -------------------------------------------------------------------------
    // FFT2 configuration / data interfaces
    // -------------------------------------------------------------------------
    
    logic [FFT2_CONFIG_WIDTH - 1 : 0] w_fft2_config_tdata;
    logic                             w_fft2_config_tvalid [N_ENGINES];
    logic                             w_fft2_config_tready [N_ENGINES];

    logic [FFT2_IN_WIDTH - 1 : 0] w_fft2_s_tdata  [N_ENGINES];
    logic                         w_fft2_s_tvalid [N_ENGINES];
    logic                         w_fft2_s_tready [N_ENGINES];
    logic                         w_fft2_s_tlast  [N_ENGINES];

    logic [FFT2_DATA_WIDTH - 1 : 0] w_fft2_m_tdata  [N_ENGINES];
    logic                           w_fft2_m_tvalid [N_ENGINES];
    logic                           w_fft2_m_tready [N_ENGINES];
    logic                           w_fft2_m_tlast  [N_ENGINES];

    logic w_fft2_event_tlast_unexpected [N_ENGINES];
    logic w_fft2_event_tlast_missing    [N_ENGINES];

    logic w_fft2_frame_done [N_ENGINES];

    // -------------------------------------------------------------------------
    // configuration / diagnostic aggregation
    // -------------------------------------------------------------------------

    always_comb begin
        o_fft2_tlast_unexpected = 1'b0;
        o_fft2_tlast_missing    = 1'b0;
        o_backpressure_error    = 1'b0;

        for (int eng = 0; eng < N_ENGINES; eng++) begin
            o_fft2_tlast_unexpected |= w_fft2_event_tlast_unexpected[eng];
            o_fft2_tlast_missing    |= w_fft2_event_tlast_missing[eng];

            // cmpy_0 has no M_AXIS ready input. Therefore FFT2 must remain
            // ready whenever the multiplier is producing valid output.
            if (w_cmult_resized_tvalid[eng] && !w_fft2_s_tready[eng]) o_backpressure_error = 1'b1;
        end
    end

    assign w_controller_error = o_backpressure_error    ||
                                o_fft2_tlast_unexpected ||
                                o_fft2_tlast_missing;

    // count a complete FFT2 frame when TLAST is accepted at the FFT2 output.
    generate
        for (genvar eng_done = 0; eng_done < N_ENGINES; eng_done++) begin : GEN_FFT2_DONE
            assign w_fft2_frame_done[eng_done] = w_fft2_m_tvalid[eng_done] && w_fft2_m_tready[eng_done] && w_fft2_m_tlast[eng_done];
        end
    endgenerate

    // -------------------------------------------------------------------------
    // global stage controller
    // -------------------------------------------------------------------------
    
    second_stage_controller #(
        .NP          (NP        ),
        .N_ENGINES   (N_ENGINES ),
        .PAIR_COUNT  (PAIR_COUNT)) 
    u_controller (
        .clock               (clock             ),
        .i_reset             (i_reset           ),
        .i_enable            (i_enable          ),

        .i_config_done       (o_config_done     ),
        .i_load_done         (o_load_done       ),
        .i_pair_done         (o_pair_done       ),
        .i_fft2_frame_done   (w_fft2_frame_done ),
        .i_error             (w_controller_error),

        .o_clear             (w_stage_clear     ),
        .o_phase_enable      (w_phase_enable    ),
        .o_config_start      (w_config_start    ),
        .o_pair_start        (w_pair_start      ),

        .o_busy              (o_busy            ),
        .o_done              (o_done            ),
        .o_error             (o_error           ),
        .o_fft2_frames_done  (o_fft2_frames_done));

    // -------------------------------------------------------------------------
    // FFT1 phase correction
    // -------------------------------------------------------------------------

    phase_corrector_4lane #(
        .NB_DATA      (NB_DATA     ),
        .SATURATE_NEG (SATURATE_NEG)) 
    u_phase_corrector (
        .clock             (clock                    ),
        .i_reset           (i_reset                  ),
        .i_enable          (w_phase_enable           ),

        .i_s_axis_tdata    (i_fft1_m_axis_data_tdata ),
        .i_s_axis_tvalid   (i_fft1_m_axis_data_tvalid),
        .i_s_axis_tlast    (i_fft1_m_axis_data_tlast ),
        .o_s_axis_tready   (o_fft1_m_axis_data_tready),

        .o_m_axis_tdata    (w_phase_tdata            ),
        .o_m_axis_tvalid   (w_phase_tvalid           ),
        .o_m_axis_tlast    (w_phase_tlast            ),
        .i_m_axis_tready   (w_phase_tready           ));

    // -------------------------------------------------------------------------
    // four-bank storage of phase-corrected FFT1 frames
    // -------------------------------------------------------------------------

    scd_fft1_store_banked #(
        .N_BANKS    (N_BANKS        ),
        .NP         (NP             ),
        .P_MIN      (P_MIN          ),
        .P_MAX      (P_MAX          ),
        .DATA_WIDTH (FFT1_DATA_WIDTH)) 
    u_fft1_store (
        .clock                  (clock           ),
        .i_reset                (i_reset         ),
        .i_clear                (w_stage_clear   ),
        .i_p_frames             (i_p_frames      ),

        .i_s_axis_tdata         (w_phase_tdata   ),
        .i_s_axis_tvalid        (w_phase_tvalid  ),
        .i_s_axis_tlast         (w_phase_tlast   ),
        .o_s_axis_tready        (w_phase_tready  ),

        .i_rd_en                (w_bank_rd_en    ),
        .i_rd_addr_a            (w_bank_rd_addr_a),
        .i_rd_addr_b            (w_bank_rd_addr_b),
        .o_rd_data_a            (w_bank_rd_data_a),
        .o_rd_data_b            (w_bank_rd_data_b),

        .o_load_done            (o_load_done     ));

    // -------------------------------------------------------------------------
    // parallel pair scheduler: i > j only
    // -------------------------------------------------------------------------
    
    scd_pair_streamer_parallel #(
        .N_BANKS    (N_BANKS        ),
        .N_ENGINES  (N_ENGINES      ),
        .NP         (NP             ),
        .P_MIN      (P_MIN          ),
        .P_MAX      (P_MAX          ),
        .DATA_WIDTH (FFT1_DATA_WIDTH)) 
    u_pair_streamer (
        .clock                  (clock           ),
        .i_reset                (i_reset         ),
        .i_clear                (w_stage_clear   ),
        .i_start                (w_pair_start    ),
        .i_p_frames             (i_p_frames      ),

        .o_rd_en                (w_bank_rd_en    ),
        .o_rd_addr_a            (w_bank_rd_addr_a),
        .o_rd_addr_b            (w_bank_rd_addr_b),
        .i_rd_data_a            (w_bank_rd_data_a),
        .i_rd_data_b            (w_bank_rd_data_b),

        .o_cmult_a_tdata        (w_pair_a_tdata  ),
        .o_cmult_b_tdata        (w_pair_b_tdata  ),
        .o_cmult_tvalid         (w_pair_tvalid   ),
        .o_pair_tlast           (o_pair_tlast    ),
        .o_pair_i               (o_pair_i        ),
        .o_pair_j               (o_pair_j        ),
        .o_pair_id              (o_pair_id       ),

        .o_busy                 (w_pair_busy     ),
        .o_done                 (o_pair_done     ));

    // -------------------------------------------------------------------------
    // N_ENGINES Xilinx Complex Multiplier cores.
    // cmpy_0 must be configured for 16-bit real/imag inputs and Full Precision
    // output. Expected AXI widths: 32-bit input TDATA, 80-bit output TDATA.
    // -------------------------------------------------------------------------
    generate

        for (genvar eng_cmult = 0; eng_cmult < N_ENGINES; eng_cmult++) begin : GEN_CMULT2
            cmpy_0 u_cmult2 (
                .aclk               (clock                        ),
                .aresetn            (!i_reset                     ),

                .s_axis_a_tvalid    (w_pair_tvalid[eng_cmult]     ),
                .s_axis_a_tlast     (o_pair_tlast[eng_cmult]      ),
                .s_axis_a_tdata     (w_pair_a_tdata[eng_cmult]    ),

                .s_axis_b_tvalid    (w_pair_tvalid[eng_cmult]     ),
                .s_axis_b_tlast     (o_pair_tlast[eng_cmult]      ),
                .s_axis_b_tdata     (w_pair_b_tdata[eng_cmult]    ),

                .m_axis_dout_tvalid (w_cmult_raw_tvalid[eng_cmult]),
                .m_axis_dout_tlast  (w_cmult_raw_tlast[eng_cmult] ),
                .m_axis_dout_tdata  (w_cmult_raw_tdata[eng_cmult] ));
        end
    endgenerate

    // -------------------------------------------------------------------------
    // resize CMULT full-resolution result:
    //   cmpy_0 output = two 33-bit components in 40-bit aligned fields.
    // the resize policy intentionally preserves the previous implementation:
    //   out = {full[30:0], 1'b0}
    // -------------------------------------------------------------------------

    cmult2_resize_parallel #(
        .N_ENGINES    (N_ENGINES        ),
        .RAW_WIDTH    (CMULT_RAW_WIDTH  ),
        .FULL_COMP_W  (CMULT_FULL_COMP_W),
        .OUT_COMP_W   (CMULT_OUT_COMP_W ),
        .REAL_LSB     (CMULT_REAL_LSB   ),
        .IMAG_LSB     (CMULT_IMAG_LSB   )) 
    u_cmult2_resize (
        .i_cmult_tdata  (w_cmult_raw_tdata     ),
        .i_cmult_tvalid (w_cmult_raw_tvalid    ),
        .o_tdata        (w_cmult_resized_tdata ),
        .o_tvalid       (w_cmult_resized_tvalid));

    // cmpy_0 propagates TLAST, so no separate P-sample framer is required.
    generate
        for (genvar eng_fft2_in = 0; eng_fft2_in < N_ENGINES; eng_fft2_in++) begin : GEN_FFT2_INPUT
            assign w_fft2_s_tdata[eng_fft2_in]  = w_cmult_resized_tdata[eng_fft2_in];
            assign w_fft2_s_tvalid[eng_fft2_in] = w_cmult_resized_tvalid[eng_fft2_in];
            assign w_fft2_s_tlast[eng_fft2_in]  = w_cmult_raw_tlast[eng_fft2_in] && w_cmult_raw_tvalid[eng_fft2_in];
        end
    endgenerate

    // -------------------------------------------------------------------------
    // runtime FFT2 configuration, P = 8/16/32/64/128.
    // AXI_CONFIG_WIDTH=24; the existing 17 meaningful config bits are
    // automatically zero-extended in the MSBs by fft2_config_parallel.
    // -------------------------------------------------------------------------
    
    fft2_config_parallel #(
        .N_ENGINES        (N_ENGINES        ),
        .P_MIN            (P_MIN            ),
        .P_MAX            (P_MAX            ),
        .AXI_CONFIG_WIDTH (FFT2_CONFIG_WIDTH)) 
    u_fft2_config (
        .clock                       (clock               ),
        .i_reset                     (i_reset             ),
        .i_clear                     (w_stage_clear       ),
        .i_start                     (w_config_start      ),
        .i_p_frames                  (i_p_frames          ),

        .i_s_axis_config_tready      (w_fft2_config_tready),
        .o_s_axis_config_tvalid      (w_fft2_config_tvalid),
        .o_s_axis_config_tdata       (w_fft2_config_tdata ),

        .o_config_done               (o_config_done       ));

    // -------------------------------------------------------------------------
    // N_ENGINES Xilinx FFT2 cores
    // -------------------------------------------------------------------------

    generate
        for (genvar eng_fft2 = 0; eng_fft2 < N_ENGINES; eng_fft2++) begin : GEN_FFT2
            xfft_1 u_fft2 (
                .aclk                        (clock                         ),
                .aresetn                     (!r_fft2_reset[eng_fft2]       ),

                .s_axis_config_tdata         (w_fft2_config_tdata           ),
                .s_axis_config_tvalid        (w_fft2_config_tvalid[eng_fft2]),
                .s_axis_config_tready        (w_fft2_config_tready[eng_fft2]),

                .s_axis_data_tdata           (w_fft2_s_tdata[eng_fft2]      ),
                .s_axis_data_tvalid          (w_fft2_s_tvalid[eng_fft2]     ),
                .s_axis_data_tready          (w_fft2_s_tready[eng_fft2]     ),
                .s_axis_data_tlast           (w_fft2_s_tlast[eng_fft2]      ),

                .m_axis_data_tdata           (w_fft2_m_tdata[eng_fft2]      ),
                .m_axis_data_tvalid          (w_fft2_m_tvalid[eng_fft2]     ),
                //.m_axis_data_tready          (w_fft2_m_tready[eng_fft2]     ),
                .m_axis_data_tlast           (w_fft2_m_tlast[eng_fft2]      ),

                .event_frame_started         (                                       ),
                .event_tlast_unexpected      (w_fft2_event_tlast_unexpected[eng_fft2]),
                .event_tlast_missing         (w_fft2_event_tlast_missing[eng_fft2]   ),
                //.event_status_channel_halt   (                                       ),
                .event_data_in_channel_halt  (                                       ));
                //.event_data_out_channel_halt (                                       ));
        end
    endgenerate

    // -------------------------------------------------------------------------
    // select either the complete FFT2 frame or the reduced P/2 subset.
    // -------------------------------------------------------------------------

    fft2_bin_filter_parallel #(
        .N_ENGINES  (N_ENGINES        ),
        .P_MIN      (P_MIN            ),
        .P_MAX      (P_MAX            ),
        .DATA_WIDTH (FFT2_DATA_WIDTH  ),
        .IDX_WIDTH  (FFT_BIN_IDX_WIDTH),
        .Q_WIDTH    (Q_WIDTH          )) 
    u_fft2_bin_filter (
        .clock                    (clock          ),
        .i_reset                  (i_reset        ),
        .i_clear                  (w_stage_clear  ),
        .i_p_frames               (i_p_frames     ),
        .i_scd_mode               (i_scd_mode     ),

        .i_s_axis_tdata           (w_fft2_m_tdata ),
        .i_s_axis_tvalid          (w_fft2_m_tvalid),
        .i_s_axis_tlast           (w_fft2_m_tlast ),
        .o_s_axis_tready          (w_fft2_m_tready),

        .o_m_axis_tdata           (o_scd_tdata    ),
        .o_m_axis_tvalid          (o_scd_tvalid   ),
        .o_m_axis_tlast           (o_scd_tlast    ),
        .i_m_axis_tready          (i_scd_tready   ),

        .o_fft_bin_index          (o_fft_bin_index),
        .o_q_index                (o_q_index      ));

endmodule
