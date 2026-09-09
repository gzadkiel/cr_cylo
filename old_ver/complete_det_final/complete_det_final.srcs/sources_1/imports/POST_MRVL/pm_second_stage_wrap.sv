module pm_second_stage_wrap #(
    parameter NP          = 64,
              P_MAX       = 64,
              NB_DATA     = 16,
              NBF_DATA    = 15,
              NBF_DATA_O  = 13,
              NB_EXPO     = 16,  
              NB_FFT1_IN  = 32,
              NB_FFT2_OUT = 64
) (
    input logic clock,
    input logic i_enable,
    input logic i_reset,
    
    input logic [$clog2(P_MAX) : 0] i_p_frames,

    input  logic [NB_FFT1_IN - 1 : 0] i_fft1_m_axis_data_tdata, // ext input
    input  logic                      i_fft1_m_axis_data_tvalid, // ext input
    input  logic                      i_fft1_m_axis_data_tlast, // ext input
    output logic                      o_fft1_m_axis_data_tready, // ext output

    output logic [NB_FFT2_OUT - 1 : 0] o_fft2_m_axis_data_tdata, // ext output
    output logic [7               : 0] o_fft2_m_axis_data_tuser,  
    output logic                       o_fft2_m_axis_data_tvalid, // ext output  
    output logic                       o_fft2_m_axis_data_tlast, // ext output 
    input  logic                       i_fft2_m_axis_data_tready, // ext input  
    
    output logic o_scd_done,
    output logic o_det_done
);

localparam NB_CMULT1_A = 2*NB_DATA; //! cmult1 sample a (fft1 output)
localparam NB_CMULT1_B = NB_EXPO;   //! cmult1 sample b (exponential)
localparam NB_CMULT1_O = 2*NB_DATA; //! cmult1 output (after trunc) 
localparam NB_CMULT2_A = 2*NB_DATA; //! cmult2 sample a (complex product after trunc)
localparam NB_CMULT2_B = 2*NB_DATA; //! cmult2 sample a (complex product after trunc)
localparam NB_CMULT2_O = 4*NB_DATA; //! cmult2 output (full res)

localparam RAM_ROWS           = NP;         
localparam RAM_COLS           = P_MAX; // max P used      
localparam RAM_DATA_WIDTH     = 2*NB_DATA;
localparam RAM_COL_ADDR_WIDTH = $clog2(RAM_COLS);
localparam RAM_ROW_ADDR_WIDTH = $clog2(RAM_ROWS);

localparam NB_FFT2_CONFIG = 17;
localparam NB_FFT2_DATA   = NB_CMULT2_O;

// ram
logic [RAM_DATA_WIDTH     - 1 : 0] w_ram_col_data_out [RAM_ROWS];
logic [RAM_DATA_WIDTH     - 1 : 0] w_ram_data_in_reg [RAM_ROWS];
logic                              w_ram_write_enable;
logic                              w_ram_porta_enable;
logic                              w_ram_portb_col_enable;
logic                              w_ram_portb_row_enable;
logic [RAM_COL_ADDR_WIDTH - 1 : 0] w_ram_read_col_addr;
logic [RAM_ROW_ADDR_WIDTH - 1 : 0] w_ram_read_row_addr;
logic [RAM_COL_ADDR_WIDTH - 1 : 0] w_ram_write_addr;

// cmult1
logic [64          - 1 : 0] w_m_cmult1_axis_dout_tdata; //! cmult1 output using full res  
logic                       w_m_cmult1_axis_dout_tvalid;
logic                       w_s_cmult1_axis_a_tvalid;   
logic                       w_s_cmult1_axis_b_tvalid;   
logic [NB_CMULT1_A - 1 : 0] w_s_cmult1_a_sample;        
logic [NB_CMULT1_B - 1 : 0] w_s_cmult1_b_sample;           

// cmult2
logic [80          - 1 : 0] w_m_cmult2_axis_dout_tdata; //! cmult2 output using full res 
logic                       w_m_cmult2_axis_dout_tvalid;
logic                       w_s_cmult2_axis_a_tvalid;   
logic                       w_s_cmult2_axis_b_tvalid;   
logic [NB_CMULT2_A - 1 : 0] w_s_cmult2_a_sample;        
logic [NB_CMULT2_B - 1 : 0] w_s_cmult2_b_sample;        

// fft2 
logic                          w_fft2_s_axis_config_tready; 
logic [NB_FFT2_CONFIG - 1 : 0] w_fft2_s_axis_config_tdata;  
logic                          w_fft2_s_axis_config_tvalid; 
logic [NB_FFT2_DATA   - 1 : 0] w_fft2_s_axis_data_tdata; 
logic                          w_fft2_s_axis_data_tvalid;   
logic                          w_fft2_s_axis_data_tlast;    
logic                          w_fft2_s_axis_data_tready;   

// ext outputs
logic w_fft1_m_axis_data_tready;
assign o_fft1_m_axis_data_tready = w_fft1_m_axis_data_tready;

logic w_scd_done;
assign o_scd_done = w_scd_done;

logic w_det_done;
assign o_det_done = w_det_done;

logic [NB_FFT2_OUT - 1 : 0] w_fft2_m_axis_data_tdata ; // ext output 
logic [7               : 0] w_fft2_m_axis_data_tuser;  
logic                       w_fft2_m_axis_data_tvalid; // ext output  
logic                       w_fft2_m_axis_data_tlast ; // ext output 

assign o_fft2_m_axis_data_tdata  = w_fft2_m_axis_data_tdata ; // ext output  
assign o_fft2_m_axis_data_tvalid = w_fft2_m_axis_data_tvalid; // ext output  
assign o_fft2_m_axis_data_tlast  = w_fft2_m_axis_data_tlast ; // ext output 
assign o_fft2_m_axis_data_tuser  = w_fft2_m_axis_data_tuser;

cmpy_0 complex_multiplier1_ip_core (
    .aclk               (clock                      ),  // input wire aclk
    .aresetn            (!i_reset                   ),  // input wire aresetn
    .s_axis_a_tvalid    (w_s_cmult1_axis_a_tvalid   ),  // input wire s_axis_a_tvalid
    .s_axis_a_tdata     (w_s_cmult1_a_sample        ),  // input wire [31 : 0] s_axis_a_tdata
    .s_axis_b_tvalid    (w_s_cmult1_axis_b_tvalid   ),  // input wire s_axis_b_tvalid
    .s_axis_b_tdata     (w_s_cmult1_b_sample        ),  // input wire [31 : 0] s_axis_b_tdata
    .m_axis_dout_tvalid (w_m_cmult1_axis_dout_tvalid),  // output wire m_axis_dout_tvalid
    .m_axis_dout_tdata  (w_m_cmult1_axis_dout_tdata )); // output wire [63 : 0] m_axis_dout_tdata

cmpy_1 complex_multiplier2_ip_core (
    .aclk               (clock                      ),  // input wire aclk
    .aresetn            (!i_reset                   ),  // input wire aresetn
    .s_axis_a_tvalid    (w_s_cmult2_axis_a_tvalid   ),  // input wire s_axis_a_tvalid
    .s_axis_a_tdata     (w_s_cmult2_a_sample        ),  // input wire [31 : 0] s_axis_a_tdata
    .s_axis_b_tvalid    (w_s_cmult2_axis_b_tvalid   ),  // input wire s_axis_b_tvalid
    .s_axis_b_tdata     (w_s_cmult2_b_sample        ),  // input wire [31 : 0] s_axis_b_tdata
    .m_axis_dout_tvalid (w_m_cmult2_axis_dout_tvalid),  // output wire m_axis_dout_tvalid
    .m_axis_dout_tdata  (w_m_cmult2_axis_dout_tdata )); // output wire [63 : 0] m_axis_dout_tdata

ram2d_col_write_col_read_ns # (
    .ROWS (RAM_ROWS), .COLS (RAM_COLS), .W (RAM_DATA_WIDTH))
new_ram_test (
    .clk         (clock                 ),
    .wr_port_en  (w_ram_porta_enable    ),
    .wr_col_en   (w_ram_write_enable    ),
    .wr_col      (w_ram_write_addr      ),
    .wr_col_data (w_ram_data_in_reg     ),
    .rd_col_en   (w_ram_portb_col_enable),
    .rd_col      (w_ram_read_col_addr   ),
    .rd_col_data (w_ram_col_data_out    ));

xfft_1 p_point_fft ( 
    .aclk                        (clock                      ),  
    .aresetn                     (!i_reset                   ),  
    .s_axis_config_tdata         (w_fft2_s_axis_config_tdata ),  
    .s_axis_config_tvalid        (w_fft2_s_axis_config_tvalid),  
    .s_axis_config_tready        (w_fft2_s_axis_config_tready),  
    .s_axis_data_tdata           (w_fft2_s_axis_data_tdata   ),  
    .s_axis_data_tvalid          (w_fft2_s_axis_data_tvalid  ),  
    .s_axis_data_tready          (w_fft2_s_axis_data_tready  ),  
    .s_axis_data_tlast           (w_fft2_s_axis_data_tlast   ),  
    .m_axis_data_tdata           (w_fft2_m_axis_data_tdata   ), // ext output  
    .m_axis_data_tuser           (w_fft2_m_axis_data_tuser   ), // output wire [7 : 0] m_axis_data_tuser
    .m_axis_data_tvalid          (w_fft2_m_axis_data_tvalid  ), // ext output  
    .m_axis_data_tready          (i_fft2_m_axis_data_tready  ), // ext input  
    .m_axis_data_tlast           (w_fft2_m_axis_data_tlast   ), // ext output 
    .event_frame_started         (),  
    .event_tlast_unexpected      (), 
    .event_tlast_missing         (),  
    .event_status_channel_halt   (),  
    .event_data_in_channel_halt  (),  
    .event_data_out_channel_halt ()); 

fft_done_detector # (
    .TIMEOUT_CYCLES (1000)) // hardcoded, could be changed
fft_done_detector_inst (
    .clock         (clock                    ),
    .i_reset       (i_reset                  ),
    .i_enable      (i_enable                 ),
    .s_axis_tvalid (w_fft2_m_axis_data_tvalid),
    .s_axis_tready (i_fft2_m_axis_data_tready),
    .s_axis_tlast  (w_fft2_m_axis_data_tlast ),
    .done          (w_det_done               ));

second_stage_fsmd # (
    .NB_FFT1_DATA       (NB_FFT1_IN        ),
    .NB_FFT2_CONFIG     (NB_FFT2_CONFIG    ),
    .NB_FFT2_DATA       (NB_FFT2_DATA      ),
    .NB_CMULT1_A        (NB_CMULT1_A       ),
    .NBF_CMULT1_A       (NBF_DATA_O        ),  
    .NB_CMULT1_B        (NB_CMULT1_B       ),
    .NB_CMULT1_O        (NB_CMULT1_O       ),
    .NB_CMULT2_A        (NB_CMULT2_A       ),
    .NB_CMULT2_B        (NB_CMULT2_B       ),
    .NB_CMULT2_O        (NB_CMULT2_O       ),
    .RAM_DATA_WIDTH     (RAM_DATA_WIDTH    ),
    .RAM_COL_ADDR_WIDTH (RAM_COL_ADDR_WIDTH),
    .RAM_ROW_ADDR_WIDTH (RAM_ROW_ADDR_WIDTH),
    .NP                 (NP                ),
    .P_MAX              (P_MAX             ),
    .NB_DATA            (NB_DATA           ),
    .NBF_DATA           (NBF_DATA          ))
second_stage_fsmd_inst (
    .clock                       (clock                      ),
    .i_reset                     (i_reset                    ),
    .i_enable                    (i_enable                   ),
    .i_p_frames                  (i_p_frames                 ),
    .i_fft1_m_axis_data_tdata    (i_fft1_m_axis_data_tdata   ), // ext input
    .i_fft1_m_axis_data_tvalid   (i_fft1_m_axis_data_tvalid  ), // ext input
    .i_fft1_m_axis_data_tlast    (i_fft1_m_axis_data_tlast   ), // ext input
    .o_fft1_m_axis_data_tready   (w_fft1_m_axis_data_tready  ), // ext output
    .i_fft2_s_axis_config_tready (w_fft2_s_axis_config_tready),
    .o_fft2_s_axis_config_tdata  (w_fft2_s_axis_config_tdata ),
    .o_fft2_s_axis_config_tvalid (w_fft2_s_axis_config_tvalid),
    .o_fft2_s_axis_data_tdata    (w_fft2_s_axis_data_tdata   ),
    .o_fft2_s_axis_data_tvalid   (w_fft2_s_axis_data_tvalid  ),
    .o_fft2_s_axis_data_tlast    (w_fft2_s_axis_data_tlast   ),
    .i_fft2_s_axis_data_tready   (w_fft2_s_axis_data_tready  ),
    .i_m_cmult1_axis_dout_tdata  (w_m_cmult1_axis_dout_tdata ),
    .i_m_cmult1_axis_dout_tvalid (w_m_cmult1_axis_dout_tvalid),
    .o_s_cmult1_axis_a_tvalid    (w_s_cmult1_axis_a_tvalid   ),
    .o_s_cmult1_axis_b_tvalid    (w_s_cmult1_axis_b_tvalid   ),
    .o_s_cmult1_a_sample         (w_s_cmult1_a_sample        ),
    .o_s_cmult1_b_sample         (w_s_cmult1_b_sample        ),
    .i_m_cmult2_axis_dout_tdata  (w_m_cmult2_axis_dout_tdata ),
    .i_m_cmult2_axis_dout_tvalid (w_m_cmult2_axis_dout_tvalid),
    .o_s_cmult2_axis_a_tvalid    (w_s_cmult2_axis_a_tvalid   ),
    .o_s_cmult2_axis_b_tvalid    (w_s_cmult2_axis_b_tvalid   ),
    .o_s_cmult2_a_sample         (w_s_cmult2_a_sample        ),
    .o_s_cmult2_b_sample         (w_s_cmult2_b_sample        ),
    .i_ram_col_data_out          (w_ram_col_data_out         ),
    .o_ram_data_in_reg           (w_ram_data_in_reg          ),
    .o_ram_write_en              (w_ram_write_enable         ),
    .o_ram_porta_en              (w_ram_porta_enable         ),
    .o_ram_portb_col_en          (w_ram_portb_col_enable     ),
    .o_ram_portb_row_en          (w_ram_portb_row_enable     ),
    .o_ram_read_col_addr         (w_ram_read_col_addr        ),
    .o_ram_read_row_addr         (w_ram_read_row_addr        ),
    .o_ram_write_addr            (w_ram_write_addr           ),
    .o_scd_done                  (w_scd_done                 )); // ext output 

endmodule