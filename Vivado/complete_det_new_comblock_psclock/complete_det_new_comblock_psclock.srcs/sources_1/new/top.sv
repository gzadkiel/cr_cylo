module top #(
    parameter N_DESIRED        = 1024,  
              NB_DATA          = 12,
              NBF_DATA         = 9,
              NP_SAMPLES       = 32,
              P_MAX            = 128,
              N_NOISE_SAMPLES  = 256,
              NB_THRESHOLD     = 65,
              NBF_THRESHOLD    = 62,
              NB_WINDOW_COEFF  = 8,
              NBF_WINDOW_COEFF = 7,
              NB_EXP_COEFF     = 16,
              NB_DETECT        = 16
) (
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

    // PL clock (from board oscillator or MMCM output)
    // input clock
);

// CLOCK FROM PS 
logic ps_clock;

// comblock to comblock adapter signals
logic                     w_cb_OUT_FIFO_0_fifo_aempty_o;   
logic [2*NB_DATA - 1 : 0] w_cb_OUT_FIFO_0_fifo_data_o;      
logic                     w_cb_OUT_FIFO_0_fifo_empty_o;     
logic                     w_cb_OUT_FIFO_0_fifo_underflow_o; 
logic                     w_cb_OUT_FIFO_0_fifo_valid_o;     
logic                     w_cb_OUT_FIFO_0_fifo_re_i;      
logic [31            : 0] w_cb_OUT_REGS_0_reg0_o;
logic [31            : 0] w_cb_IN_REGS_0_reg0_i;

// comblock adapter to top mux signals
logic                          top_mux_reset;             
logic                          top_mux_enable;            
logic                          top_mux_noise_data_valid;  
logic                          top_mux_signal_data_valid; 
logic signed [NB_DATA - 1 : 0] top_mux_data_re;           
logic signed [NB_DATA - 1 : 0] top_mux_data_im;           
logic        [10          : 0] top_mux_data_size;         
logic        [8           : 0] top_mux_noise_size;        
logic        [1           : 0] top_mux_window_sel;        
logic        [3           : 0] top_mux_pfa_value;         
logic        [15          : 0] top_mux_detect;            
logic                          top_mux_est_done;          
logic                          top_mux_detection_done;    
logic                          top_mux_threshold_est_done;

comblock_adapter # (.NB_SAMPLE_DATA(NB_DATA))
comblock_adapter_inst (
    .clock                            (ps_clock                        ),
    .i_cb_OUT_FIFO_0_fifo_aempty_o    (w_cb_OUT_FIFO_0_fifo_aempty_o   ),
    .i_cb_OUT_FIFO_0_fifo_data_o      (w_cb_OUT_FIFO_0_fifo_data_o     ),
    .i_cb_OUT_FIFO_0_fifo_empty_o     (w_cb_OUT_FIFO_0_fifo_empty_o    ),
    .i_cb_OUT_FIFO_0_fifo_underflow_o (w_cb_OUT_FIFO_0_fifo_underflow_o),
    .i_cb_OUT_FIFO_0_fifo_valid_o     (w_cb_OUT_FIFO_0_fifo_valid_o    ),
    .o_cb_OUT_FIFO_0_fifo_re_i        (w_cb_OUT_FIFO_0_fifo_re_i       ),
    .i_cb_OUT_REGS_0_reg0_o           (w_cb_OUT_REGS_0_reg0_o          ),
    .o_cb_IN_REGS_0_reg0_i            (w_cb_IN_REGS_0_reg0_i           ),
    .top_mux_reset                    (top_mux_reset                   ),
    .top_mux_enable                   (top_mux_enable                  ),
    .top_mux_noise_data_valid         (top_mux_noise_data_valid        ),
    .top_mux_signal_data_valid        (top_mux_signal_data_valid       ),
    .top_mux_data_size                (top_mux_data_size               ),
    .top_mux_noise_size               (top_mux_noise_size              ),
    .top_mux_window_sel               (top_mux_window_sel              ),
    .top_mux_pfa_value                (top_mux_pfa_value               ),
    .top_mux_data_re                  (top_mux_data_re                 ),
    .top_mux_data_im                  (top_mux_data_im                 ),
    .top_mux_detect                   (top_mux_detect                  ),
    .top_mux_detection_done           (top_mux_detection_done          ),
    .top_mux_threshold_est_done       (top_mux_threshold_est_done      ));

pm_top_mux # (
    .N_DESIRED        (N_DESIRED       ),
    .NB_SAMPLE_DATA   (NB_DATA         ),
    .NBF_SAMPLE_DATA  (NBF_DATA        ),
    .NP_SAMPLES       (NP_SAMPLES      ),
    .P_MAX            (P_MAX           ),
    .N_NOISE_SAMPLES  (N_NOISE_SAMPLES ),
    .NB_THRESHOLD     (NB_THRESHOLD    ),
    .NBF_THRESHOLD    (NBF_THRESHOLD   ),
    .NB_WINDOW_COEFF  (NB_WINDOW_COEFF ),
    .NBF_WINDOW_COEFF (NBF_WINDOW_COEFF),
    .NB_EXP_COEFF     (NB_EXP_COEFF    ),
    .NB_DETECT        (NB_DETECT       ))
pm_top_mux_inst (
    .clock                (ps_clock                  ),                  
    .i_reset              (top_mux_reset             ),
    .i_enable             (top_mux_enable            ),
    .i_noise_data_valid   (top_mux_noise_data_valid  ),
    .i_signal_data_valid  (top_mux_signal_data_valid ),
    .i_data_size          (top_mux_data_size         ),
    .i_noise_size         (top_mux_noise_size        ),
    .i_window_sel         (top_mux_window_sel        ),
    .i_pfa_value          (top_mux_pfa_value         ),
    .i_data_re            (top_mux_data_re           ),
    .i_data_im            (top_mux_data_im           ),
    .o_detect             (top_mux_detect            ),
    .o_est_done           (                          ),
    .o_detection_done     (top_mux_detection_done    ),
    .o_threshold_est_done (top_mux_threshold_est_done));

comblock_setup_wrapper comblock_setup_wrapper_inst (
    .DDR_addr                    (DDR_addr                        ),
    .DDR_ba                      (DDR_ba                          ),
    .DDR_cas_n                   (DDR_cas_n                       ),
    .DDR_ck_n                    (DDR_ck_n                        ),
    .DDR_ck_p                    (DDR_ck_p                        ),
    .DDR_cke                     (DDR_cke                         ),
    .DDR_cs_n                    (DDR_cs_n                        ),
    .DDR_dm                      (DDR_dm                          ),
    .DDR_dq                      (DDR_dq                          ),
    .DDR_dqs_n                   (DDR_dqs_n                       ),
    .DDR_dqs_p                   (DDR_dqs_p                       ),
    .DDR_odt                     (DDR_odt                         ),
    .DDR_ras_n                   (DDR_ras_n                       ),
    .DDR_reset_n                 (DDR_reset_n                     ),
    .DDR_we_n                    (DDR_we_n                        ),
    .FIXED_IO_ddr_vrn            (FIXED_IO_ddr_vrn                ),
    .FIXED_IO_ddr_vrp            (FIXED_IO_ddr_vrp                ),
    .FIXED_IO_mio                (FIXED_IO_mio                    ),
    .FIXED_IO_ps_clk             (FIXED_IO_ps_clk                 ),
    .FIXED_IO_ps_porb            (FIXED_IO_ps_porb                ),
    .FIXED_IO_ps_srstb           (FIXED_IO_ps_srstb               ),
    .IN_REGS_0_reg0_i            (w_cb_IN_REGS_0_reg0_i           ),
    .OUT_FIFO_0_fifo_aempty_o    (w_cb_OUT_FIFO_0_fifo_aempty_o   ),
    .OUT_FIFO_0_fifo_data_o      (w_cb_OUT_FIFO_0_fifo_data_o     ),
    .OUT_FIFO_0_fifo_empty_o     (w_cb_OUT_FIFO_0_fifo_empty_o    ),
    .OUT_FIFO_0_fifo_re_i        (w_cb_OUT_FIFO_0_fifo_re_i       ),
    .OUT_FIFO_0_fifo_underflow_o (w_cb_OUT_FIFO_0_fifo_underflow_o),
    .OUT_FIFO_0_fifo_valid_o     (w_cb_OUT_FIFO_0_fifo_valid_o    ),
    .OUT_REGS_0_reg0_o           (w_cb_OUT_REGS_0_reg0_o          ),
    .PS_CLOCK0                   (ps_clock                        ),
    .fifo_clear_i_0              (top_mux_reset                   ),
    .fifo_clk_i_0                (clock                           ));
    
endmodule