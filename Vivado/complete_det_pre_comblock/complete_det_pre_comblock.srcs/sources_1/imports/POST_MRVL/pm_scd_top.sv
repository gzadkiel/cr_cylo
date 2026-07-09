module pm_scd_top #(
    parameter NB_DATA_I  = 12,
              NBF_DATA_I = 11,
              NB_WIN     = 8,
              NBF_WIN    = 7,
              NB_DATA_O  = 16,
              NBF_DATA_O = 15,
              NP_SAMPLES = 32, 
              P_MAX      = 128,
              NB_EXP     = 16,
              NB_FFT2_O  = 64 // !!!
) (
    input logic                             clock,
    input logic                             i_reset,
    input logic                             i_enable,
    input logic        [1              : 0] i_window_sel,
    input logic        [$clog2(P_MAX)  : 0] i_p_frames,
    input logic signed [NB_DATA_I  - 1 : 0] i_data_sample_re, 
    input logic signed [NB_DATA_I  - 1 : 0] i_data_sample_im,
    
    input  logic                     i_fft2_axis_data_tready, 
    output logic [NB_FFT2_O - 1 : 0] o_fft2_axis_data_tdata,
    output logic [7             : 0] o_fft2_axis_data_tuser,
    output logic                     o_fft2_axis_data_tvalid, 
    output logic                     o_fft2_axis_data_tlast,

    output logic o_estimate_done,
    output logic o_detect_done
);

localparam FFT1_O_WIDTH = 2*NB_DATA_O;
localparam FFT2_O_WIDTH = 4*NB_DATA_O; // CHANGED A 4 ANTES ERA 2 !!!    

logic [FFT1_O_WIDTH - 1 : 0] w_fft1_axis_data_tdata;
logic                        w_fft1_axis_data_tvalid;
logic                        w_fft1_axis_data_tready;
logic                        w_fft1_axis_data_tlast;
logic [FFT2_O_WIDTH - 1 : 0] w_fft2_axis_data_tdata;
logic [7                : 0] w_fft2_axis_data_tuser;
logic                        w_fft2_axis_data_tvalid;
logic                        w_fft2_axis_data_tlast;

logic w_scd_done;
logic w_det_done;

assign o_fft2_axis_data_tvalid = w_fft2_axis_data_tvalid;
assign o_fft2_axis_data_tdata  = w_fft2_axis_data_tdata;
assign o_fft2_axis_data_tuser  = w_fft2_axis_data_tuser;
assign o_fft2_axis_data_tlast  = w_fft2_axis_data_tlast;

assign o_estimate_done = w_scd_done;
assign o_detect_done = w_det_done;

pm_first_stage_wrap # (
    .P_MAX      (P_MAX     ),
    .NP         (NP_SAMPLES),
    .NB_DATA_I  (NB_DATA_I ),
    .NBF_DATA_I (NBF_DATA_I),
    .NB_WINDOW  (NB_WIN    ),
    .NBF_WINDOW (NBF_WIN   ),
    .NB_DATA_O  (NB_DATA_O ),
    .NBF_DATA_O (NBF_DATA_O))
pm_first_stage_wrap_inst (
    .clock                     (clock                  ),
    .i_reset                   (i_reset                ),
    .i_enable                  (i_enable               ),
    .i_sample_re               (i_data_sample_re       ), // ext
    .i_sample_im               (i_data_sample_im       ), // ext
    .i_window_sel              (i_window_sel           ), // ext
    .i_scd_done                (w_det_done             ), // ACA CAMBIE ESTO, PORQ SI SON POCOS PUNTOS ARRANCA DE NUEVO MUY RAPIDO
    .i_p_frames                (i_p_frames             ), // ext
    .i_fft1_m_axis_data_tready (w_fft1_axis_data_tready),
    .o_fft1_m_axis_data_tdata  (w_fft1_axis_data_tdata ),
    .o_fft1_m_axis_data_tlast  (w_fft1_axis_data_tlast ),
    .o_fft1_m_axis_data_tvalid (w_fft1_axis_data_tvalid));

pm_second_stage_wrap # (
    .NP          (NP_SAMPLES  ),
    .P_MAX       (P_MAX       ),
    .NB_DATA     (NB_DATA_O   ),
    .NB_EXPO     (NB_EXP      ),
    .NB_FFT1_IN  (FFT1_O_WIDTH),
    .NB_FFT2_OUT (FFT2_O_WIDTH))
  pm_second_stage_wrap_inst (
    .clock                     (clock                  ),
    .i_enable                  (i_enable               ),
    .i_reset                   (i_reset                ),
    .i_p_frames                (i_p_frames             ),
    .i_fft1_m_axis_data_tdata  (w_fft1_axis_data_tdata ),
    .i_fft1_m_axis_data_tvalid (w_fft1_axis_data_tvalid),
    .i_fft1_m_axis_data_tlast  (w_fft1_axis_data_tlast ),
    .o_fft1_m_axis_data_tready (w_fft1_axis_data_tready),
    .o_fft2_m_axis_data_tdata  (w_fft2_axis_data_tdata ),
    .o_fft2_m_axis_data_tuser  (w_fft2_axis_data_tuser ), // ext
    .o_fft2_m_axis_data_tvalid (w_fft2_axis_data_tvalid), // ext
    .o_fft2_m_axis_data_tlast  (w_fft2_axis_data_tlast ), // ext
    .i_fft2_m_axis_data_tready (i_fft2_axis_data_tready), // ext
    .o_scd_done                (w_scd_done             ),
    .o_det_done                (w_det_done             ));

endmodule