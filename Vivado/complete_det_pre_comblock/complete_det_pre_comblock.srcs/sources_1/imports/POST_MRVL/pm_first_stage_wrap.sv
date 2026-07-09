module pm_first_stage_wrap #(
    parameter P_MAX      = 64, 
              NP         = 64,
              NB_DATA_I  = 12,  
              NBF_DATA_I = 11,
              NB_WINDOW  = 8,
              NBF_WINDOW = 7,
              NB_DATA_O  = 16, 
              NBF_DATA_O = 15
) (
    input  logic                              clock,
    input  logic                              i_reset,
    input  logic                              i_enable,
    input  logic signed [NB_DATA_I   - 1 : 0] i_sample_re,    
    input  logic signed [NB_DATA_I   - 1 : 0] i_sample_im,
    input  logic        [1               : 0] i_window_sel,
    input  logic                              i_scd_done,
    input  logic        [$clog2(P_MAX)   : 0] i_p_frames, // added
    input  logic                              i_fft1_m_axis_data_tready,
    output logic        [2*NB_DATA_O - 1 : 0] o_fft1_m_axis_data_tdata,  
    output logic                              o_fft1_m_axis_data_tlast,  
    output logic                              o_fft1_m_axis_data_tvalid 
);

logic w_input_win_enable;

localparam ADDR_WIDTH = $clog2(P_MAX); // using P_max value, with N 1024 and L 16
localparam FFT_DWIDTH = 2*NB_DATA_O;
localparam FFT_CWIDTH = 7;

// window
logic signed [NB_DATA_O - 1 : 0] w_window_output_re [NP];
logic                            w_window_output_valid_re; 
logic signed [NB_DATA_O - 1 : 0] w_window_output_im [NP];
logic                            w_window_output_valid_im;

// ram
logic                             w_ram_write_port_en;
logic                             w_ram_read_port_en;
logic        [ADDR_WIDTH - 1 : 0] w_ram_write_addr;
logic        [ADDR_WIDTH - 1 : 0] w_ram_read_addr;
logic signed [NB_DATA_O  - 1 : 0] w_ram_data_out_re [NP];
logic signed [NB_DATA_O  - 1 : 0] w_ram_data_out_im [NP];

// fft
logic [FFT_CWIDTH - 1 : 0] w_fft1_s_axis_config_tdata;
logic                      w_fft1_s_axis_config_tvalid; 
logic                      w_fft1_s_axis_config_tready;
// added 
logic                      l_fft1_s_axis_config_tready;
//
logic [FFT_DWIDTH - 1 : 0] w_fft1_s_axis_data_tdata;       
logic                      w_fft1_s_axis_data_tvalid;
logic                      w_fft1_s_axis_data_tready;
logic                      w_fft1_s_axis_data_tlast; 
logic [FFT_DWIDTH - 1 : 0] w_fft1_m_axis_data_tdata; 
logic                      w_fft1_m_axis_data_tvalid;
logic                      w_fft1_m_axis_data_tlast; 

// DEBUG FFT1 Outputs --------------------------------------------------------------
//logic signed [15 : 0] FFT1_OUT_IM,FFT1_OUT_RE;
//logic signed [32 : 0] MODULO_QUAD_FFT1;
//assign FFT1_OUT_IM = w_fft1_m_axis_data_tdata[31 : 16];
//assign FFT1_OUT_RE = w_fft1_m_axis_data_tdata[15 : 0];
//assign MODULO_QUAD_FFT1 = FFT1_OUT_IM*FFT1_OUT_IM + FFT1_OUT_RE*FFT1_OUT_RE;
// ---------------------------------------------------------------------------------

always_latch begin : blockName
    if (w_fft1_s_axis_config_tvalid) l_fft1_s_axis_config_tready = '1;
    else l_fft1_s_axis_config_tready = '0;
end

// wire outputs
assign o_fft1_m_axis_data_tdata  = w_fft1_m_axis_data_tdata;  
assign o_fft1_m_axis_data_tlast  = w_fft1_m_axis_data_tlast;
assign o_fft1_m_axis_data_tvalid = w_fft1_m_axis_data_tvalid;

// last update
logic [2*NB_DATA_O - 1 : 0] w_combined_win_output [NP];
logic [2*NB_DATA_O - 1 : 0] w_ram_data_out [NP];
logic w_win_out_valid;
assign w_win_out_valid = w_window_output_valid_re & w_window_output_valid_im;
 
genvar i;
generate
    for (i = 0; i < NP; i++) begin : GEN_COMPLEX_PACK
        assign w_combined_win_output[i] = {w_window_output_im[i], w_window_output_re[i]};
    end
endgenerate
// -----------

pm_input_window # (
    .NP         (NP),
    .NB_SAMPLES (NB_DATA_I ), .NBF_SAMPLES (NBF_DATA_I ),
    .NB_WINDOWS (NB_WINDOW ), .NBF_WINDOWS (NBF_WINDOW ),
    .NB_OUTPUT  (NB_DATA_O ), .NBF_OUTPUT  (NBF_DATA_O ))
input_window_real (
    .clock        (clock                         ), 
    .i_reset      (i_reset                       ), 
    .i_enable     (i_enable && w_input_win_enable),
    .i_window_sel (i_window_sel                  ), 
    .i_x          (i_sample_re                   ),
    .o_product    (w_window_output_re            ), 
    .o_valid      (w_window_output_valid_re      ));

pm_input_window # (
    .NP         (NP),
    .NB_SAMPLES (NB_DATA_I ), .NBF_SAMPLES (NBF_DATA_I ),
    .NB_WINDOWS (NB_WINDOW ), .NBF_WINDOWS (NBF_WINDOW ),
    .NB_OUTPUT  (NB_DATA_O ), .NBF_OUTPUT  (NBF_DATA_O ))
input_window_imag (
    .clock        (clock                         ), 
    .i_reset      (i_reset                       ), 
    .i_enable     (i_enable && w_input_win_enable),
    .i_window_sel (i_window_sel                  ), 
    .i_x          (i_sample_im                   ),
    .o_product    (w_window_output_im            ), 
    .o_valid      (w_window_output_valid_im      ));

ram2d_col_write_col_read # (
    // using P_max value, with N 1024 and L 16
    .ROWS (NP), .COLS (P_MAX), .W (2*NB_DATA_O))
real_ram (
    .clk         (clock                   ),
    .wr_port_en  (w_ram_write_port_en     ),
    .wr_col_en   (w_win_out_valid         ),
    .wr_col      (w_ram_write_addr        ),
    .wr_col_data (w_combined_win_output   ),
    .rd_col_en   (w_ram_read_port_en      ),
    .rd_col      (w_ram_read_addr         ),
    .rd_col_data (w_ram_data_out          ));

xfft_0 np_point_fft ( 
    .aclk                        (clock                      ),
    .aresetn                     (!i_reset                   ),
    .s_axis_config_tdata         (w_fft1_s_axis_config_tdata ),
    .s_axis_config_tvalid        (w_fft1_s_axis_config_tvalid),
    .s_axis_config_tready        (w_fft1_s_axis_config_tready),
    .s_axis_data_tdata           (w_fft1_s_axis_data_tdata   ),
    .s_axis_data_tvalid          (w_fft1_s_axis_data_tvalid  ),
    .s_axis_data_tready          (w_fft1_s_axis_data_tready  ),
    .s_axis_data_tlast           (w_fft1_s_axis_data_tlast   ),
    .m_axis_data_tdata           (w_fft1_m_axis_data_tdata   ),
    .m_axis_data_tvalid          (w_fft1_m_axis_data_tvalid  ),
    .m_axis_data_tready          (i_fft1_m_axis_data_tready  ),
    .m_axis_data_tlast           (w_fft1_m_axis_data_tlast   ),
    .event_frame_started         (),  
    .event_tlast_unexpected      (),  
    .event_tlast_missing         (),  
    .event_status_channel_halt   (),  
    .event_data_in_channel_halt  (),  
    .event_data_out_channel_halt ()); 

first_stage_fsmd # (
    .P_MAX            (P_MAX     ),
    .NP               (NP        ),
    .NB_DATA          (NB_DATA_O ),
    .NBF_DATA         (NBF_DATA_O),
    .NB_WIN           (NB_WINDOW ),
    .NBF_WIN          (NBF_WINDOW),
    .AXI_CONFIG_WIDTH (FFT_CWIDTH))
first_stage_fsmd_control (
    .clock                  (clock                      ),
    .i_reset                (i_reset                    ),
    .i_enable               (i_enable                   ),
    .i_scd_done             (i_scd_done                 ),
    .i_p_frames             (i_p_frames                 ),
    .o_input_win_enable     (w_input_win_enable         ),
    .i_s_axis_data_tready   (w_fft1_s_axis_data_tready  ),
    .o_s_axis_data_tlast    (w_fft1_s_axis_data_tlast   ),
    .o_s_axis_data_tvalid   (w_fft1_s_axis_data_tvalid  ),
    .o_s_axis_data_tdata    (w_fft1_s_axis_data_tdata   ),
    .i_s_axis_config_tready (l_fft1_s_axis_config_tready),
    .o_s_axis_config_tvalid (w_fft1_s_axis_config_tvalid),
    .o_s_axis_config_tdata  (w_fft1_s_axis_config_tdata ),
    .i_window_prod_valid_re (w_window_output_valid_re   ),
    .i_window_prod_valid_im (w_window_output_valid_im   ),
    .i_ram_data_out         (w_ram_data_out             ),
    .o_ram_porta_enable     (w_ram_write_port_en        ),
    .o_ram_portb_enable     (w_ram_read_port_en         ),
    .o_ram_write_addr       (w_ram_write_addr           ),
    .o_ram_read_addr        (w_ram_read_addr            ));

endmodule