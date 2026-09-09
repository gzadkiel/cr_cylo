module pm_top_mux #(
	parameter N_DESIRED        = 1024, //! number of total samples used for estimation 
			  NB_SAMPLE_DATA   = 12,   //! number of bits of input sample
			  NBF_SAMPLE_DATA  = 9,    //! number of frac bits of input sample
			  NP_SAMPLES       = 32,   //! number of samples per frame (np-point fft)
			  P_MAX            = 128,
			  N_NOISE_SAMPLES  = 256, //! number of samples used for noise power estimation
			  NB_THRESHOLD     = 65,  //! number of bits of threshold
			  NBF_THRESHOLD    = 46,  //! number of frac bits of threshold
			  NB_WINDOW_COEFF  = 8,   //! number of bits used for window coeff
              NBF_WINDOW_COEFF = 7,
			  NB_EXP_COEFF     = 16,  //! number of bits used for exponential coeff
              NB_DETECT        = 16   // np*np*p // 2, temp
) (
	input  logic clock,    //! system clock
	input  logic i_reset,  //! system reset
	input  logic i_enable, //! enable
	
	input  logic i_noise_data_valid,  //! control signal from PS, indicates valid noise data
	input  logic i_signal_data_valid, //! control signal from PS, indicates valid signal data
	
	input  logic        [1                      : 0] i_window_sel, //! window type select (rect, hamm or blackman)
	input  logic        [$clog2(N_DESIRED)      : 0] i_data_size,  //! number of data samples used for SCD estimation
	input  logic        [$clog2(N_NOISE_SAMPLES): 0] i_noise_size, //! number of noise samples used for threshold estimation
	input  logic signed [NB_SAMPLE_DATA     - 1 : 0] i_data_re,	   //! in-phase data sample
	input  logic signed [NB_SAMPLE_DATA     - 1 : 0] i_data_im,    //! quadrature data sample
	input  logic 	    [3                      : 0] i_pfa_value,  //! false alarm probability for threshold
	
	input logic i_scd_mode,
	
	output logic signed [NB_THRESHOLD                               - 1 : 0] o_threshold,
	output logic signed [2*NB_SAMPLE_DATA + $clog2(N_NOISE_SAMPLES) - 1 : 0] o_noise_pow,
	
	output logic [NB_DETECT - 1 : 0] o_detect,            //! number of detections after run
    output logic                     o_est_done,          //! internal estimation done signal
    output logic                     o_detection_done,    //! indicates PS detection is done
    output logic                     o_threshold_est_done //! indicates PS threshold estimation is done
);
  
//==============================================================================
// input_window output resolution configuration
localparam NB_DATA_WIN_O  = 16; //! number of total bits for input_window output 
localparam NBF_DATA_WIN_O = 13; //! number of frac bits for input_window output
//==============================================================================

//==============================================================================
// define input_window parameter L
localparam L     = NP_SAMPLES / 4; //! decimation parameter 
localparam L_DIV = $clog2(L);      //! bits to shift for equiv division by L
//==============================================================================

//==============================================================================
// define fft2 output data size in format (Im,Re)
localparam SCD_DATA_OUT = 64;
//==============================================================================

//==============================================================================
// calculate number of required frames P and number of total samples N_tot
logic [$clog2(P_MAX) : 0] r_p_frames;
// P_FRAMES = N_DESIRED / L number of frames 
assign r_p_frames = i_data_size >> L_DIV; 

logic [$clog2(N_DESIRED) : 0] r_n_tot;
// N_TOT = (P_FRAMES - 1)*L + NP_SAMPLES number of total samples required
assign r_n_tot = ((r_p_frames - 1'b1) << L_DIV) + 11'b00001000000; 
//==============================================================================

//==============================================================================
logic                                 w_scd_estimate_en; //! SCD estimator module enable signal
logic                                 w_scd_reset;       //! SCD estimator module reset signal
logic                                 w_detection_done;  //! SCD estimator detection done signal (indicates PS)
logic                                 w_estimation_done; //! SCD estimator estimation done signal
logic signed [NB_SAMPLE_DATA - 1 : 0] w_data_sample_re;  //! in-phase data sample
logic signed [NB_SAMPLE_DATA - 1 : 0] w_data_sample_im;  //! quadrature data sample

logic [SCD_DATA_OUT - 1 : 0] w_fft2_m_axis_data_tdata;  //! SCD estimator output data
logic [7                : 0] w_fft2_m_axis_data_tuser;  //! SCD estimator output data index
logic 						 w_fft2_m_axis_data_tready; //! axi-stream tready
logic 						 w_fft2_m_axis_data_tvalid; //! axi-stream tvalid
logic 						 w_fft2_m_axis_data_tlast;  //! axi-steam tlast

logic                               w_threshold_estimate_en; //! threshold calculator module enable signal
logic signed [NB_THRESHOLD - 1 : 0] w_estimated_thres;       //! calculated threshold
logic                               w_threshold_est_done;    //! threshold calculation done (indicates PS) 

logic signed [2*NB_SAMPLE_DATA + $clog2(N_NOISE_SAMPLES) - 1 : 0] w_estimated_noise_pow;

logic [NB_DETECT - 1 : 0] w_detect_counter;    //! number of detections
logic                     w_compare_detect_en; //! detection module enable signal
logic                     w_det_counter_reset; //! detection module reset signal

assign o_detect             = w_detect_counter;
assign o_est_done           = w_estimation_done;
assign o_detection_done     = w_detection_done; // added
assign o_threshold_est_done = w_threshold_est_done; // added

assign o_threshold = w_estimated_thres;
assign o_noise_pow = w_estimated_noise_pow;
    
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
    .i_scd_mode                (i_scd_mode                    ),
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
theshold_calculator_inst (
    .clock                   (clock                  ),
    .i_enable                (w_threshold_estimate_en),
    .i_reset                 (i_reset                ),
    .i_scd_mode              (i_scd_mode             ),
    .i_win_sel               (i_window_sel           ),
    .i_noise_size            (i_noise_size           ),
    .i_data_size             (i_data_size            ),
    .i_data_sample           (w_data_sample_re       ),
    .i_pfa                   (i_pfa_value            ),
    .o_estimated_threshold   (w_estimated_thres      ),
    .o_estimared_noise_power (w_estimated_noise_pow  ),
    .o_thres_est_done        (w_threshold_est_done   )); // to PS

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
scd_estimator_inst (
    .clock                   (clock                    ),
    .i_reset                 (i_reset ||  w_scd_reset  ), // reset in between runs
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
    .i_scd_estimate_done     (w_detection_done       ), 
    .o_threshold_estimate_en (w_threshold_estimate_en),
    .o_scd_estimate_en       (w_scd_estimate_en      ),
    .o_compare_detect_en     (w_compare_detect_en    ),
    .o_det_counter_reset     (w_det_counter_reset    ),
    .o_scd_reset             (w_scd_reset            ));
  
endmodule