module pm_top_mux #(
	parameter N_DESIRED        = 1024, //! number of total samples used for estimation 
			  NB_SAMPLE_DATA   = 12,  //! number of bits of input sample
			  NBF_SAMPLE_DATA  = 9,  //! number of frac bits of input sample
			  NP_SAMPLES       = 32, //! number of samples per frame (np-point fft)
			  P_MAX            = 128,
			  N_NOISE_SAMPLES  = 256, //! number of samples used for noise power estimation
			  NB_THRESHOLD     = 65,  //! number of bits of threshold
			  NBF_THRESHOLD    = 46,  //! number of frac bits of threshold
			  NB_WINDOW_COEFF  = 8,   //! number of bits used for window coeff
              NBF_WINDOW_COEFF = 7,
			  NB_EXP_COEFF     = 16,  //! number of bits used for exponential coeff
              NB_DETECT        = 16   // np*np*p // 2, temp
) (
	input  logic clock,
	input  logic i_reset,
	input  logic i_enable,
	
	input  logic i_noise_data_valid,  //! PS tells noise data is valid to estimate noise power
	input  logic i_signal_data_valid, //! PS tells signal data is valid to estimate scd
	
	input  logic signed [NB_SAMPLE_DATA - 1 : 0] i_data_re,	
	input  logic signed [NB_SAMPLE_DATA - 1 : 0] i_data_im,
	
	input  logic [$clog2(N_DESIRED)      : 0] i_data_size,
	input  logic [$clog2(N_NOISE_SAMPLES): 0] i_noise_size,
	input  logic [1                      : 0] i_window_sel,
	input  logic [3                      : 0] i_pfa_value,
	
	output logic [NB_DETECT - 1 : 0] o_detect,            //! number of detections out of all estimated samples
    output logic                     o_est_done,          //! estimation done (scd done) - debug
    output logic                     o_detection_done,    //! tell PS detection is done, start a new run
    output logic                     o_threshold_est_done //! tell PS noise est is done, send data samples
);
  
// paramters used for SCD estimation
localparam NB_DATA_WIN_O  = 16; //! input window total output bits after trunc 
localparam NBF_DATA_WIN_O = 13; //! input window total output frac bits after trunc

localparam L     = NP_SAMPLES / 4; //! decimation parameter (based of roberts paper)
localparam L_DIV = $clog2(L); //! bits to shift to divide by L

localparam SCD_DATA_OUT = 64; //! fft2 output size (scd estimation samples)
// ---------------------------------

// previously calculated as localparam, now as signals to provide a modular design
logic [$clog2(P_MAX) : 0] r_p_frames;
assign r_p_frames = i_data_size >> L_DIV; // P_FRAMES = N_DESIRED / L;

logic [$clog2(N_DESIRED) : 0] r_n_tot;
assign r_n_tot = ((r_p_frames - 1'b1) << L_DIV) + 11'b00001000000; // N_TOT = (P_FRAMES - 1)*L + NP_SAMPLES;
//--------------------------------------------------------------------------------

// added - detection done signal after FFT2 output is complete, to provide better sync 
logic w_detection_done;
assign o_detection_done = w_detection_done;
//------------------------------------------------------------------------------------

// added - provide PS with a way of knowing noise power estimation is complete 
logic w_threshold_est_done;
assign o_threshold_est_done = w_threshold_est_done;
//----------------------------------------------------------------------------

// added - reset scd estimator between runs
logic w_scd_reset;
// ----------------------------------------

logic                                 w_scd_estimate_en;
logic                                 w_estimation_done;
logic signed [NB_SAMPLE_DATA - 1 : 0] w_data_sample_re;
logic signed [NB_SAMPLE_DATA - 1 : 0] w_data_sample_im;

logic [SCD_DATA_OUT - 1 : 0] w_fft2_m_axis_data_tdata;
logic [7                : 0] w_fft2_m_axis_data_tuser;
logic 						 w_fft2_m_axis_data_tready;
logic 						 w_fft2_m_axis_data_tvalid; 
logic 						 w_fft2_m_axis_data_tlast;

logic                        w_threshold_estimate_en;
logic [NB_THRESHOLD - 1 : 0] w_estimated_thres;
logic                        w_det_counter_reset;

logic [NB_DETECT - 1 : 0] w_detect_counter;
logic                     w_compare_detect_en;

assign o_detect   = w_detect_counter;
assign o_est_done = w_estimation_done;


detection_compare # (
    .NB_DATA  (32            ),
    .NB_THRES (NB_THRESHOLD  ),
    .NP       (NP_SAMPLES    ),
    .P_MAX    (P_MAX         ),
    .NB_DETECT(NB_DETECT     ))
  detection_compare_inst (
    .clock                     (clock                         ),
    .i_reset                   (i_reset || w_det_counter_reset),
    .i_enable                  (w_compare_detect_en           ),
    .i_p_frames                (r_p_frames                    ),
    .i_threshold               (w_estimated_thres             ),
    .i_fft2_m_axis_data_tdata  (w_fft2_m_axis_data_tdata      ),
    .i_fft2_m_axis_data_tuser  (w_fft2_m_axis_data_tuser      ),
    .i_fft2_m_axis_data_tvalid (w_fft2_m_axis_data_tvalid     ),
    .i_fft2_m_axis_data_tlast  (w_fft2_m_axis_data_tlast      ),
    .o_m_fft2_axis_data_tready (w_fft2_m_axis_data_tready     ),
    .o_detect_counter          (w_detect_counter              ));

theshold_calculator # (
    .N_NOISE_SAMPLES_MAX (N_NOISE_SAMPLES),
    .NB_DATA             (NB_SAMPLE_DATA ),
    .NBF_DATA            (NBF_SAMPLE_DATA),
    .NB_THRESHOLD        (NB_THRESHOLD   ),
    .NBF_THRESHOLD       (NBF_THRESHOLD  ))
theshold_calculator (
    .clock                 (clock                  ),
    .i_enable              (w_threshold_estimate_en),
    .i_reset               (i_reset                ),
    .i_noise_size          (i_noise_size           ),
    .i_data_sample         (w_data_sample_re       ),
    .i_pfa                 (i_pfa_value            ),
    .o_estimated_threshold (w_estimated_thres      ),
    .o_thres_est_done      (w_threshold_est_done   )); // PARA EL PS

pm_scd_top # (
    .NB_DATA_I  (NB_SAMPLE_DATA  ),
    .NBF_DATA_I (NBF_SAMPLE_DATA ),
    .NB_WIN     (NB_WINDOW_COEFF ),
    .NBF_WIN    (NBF_WINDOW_COEFF),
    .NB_DATA_O  (NB_DATA_WIN_O   ),
    .NBF_DATA_O (NBF_DATA_WIN_O  ),
    .NP_SAMPLES (NP_SAMPLES      ),
    .P_MAX      (P_MAX           ),
    .NB_EXP     (NB_EXP_COEFF    ),
    .NB_FFT2_O  (SCD_DATA_OUT    ))
scd_estimator (
    .clock                   (clock                    ),
    .i_reset                 (i_reset ||  w_scd_reset  ), // ACA AGREGUE ESTO PARA Q FLUSHEE TODO EL ESTIMADOR ENTRE DECTECCIONES
    .i_enable                (w_scd_estimate_en        ),
    .i_window_sel            (i_window_sel             ), // added
    .i_p_frames              (r_p_frames               ), // added
    .i_data_sample_re        (w_data_sample_re         ),
    .i_data_sample_im        (w_data_sample_im         ),
    .i_fft2_axis_data_tready (w_fft2_m_axis_data_tready),
    .o_fft2_axis_data_tdata  (w_fft2_m_axis_data_tdata ),
    .o_fft2_axis_data_tuser  (w_fft2_m_axis_data_tuser ),
    .o_fft2_axis_data_tvalid (w_fft2_m_axis_data_tvalid),
    .o_fft2_axis_data_tlast  (w_fft2_m_axis_data_tlast ),
    .o_estimate_done         (w_estimation_done        ),
    .o_detect_done           (w_detection_done         ));

pm_top_mux_fsmd # (
    .NB_SAMPLE_DATA    (NB_SAMPLE_DATA ),
    .N_NOISE_SAMPLES   (N_NOISE_SAMPLES),
    .N_DESIRED_SAMPLES (N_DESIRED      ))
    //.N_TOTAL_SAMPLES   (N_TOT          ))
pm_top_mux_fsmd_control (
    .clock                   (clock                  ),
    .i_reset                 (i_reset                ),
    .i_enable                (i_enable               ),
    .i_data_size             (i_data_size            ),
    .i_tot_data_size         (r_n_tot                ),
    .i_noise_size            (i_noise_size           ),
    
    .i_noise_data_valid      (i_noise_data_valid     ),
    .i_signal_data_valid     (i_signal_data_valid    ),
    
    .i_data_sample_re        (i_data_re              ),
    .i_data_sample_im        (i_data_im              ),
    .o_data_sample_re        (w_data_sample_re       ),
    .o_data_sample_im        (w_data_sample_im       ),
    .i_scd_estimate_done     (w_detection_done       ), // aca VA E; DETECTOIPM AMTES ESTABA EL EST
    .o_threshold_estimate_en (w_threshold_estimate_en),
    .o_scd_estimate_en       (w_scd_estimate_en      ),
    .o_compare_detect_en     (w_compare_detect_en    ),
    .o_det_counter_reset     (w_det_counter_reset    ),
    
    .o_scd_reset             (w_scd_reset            ));
  
endmodule