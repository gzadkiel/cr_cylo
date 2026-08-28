module theshold_calculator #(
	parameter N_NOISE_SAMPLES_MAX = 256,
			  NB_DATA	   	      = 12, 
			  NBF_DATA     	      = 9,
			  NB_THRESHOLD 	      = 65,
			  NBF_THRESHOLD       = 62
) (
	input  logic 	 	  					              clock,
	input  logic 	 	  					              i_enable,
	input  logic 	 	  					              i_reset,
	input  logic                                          i_scd_mode,
	input  logic        [1                           : 0] i_win_sel,
	input  logic        [$clog2(N_NOISE_SAMPLES_MAX) : 0] i_noise_size,
	input  logic        [10                          : 0] i_data_size,
	input  logic signed [NB_DATA                 - 1 : 0] i_data_sample,
	input  logic        [3                           : 0] i_pfa,
	output logic signed [NB_THRESHOLD            - 1 : 0] o_estimated_threshold,
	output logic                                          o_thres_est_done // notify PS
);

// localparam
// MACC N samples, NB_DATA bits each -> Output Width is 2*NB_DATA + log2(N)
localparam NB_MACC_OUT        = 2*NB_DATA + $clog2(N_NOISE_SAMPLES_MAX); //! MACC module output width
localparam NBF_MACC_OUT       = 2*NBF_DATA; //! MACC module output fractional bits 
localparam N_PFA        	  = 10; //! Number of false alarm prob values
localparam NB_BASE_THRESHOLD  = NB_THRESHOLD; //! Threshold ROM data width
localparam NBF_BASE_THRESHOLD = NBF_THRESHOLD; //! Base threshold frac bits, all base values are <<< 1         
localparam NB_PROD 		      = NB_MACC_OUT + NB_MACC_OUT + NB_BASE_THRESHOLD;  
localparam NBF_PROD           = 2*NBF_MACC_OUT + NBF_BASE_THRESHOLD; //! Number of frac bits of product signal (r_prod)
localparam NBI_TRUNC          = (NB_PROD - NBF_PROD) - ((NB_THRESHOLD - NBF_THRESHOLD) - 1); //! Bits to analize in order to trunc output 

// signals
logic signed [NB_MACC_OUT 		- 1 : 0] r_estimated_var;
logic signed [NB_BASE_THRESHOLD - 1 : 0] r_base_threshold;
logic 								     w_var_done;
logic signed [NB_PROD			- 1 : 0] r_threshold_value;

// added to notify PS noise estimation is done
assign o_thres_est_done = w_var_done;

// reg to solve timing issues
always_ff @(posedge clock) begin
    r_threshold_value <= r_base_threshold * r_estimated_var * r_estimated_var;
end

logic signed [NB_THRESHOLD - 1 : 0] w_threhsold, r_threshold; 

// truncate result match comparison output size
assign w_threhsold = (~|r_threshold_value[NB_PROD - 1 -: NBI_TRUNC] || &r_threshold_value[NB_PROD - 1 -: NBI_TRUNC]) ?  
                                r_threshold_value[NB_PROD - NBI_TRUNC -: NB_THRESHOLD] : (r_threshold_value[NB_PROD - 1]) ? 
                                {1'b1,{NB_THRESHOLD - 1{1'b0}}} : {1'b0,{NB_THRESHOLD - 1{1'b1}}};

// reg to solve timing issues
always_ff @(posedge clock) begin
    if (i_reset) r_threshold <= '0;
    else r_threshold <= w_threhsold; 
end

assign o_estimated_threshold = r_threshold;

threshold_rom # (
  .N_PFA 	(N_PFA            ),
  .NB_OUT	(NB_BASE_THRESHOLD))
threshold_rom_inst (
  .clock       (clock            ),
  .i_scd_mode  (i_scd_mode       ),
  .i_pfa_value (i_pfa 		 	 ),
  .i_win_sel   (i_win_sel        ), 
  .i_data_size (i_data_size      ),
  .o_threshold (r_base_threshold));

noise_calc # (
    .NB_DATA  	(NB_DATA            ),
    .N_SAMPLES	(N_NOISE_SAMPLES_MAX),
    .NB_OUT   	(NB_MACC_OUT        ))
noise_calc_inst (
    .clk       	  (clock	      ),
    .i_reset   	  (i_reset		  ),
    .i_cenable 	  (i_enable		  ),
    .i_noise_size (i_noise_size   ),
    .i_data    	  (i_data_sample  ),
    .o_variance	  (r_estimated_var),
    .o_div_done	  (w_var_done 	  ));

endmodule