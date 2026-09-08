module second_stage_fsmd #(
    parameter NB_FFT1_DATA       = 32,
              NB_FFT2_CONFIG     = 17,
              NB_FFT2_DATA       = 32,
              NB_CMULT1_A        = 32,
              NBF_CMULT1_A       = 13, // added
              NB_CMULT1_B        = 16,
              NB_CMULT1_O        = 32,
              NB_CMULT2_A        = 32,
              NB_CMULT2_B        = 32,
              NB_CMULT2_O        = 32,
              RAM_DATA_WIDTH     = 32, 
              RAM_COL_ADDR_WIDTH = 6,
              RAM_ROW_ADDR_WIDTH = 6,
              NP                 = 64,
              P_MAX              = 64,
              NB_DATA            = 16,
              NBF_DATA           = 15 // added
) (
    input logic clock,
    input logic i_reset,
    input logic i_enable,

    input logic [$clog2(P_MAX) : 0] i_p_frames,

    // fft
    input  logic [NB_FFT1_DATA  - 1 : 0] i_fft1_m_axis_data_tdata,
    input  logic                         i_fft1_m_axis_data_tvalid,
    input  logic                         i_fft1_m_axis_data_tlast,
    output logic                         o_fft1_m_axis_data_tready,

    input  logic                          i_fft2_s_axis_config_tready,
    output logic [NB_FFT2_CONFIG - 1 : 0] o_fft2_s_axis_config_tdata,
    output logic                          o_fft2_s_axis_config_tvalid,
    output logic [NB_FFT2_DATA   - 1 : 0] o_fft2_s_axis_data_tdata, 
    output logic                          o_fft2_s_axis_data_tvalid,
    output logic                          o_fft2_s_axis_data_tlast,
    input  logic                          i_fft2_s_axis_data_tready,

    // cmult
    input  logic [64           - 1 : 0] i_m_cmult1_axis_dout_tdata,  // cmult1 output sample
    input  logic                        i_m_cmult1_axis_dout_tvalid, // cmult output data_tvalid
    output logic                        o_s_cmult1_axis_a_tvalid,    
    output logic                        o_s_cmult1_axis_b_tvalid,    
    output logic [NB_CMULT1_A  - 1 : 0] o_s_cmult1_a_sample,
    output logic [NB_CMULT1_B  - 1 : 0] o_s_cmult1_b_sample,
    
    input  logic [80          - 1 : 0] i_m_cmult2_axis_dout_tdata,
    input  logic                       i_m_cmult2_axis_dout_tvalid,
    output logic                       o_s_cmult2_axis_a_tvalid,
    output logic                       o_s_cmult2_axis_b_tvalid,
    output logic [NB_CMULT2_A - 1 : 0] o_s_cmult2_a_sample,
    output logic [NB_CMULT2_B - 1 : 0] o_s_cmult2_b_sample,

    // RAM
    input  logic [RAM_DATA_WIDTH     - 1 : 0] i_ram_col_data_out [NP],
    output logic [RAM_DATA_WIDTH     - 1 : 0] o_ram_data_in_reg [NP],
    output logic                              o_ram_write_en,
    output logic                              o_ram_porta_en,
    output logic                              o_ram_portb_col_en,
    output logic                              o_ram_portb_row_en,
    output logic [RAM_COL_ADDR_WIDTH - 1 : 0] o_ram_read_col_addr,
    output logic [RAM_ROW_ADDR_WIDTH - 1 : 0] o_ram_read_row_addr,
    output logic [RAM_COL_ADDR_WIDTH - 1 : 0] o_ram_write_addr,

    // control
    output logic o_scd_done
);
    
typedef enum {S_IDLE,           
              S_GET_SAMPLES,
              S_WRITE_RAM,      
              S_LOAD_BUFF,      
              S_DOWN_SHIFT,
              S_WAIT_CMULT1_VALID,
              S_WRITE_RAM_DS,       
              S_CONF_FFT,     
              S_LOAD_CDEMOD,
              S_LOAD_CDEMOD_SYNC,
              S_LOAD_CDEMOD_SYNC_EX,
              S_ALPHA_INDX_CALC,
              S_LOAD_CDEMOD_CONJ,
              S_CDEMOD_PROD,
              S_WAIT_CMULT2_VALID,
              S_CONF_LOAD_FFT,
              S_LOAD_FFT,
              S_WAIT_READY,
              S_WAIT_NEXT_BLOCK,
              S_DONE} state_type;

state_type state_reg, state_next;

// axi-stream fft core config size
localparam AXI_CONFIG_DATA_WIDTH = NB_FFT2_CONFIG; 
localparam AXI_CONFIG_NFFT_WIDTH = 5; 
localparam AXI_CONFIG_FWIN_WIDTH = 1; 
localparam AXI_CONFIG_SCAL_WIDTH = 8; 

// ram array size
localparam RAM_ROWS = NP; 
localparam RAM_COLS = P_MAX;

// cmult output counter
localparam NB_CMULT_CNT_1 = $clog2(NP);
localparam NB_CMULT_CNT_2 = $clog2(P_MAX);

// first stage control sig
logic w_scd_done, r_scd_done;

// fft1 
logic w_fft1_m_axis_data_tready, r_fft1_m_axis_data_tready;

// fft2 
logic [AXI_CONFIG_NFFT_WIDTH - 1 : 0] NFFT; //! fft lenght
logic [AXI_CONFIG_FWIN_WIDTH - 1 : 0] FWD_INV; //! fwd/inv fft
logic [AXI_CONFIG_SCAL_WIDTH - 1 : 0] SCALE_SCH; //! scaling schedule of internal fft stages
logic [AXI_CONFIG_DATA_WIDTH - 1 : 0] w_fft2_s_axis_config_tdata; //! initial fft core config: nfft, fwd/inv and scale_sch
logic                                 w_fft2_s_axis_config_tvalid, r_fft2_s_axis_config_tvalid;

logic [NB_CMULT2_O - 1 : 0] r_fft2_input_buffer [RAM_COLS]; //! buffer to store fft2 input samples
logic [NB_CMULT2_O - 1 : 0] r_fft2_data_in_reg, r_fft2_data_in_next; //! fft2 input data
logic                       w_fft2_s_axis_data_tvalid, r_fft2_s_axis_data_tvalid;
logic                       w_fft2_s_axis_data_tlast, r_fft2_s_axis_data_tlast;
logic                       w_fft2_data_in_ld;

// phase correction exp
logic r_exp_rom_addr_inc; //! exp rom read addr sigs

// cmult1
logic                       w_s_cmult1_axis_a_tvalid, r_s_cmult1_axis_a_tvalid; //! cmult1 data a tvalid 
logic                       w_s_cmult1_axis_b_tvalid, r_s_cmult1_axis_b_tvalid; //! cmult1 data b tvalid
logic [NB_CMULT1_A - 1 : 0] r_cmult1_a_sample_reg, r_cmult1_a_sample_next; //! cmult1 a input sample
logic [NB_CMULT1_B - 1 : 0] r_cmult1_b_sample_reg, r_cmult1_b_sample_next; //! cmult1 b input sample
logic [NB_CMULT_CNT_1  : 0] r_cmult1_dout_count_reg, r_cmult1_dout_count_next; //! cmult1 output counter (emulate tlast) 
logic                       r_cmult1_dout_count_inc, r_cmult1_dout_count_out, r_cmult1_dout_count_clr; //! cmult1 output counter sigs
logic                       w_cmult1_input_en; //! cmult1 input enable
logic                       w_cmult1_a_sample_ld, w_cmult1_b_sample_ld; //! cmult1 input buffer load en

// cmult2
logic                       w_s_cmult2_axis_a_tvalid, r_s_cmult2_axis_a_tvalid; //! cmult2 data a tvalid
logic                       w_s_cmult2_axis_b_tvalid, r_s_cmult2_axis_b_tvalid; //! cmult2 data b tvalid
logic [NB_CMULT2_A - 1 : 0] r_cmult2_a_sample_reg, r_cmult2_a_sample_next; //! cmult2 a input sample
logic [NB_CMULT2_B - 1 : 0] r_cmult2_b_sample_reg, r_cmult2_b_sample_next; //! cmult2 b input sample
logic [NB_CMULT_CNT_2  : 0] r_cmult2_dout_count_reg, r_cmult2_dout_count_next; //! cmult2 output counter (emulate tlast)
logic                       r_cmult2_dout_count_inc, r_cmult2_dout_count_out, r_cmult2_dout_count_clr; //! cmult2 output counter sigs
logic                       w_cmult2_input_en; //! cmult2 input enable
logic                       w_cmult2_a_sample_ld, w_cmult2_b_sample_ld; //! cmult2 input buffer load en

// ram
logic                          w_ram_write_en, r_ram_write_en;
logic [RAM_DATA_WIDTH - 1 : 0] r_ram_data_in_reg [RAM_ROWS]; //! RAM Input Data Buffer (Shift_Reg)
logic                          w_ram_porta_en, r_ram_porta_en; //! RAM_Port_A Enable Signal (WRITE op) 
logic                          w_ram_portb_col_en, r_ram_portb_col_en; //! RAM_Port_B Enable signal (READ COL op)
logic                          w_ram_portb_row_en, r_ram_portb_row_en; //! RAM_Port_B Enable signal (READ ROW op)

logic [RAM_COL_ADDR_WIDTH     : 0] r_ram_read_col_addr_reg, r_ram_read_col_addr_next; //! RAM Read COL Address Signal
logic                              r_ram_read_col_addr_inc, r_ram_read_col_addr_out, r_ram_read_col_addr_clr;
logic                              r_ram_read_col_addr_out2; // ADDED
logic [RAM_ROW_ADDR_WIDTH - 1 : 0] r_ram_read_row_addr_reg, r_ram_read_row_addr_next; //! RAM Read ROW Address Signal
logic                              r_ram_read_row_addr_inc, r_ram_read_row_addr_out, r_ram_read_row_addr_clr, r_ram_read_row_addr_ld;
logic [RAM_ROW_ADDR_WIDTH     : 0] r_ram_read_row_addr_cdemod_reg, r_ram_read_row_addr_cdemod_next; //! RAM Reference Read Address (CDEMOD) (CDEMOD_REG LE SAQUE EL -1 PORQ NECESITO CONTAR HASTA NP = 32)
logic                              r_ram_read_row_addr_cdemod_inc, r_ram_read_row_addr_cdemod_out, r_ram_read_row_addr_cdemod_clr;
logic [RAM_COL_ADDR_WIDTH - 1 : 0] r_ram_write_addr_reg, r_ram_write_addr_next; //! RAM Write Address Signal
logic                              r_ram_write_addr_inc, r_ram_write_addr_out, r_ram_write_addr_clr;

// downshift product
logic [RAM_DATA_WIDTH     - 1 : 0] r_pre_downshif [RAM_ROWS]; //! buffer for freq downshift   
logic [RAM_ROW_ADDR_WIDTH     : 0] r_ds_index_reg,r_ds_index_next; //! cmult1 input sample idx (row width) 
logic                              r_ds_index_inc, r_ds_index_out, r_ds_index_clr;
logic                              w_pre_downshift_buffer_load_en;

// complex demodulate product
// divide complex_demod conj in two buffer so i can operate with the sign
logic        [RAM_DATA_WIDTH - 1 : 0] r_xdem_prod [RAM_COLS]; //! buffer to store complex demodulate at f1
logic signed [NB_DATA        - 1 : 0] r_xdem_prod_conj_re [RAM_COLS]; //! buffer to store complex demodulate (re) at f2
logic signed [NB_DATA        - 1 : 0] r_xdem_prod_conj_im [RAM_COLS]; //! buffer to store complex demodulate (im) at f2
logic                                 w_xdem_buffer_load_en;
logic                                 w_xdem_conj_buffer_load_en;

logic [RAM_COL_ADDR_WIDTH : 0] r_demprod_index_reg, r_demprod_index_next; //! CMULT2 Input Sample Index (COL Width)
logic                          r_demprod_index_inc, r_demprod_index_out, r_demprod_index_clr;

logic signed [RAM_ROW_ADDR_WIDTH - 1 : 0] r_cemod_index_reg,r_cemod_index_next; // last update
logic                                     w_cemod_index_en;
logic signed [RAM_ROW_ADDR_WIDTH     : 0] r_alpha_index_reg,r_alpha_index_next; // last update
logic                                     w_alpha_index_en;
logic                                     r_alpha_index_check_flag;

// added
logic [RAM_COL_ADDR_WIDTH : 0] r_fft2_load_index_reg, r_fft2_load_index_next; //! CMULT2 Input Sample Index (COL Width)
logic                          r_fft2_load_index_inc, r_fft2_load_index_out, r_fft2_load_index_clr;

logic [10:0] r_demprod_index_lim; // overkill, 8 bits va OK

assign r_ram_read_col_addr_next = (r_ram_read_col_addr_clr) ? '0 : (r_ram_read_col_addr_inc) ? r_ram_read_col_addr_reg + 1'b1 : r_ram_read_col_addr_reg;
assign r_ram_read_col_addr_out  = (r_ram_read_col_addr_reg == i_p_frames - 1) ? '1 : '0; 
assign r_ram_read_col_addr_out2 = (r_ram_read_col_addr_reg == i_p_frames) ? '1 : '0; // addedd !!

assign r_ram_write_addr_next = (r_ram_write_addr_clr) ? '0 : (r_ram_write_addr_inc) ? r_ram_write_addr_reg + 1'b1 : r_ram_write_addr_reg;
assign r_ram_write_addr_out  = (r_ram_write_addr_reg == (i_p_frames - 1)) ? '1 : '0; 

assign r_ram_read_row_addr_next = (r_ram_read_row_addr_clr) ? '0 : (r_ram_read_row_addr_inc) ? r_ram_read_row_addr_reg + 1'b1 : (r_ram_read_row_addr_ld) ? r_ram_read_row_addr_cdemod_reg : r_ram_read_row_addr_reg;
assign r_ram_read_row_addr_out = (r_ram_read_row_addr_reg == NP - 1) ? '1 : '0;

assign r_ram_read_row_addr_cdemod_next = (r_ram_read_row_addr_cdemod_clr) ? '0 : (r_ram_read_row_addr_cdemod_inc) ? r_ram_read_row_addr_cdemod_reg + 1'b1 : r_ram_read_row_addr_cdemod_reg;
assign r_ram_read_row_addr_cdemod_out  = (r_ram_read_row_addr_cdemod_reg == NP) ? '1 : '0; // CAMBIO (le saque el -1) PORQ NO SE HACIA EL ULTIMO PRODUCTO !!

assign r_ds_index_next = (r_ds_index_clr) ? '0 : (r_ds_index_inc) ? r_ds_index_reg + 1'b1 : r_ds_index_reg;
assign r_ds_index_out  = (r_ds_index_reg == NP) ? '1 : '0; // extra bit to counter to have a correct tvalid period
assign r_cmult1_a_sample_next = (w_cmult1_a_sample_ld) ? r_pre_downshif[r_ds_index_reg] : r_cmult1_a_sample_reg;

assign r_cmult1_dout_count_next = (r_cmult1_dout_count_clr) ? '0 : (r_cmult1_dout_count_inc) ? r_cmult1_dout_count_reg + 1'b1 : r_cmult1_dout_count_reg;
assign r_cmult1_dout_count_out  = (r_cmult1_dout_count_reg == NP - 1) ? '1 : '0; 

// added
assign r_cmult2_a_sample_next   = (w_cmult2_a_sample_ld) ? r_xdem_prod[r_demprod_index_reg] : r_cmult2_a_sample_reg;
assign r_cmult2_b_sample_next   = (w_cmult2_b_sample_ld) ? {-r_xdem_prod_conj_im[r_demprod_index_reg],r_xdem_prod_conj_re[r_demprod_index_reg]} : r_cmult2_b_sample_reg;
assign r_cmult2_dout_count_next = (r_cmult2_dout_count_clr) ? '0 : (r_cmult2_dout_count_inc) ? r_cmult2_dout_count_reg + 1'b1 : r_cmult2_dout_count_reg;
assign r_cmult2_dout_count_out  = (r_cmult2_dout_count_reg == i_p_frames - 1) ? '1 : '0; 

assign r_cemod_index_next = (w_cemod_index_en) ? r_ram_read_row_addr_cdemod_reg : r_cemod_index_reg;
assign r_alpha_index_next = (w_alpha_index_en) ? (r_cemod_index_reg - r_ram_read_row_addr_reg) : r_alpha_index_reg;
assign r_alpha_index_check_flag = (r_alpha_index_reg[RAM_ROW_ADDR_WIDTH] == 1'b1 || r_alpha_index_reg == '0) ? '1 : '0;

assign r_demprod_index_next = (r_demprod_index_clr) ? '0 : (r_demprod_index_inc) ? r_demprod_index_reg + 1'b1 : r_demprod_index_reg;

assign r_demprod_index_lim = (state_reg == S_CDEMOD_PROD) ? i_p_frames : (i_p_frames-1);
assign r_demprod_index_out = (r_demprod_index_reg == r_demprod_index_lim) ? '1 : '0; // extra bit to counter to have a correct tvalid period

// added 
assign r_fft2_load_index_next = (r_fft2_load_index_clr) ? '0 : (r_fft2_load_index_inc) ? r_fft2_load_index_reg + 1'b1 : r_fft2_load_index_reg;
assign r_fft2_load_index_out  = (r_fft2_load_index_reg == i_p_frames - 1) ? '1 : '0; 
assign r_fft2_data_in_next    = (w_fft2_data_in_ld) ? r_fft2_input_buffer[i_p_frames - 1'b1 - r_demprod_index_reg] : r_fft2_data_in_reg;

//==============================================================================
// FFT RUNTIME CONFIG_DATA 
//==============================================================================
always_comb begin : p_point_fft_size // added for p point fft size
    case (i_p_frames) 
        8'b10000000 : NFFT = 5'b00111; // 128
        8'b01000000 : NFFT = 5'b00110; // 64
        8'b00100000 : NFFT = 5'b00101; // 32
        8'b00010000 : NFFT = 5'b00100; // 16
        8'b00001000 : NFFT = 5'b00011; // 8
        default: NFFT = 5'b00111; // 128
    endcase
end

always_comb begin : scale_sch_fft_size
    case (i_p_frames)
        8'b10000000 : SCALE_SCH = 8'b01011011; // 128
        8'b01000000 : SCALE_SCH = 8'b00011011; // 64
        8'b00100000 : SCALE_SCH = 8'b00001011; // 32
        8'b00010000 : SCALE_SCH = 8'b00000111; // 16
        8'b00001000 : SCALE_SCH = 8'b00000011; // 8
        default: SCALE_SCH = 8'b01011011;
    endcase
end

// fft runtime config
assign FWD_INV = 1'b1; // select forward fft mode 
assign w_fft2_s_axis_config_tdata = {SCALE_SCH,FWD_INV,{3{1'b0}},NFFT}; // load config
//==============================================================================

//==============================================================================
// PHASE COMPENSATOR EXPONENTIAL VALUE CALCULATION
// added phase correction exponential calculation and control
//==============================================================================
logic [1  : 0] i_mod4; 
logic [1  : 0] k_mod4;
logic [1  : 0] exp_phase;
logic [15 : 0] w_exp_data;

logic w_reset_imod4_count;

assign r_cmult1_b_sample_next = (w_cmult1_b_sample_ld) ? w_exp_data : r_cmult1_b_sample_reg;

always_ff @(posedge clock) begin : ds_exp_control
    if (i_reset) begin
        i_mod4 <= '0;
        k_mod4 <= '0;
    end
    else if (i_enable) begin
        
        // increase i_mod each clock
        if (r_exp_rom_addr_inc) i_mod4 <= i_mod4 + 1'b1;
        else if (w_reset_imod4_count) i_mod4 <= '0;
        else i_mod4 <= i_mod4;
        
        // increase k_mod once each row is completed
        if (r_ds_index_out) k_mod4 <= k_mod4 + 1'b1;
        else k_mod4 <= k_mod4;
    end
end

always_comb begin : exp_phase_calc
    case (k_mod4)
        2'b00 : exp_phase = '0; 
        2'b01 : exp_phase = i_mod4;
        2'b10 : exp_phase = {i_mod4[0],1'b0};
        2'b11 : exp_phase = {(i_mod4[1]^i_mod4[0]),i_mod4[0]};
        default: exp_phase = '0; 
    endcase
end

always_comb begin : exp_value_calc
    case (exp_phase)
        2'b00 : w_exp_data = 16'b0000000001111111; // 1 + 0j  
        2'b01 : w_exp_data = 16'b1000000000000000; // 0 - 1j
        2'b10 : w_exp_data = 16'b0000000010000000; // -1 + 0j
        2'b11 : w_exp_data = 16'b0111111100000000; // 0 + 1j
        default : w_exp_data = 16'b0000000001111111; // 1 + 0j 
    endcase
end
//==============================================================================

//==============================================================================
// CMULT1 OUTPUT RESOLUTION LOGIC
// logica agregada para no perder bits a la salida del CMULT1
// entro con 16,13 y 8,7 entonces el output completo es 25,20
// al truncar a 16 con el cmult, toma los 16 bits MSB y entonces pierdo info fraccionaria
// para solucionar, tomo la salida full res y lo trunco yo afuera
//==============================================================================
localparam NB_CMULT1_FULLR  = NB_CMULT1_A / 2 + NB_CMULT1_B / 2 + 1;
localparam NBF_CMULT1_FULLR = NBF_CMULT1_A + 7; // 7 is fixed for the exponential
localparam NB_CMULT1_TRUNC  = NB_DATA;
localparam NBF_CMULT1_TRUNC = NBF_DATA;
localparam NBI_CMULT1_TRUNC = (NB_CMULT1_FULLR - NBF_CMULT1_FULLR) - ((NB_CMULT1_TRUNC - NBF_CMULT1_TRUNC) - 1);

logic signed [NB_CMULT1_FULLR - 1 : 0] i_m_cmult1_axis_dout_tdata_re, i_m_cmult1_axis_dout_tdata_im;
logic signed [NB_CMULT1_TRUNC - 1 : 0] truncated_cmult1_dout_re, truncated_cmult1_dout_im;
assign i_m_cmult1_axis_dout_tdata_re = i_m_cmult1_axis_dout_tdata[24 : 0];
assign i_m_cmult1_axis_dout_tdata_im = i_m_cmult1_axis_dout_tdata[56 : 32];

assign truncated_cmult1_dout_re = (~|i_m_cmult1_axis_dout_tdata_re[NB_CMULT1_FULLR - 1 -: NBI_CMULT1_TRUNC] || &i_m_cmult1_axis_dout_tdata_re[NB_CMULT1_FULLR - 1 -: NBI_CMULT1_TRUNC]) ?  i_m_cmult1_axis_dout_tdata_re[NB_CMULT1_FULLR - NBI_CMULT1_TRUNC -: NB_CMULT1_TRUNC] : (i_m_cmult1_axis_dout_tdata_re[NB_CMULT1_FULLR - 1]) ? {1'b1,{NB_CMULT1_TRUNC - 1{1'b0}}} : {1'b0,{NB_CMULT1_TRUNC - 1{1'b1}}};
assign truncated_cmult1_dout_im = (~|i_m_cmult1_axis_dout_tdata_im[NB_CMULT1_FULLR - 1 -: NBI_CMULT1_TRUNC] || &i_m_cmult1_axis_dout_tdata_im[NB_CMULT1_FULLR - 1 -: NBI_CMULT1_TRUNC]) ?  i_m_cmult1_axis_dout_tdata_im[NB_CMULT1_FULLR - NBI_CMULT1_TRUNC -: NB_CMULT1_TRUNC] : (i_m_cmult1_axis_dout_tdata_im[NB_CMULT1_FULLR - 1]) ? {1'b1,{NB_CMULT1_TRUNC - 1{1'b0}}} : {1'b0,{NB_CMULT1_TRUNC - 1{1'b1}}};
//==============================================================================

//==============================================================================
// RAM DATA_IN INPUT BUFFER
// takes fft1_output data, phase corrected data or defaults to 0
//==============================================================================
always_ff @(posedge clock) begin : input_samples_shift_reg
    if (i_reset) begin // added reset
        for (int ptr_sr = 0 ; ptr_sr < NP ; ptr_sr = ptr_sr + 1) begin
            r_ram_data_in_reg[ptr_sr] <= '0; // shift-reg   
        end
    end
    else if (i_enable) begin
        for (int ptr_sr = 0 ; ptr_sr < (NP - 1) ; ptr_sr = ptr_sr + 1) begin
            r_ram_data_in_reg[ptr_sr] <= r_ram_data_in_reg[ptr_sr + 1]; // shift-reg   
        end
        if (i_fft1_m_axis_data_tvalid) r_ram_data_in_reg[NP-1] <= i_fft1_m_axis_data_tdata; // s_get_samples
        else if (i_m_cmult1_axis_dout_tvalid && state_reg == S_DOWN_SHIFT) r_ram_data_in_reg[NP-1] <= {truncated_cmult1_dout_im,truncated_cmult1_dout_re}; // i_m_cmult1_axis_dout_tdata; // s_
        else r_ram_data_in_reg[NP-1] <= '0; // default to 0 ???
    end
    else begin
        for (int ptr_sr = 0 ; ptr_sr < NP ; ptr_sr = ptr_sr + 1) begin
            r_ram_data_in_reg[ptr_sr] <= r_ram_data_in_reg[ptr_sr]; // shift-reg   
        end
    end
end
//==============================================================================

//==============================================================================
// PRE PHASE CORRECTION BUFFER
// buffer to load data before phase correction, in order to feed cmult1
//==============================================================================
always_ff @(posedge clock) begin : pre_downshift_buffer_load
    if (i_reset) begin
       for (int ptr_buff = 0 ; ptr_buff < NP ; ptr_buff = ptr_buff + 1) begin
            r_pre_downshif[ptr_buff] <= '0; 
       end  
    end
    else if (w_pre_downshift_buffer_load_en) begin
        for (int ptr_buff = 0 ; ptr_buff < NP ; ptr_buff = ptr_buff + 1) begin
            r_pre_downshif[ptr_buff] <= i_ram_col_data_out[ptr_buff]; // load data from ram re 
        end  
    end
    else begin
        for (int ptr_buff = 0 ; ptr_buff < NP ; ptr_buff = ptr_buff + 1) begin
            r_pre_downshif[ptr_buff] <= r_pre_downshif[ptr_buff]; 
        end    
    end
end
//==============================================================================

//==============================================================================
// COMPLEX DEMODULATE PRODUCT BUFFER
// load complex demodulate buffer before product
// load conjugate complex demodulate buffer before product
//==============================================================================
always_ff @(posedge clock) begin : load_cdemod_buffer
    if (i_reset) begin
        for (int ptr_xdem = 0 ; ptr_xdem < RAM_COLS ; ptr_xdem = ptr_xdem + 1) begin
            r_xdem_prod[ptr_xdem] <= '0; 
        end
    end
    else if (w_xdem_buffer_load_en) r_xdem_prod[r_ram_read_col_addr_reg - 1] <= i_ram_col_data_out[r_ram_read_row_addr_cdemod_reg]; // i_ram_col_data_out[r_ram_read_row_addr_reg];   
    else r_xdem_prod <= r_xdem_prod;
end

always_ff @(posedge clock) begin : load_cdemod_conj_buffer
    if (i_reset) begin
        for (int ptr_xdem = 0 ; ptr_xdem < RAM_COLS ; ptr_xdem = ptr_xdem + 1) begin
            r_xdem_prod_conj_re[ptr_xdem] <= '0; 
            r_xdem_prod_conj_im[ptr_xdem] <= '0;
        end
    end
    else if (w_xdem_conj_buffer_load_en) begin
        r_xdem_prod_conj_re[r_ram_read_col_addr_reg - 1] <= i_ram_col_data_out[r_ram_read_row_addr_reg][NB_DATA - 1 : 0];
        r_xdem_prod_conj_im[r_ram_read_col_addr_reg - 1] <= i_ram_col_data_out[r_ram_read_row_addr_reg][2*NB_DATA - 1 : NB_DATA];
    end
    else begin
        r_xdem_prod_conj_re <= r_xdem_prod_conj_re;
        r_xdem_prod_conj_im <= r_xdem_prod_conj_im; 
    end
end
//==============================================================================

//==============================================================================
// CMULT2 OUTPUT RESOLUTION LOGIC
// logica agregada para no perder bits a la salida del CMULT2
// como el cmult trunca tomando los MSB, de nuevo tomo yo los que quiero
// y agrego un cero final, porq quiero tener mas bits frac de los originales
//==============================================================================
localparam NB_CMULT2_FULLR = 33;
localparam NB_CMULT2_TRUNC = 32;
localparam NBI_CMULT2_TRUNC = (NB_CMULT2_FULLR - 30) - ((NB_CMULT2_TRUNC - 31) - 1);

logic signed [32 : 0] i_m_cmult2_axis_dout_tdata_re, i_m_cmult2_axis_dout_tdata_im;
logic signed [31 : 0] truncated_cmult2_dout_re, truncated_cmult2_dout_im;
assign i_m_cmult2_axis_dout_tdata_re = i_m_cmult2_axis_dout_tdata[32 : 0];
assign i_m_cmult2_axis_dout_tdata_im = i_m_cmult2_axis_dout_tdata[72 : 40];

assign truncated_cmult2_dout_re = {i_m_cmult2_axis_dout_tdata_re[30:0],1'b0};
assign truncated_cmult2_dout_im = {i_m_cmult2_axis_dout_tdata_im[30:0],1'b0};
//==============================================================================

//==============================================================================
// CMULT2 OUTPUT MANAGEMENT
// new version, get output samples from complex multiplier 2
//==============================================================================
always_ff @(posedge clock) begin : get_cmult2_samples
    if (i_reset) begin
        for (int ptr_buff = 0 ; ptr_buff < (P_MAX) ; ptr_buff = ptr_buff + 1) begin
            r_fft2_input_buffer[ptr_buff] <= '0; // shift-reg   
        end 
    end
    else if (i_m_cmult2_axis_dout_tvalid && state_reg == S_CDEMOD_PROD) begin
        for (int ptr_buff = 0 ; ptr_buff < (P_MAX - 1) ; ptr_buff = ptr_buff + 1) begin
            r_fft2_input_buffer[ptr_buff + 1] <= r_fft2_input_buffer[ptr_buff]; // shift-reg   
        end 
        r_fft2_input_buffer[0] <= {truncated_cmult2_dout_im,truncated_cmult2_dout_re};
    end
    else begin
        for (int ptr_buff = 0 ; ptr_buff < (P_MAX) ; ptr_buff = ptr_buff + 1) begin
            r_fft2_input_buffer[ptr_buff] <= r_fft2_input_buffer[ptr_buff]; // shift-reg   
        end 
    end
end
//==============================================================================

// state and signal registers
always_ff @(posedge clock) begin : state_and_reg_update
    if (i_reset) begin
        state_reg                      <= S_IDLE;
        r_cmult1_a_sample_reg          <= '0;
        r_cmult1_b_sample_reg          <= '0;
        r_cmult2_a_sample_reg          <= '0;
        r_cmult2_b_sample_reg          <= '0;
        r_fft2_data_in_reg             <= '0;
        r_cmult1_dout_count_reg        <= '0;
        r_cmult2_dout_count_reg        <= '0;
        r_ram_read_col_addr_reg        <= '0;
        r_ram_read_row_addr_reg        <= '0;
        r_ram_read_row_addr_cdemod_reg <= '0;
        r_ram_write_addr_reg           <= '0;
        r_ds_index_reg                 <= '0;
        r_demprod_index_reg            <= '0;
        r_cemod_index_reg              <= '0;
        r_alpha_index_reg              <= '0;
    end
    else if (i_enable) begin
        state_reg                      <= state_next;
        r_cmult1_a_sample_reg          <= r_cmult1_a_sample_next;
        r_cmult1_b_sample_reg          <= r_cmult1_b_sample_next;
        r_cmult2_a_sample_reg          <= r_cmult2_a_sample_next;
        r_cmult2_b_sample_reg          <= r_cmult2_b_sample_next;
        r_fft2_data_in_reg             <= r_fft2_data_in_next;
        r_cmult1_dout_count_reg        <= r_cmult1_dout_count_next;
        r_cmult2_dout_count_reg        <= r_cmult2_dout_count_next;
        r_ram_read_col_addr_reg        <= r_ram_read_col_addr_next;
        r_ram_read_row_addr_reg        <= r_ram_read_row_addr_next;
        r_ram_read_row_addr_cdemod_reg <= r_ram_read_row_addr_cdemod_next;
        r_ram_write_addr_reg           <= r_ram_write_addr_next;
        r_ds_index_reg                 <= r_ds_index_next;
        r_demprod_index_reg            <= r_demprod_index_next;
        r_cemod_index_reg              <= r_cemod_index_next;
        r_alpha_index_reg              <= r_alpha_index_next;
    end
    else begin
        state_reg                      <= state_reg;            
        r_cmult1_dout_count_reg        <= r_cmult1_dout_count_reg;        
        r_cmult2_dout_count_reg        <= r_cmult2_dout_count_reg;  
        r_cmult1_a_sample_reg          <= r_cmult1_a_sample_reg;
        r_cmult1_b_sample_reg          <= r_cmult1_b_sample_reg;
        r_cmult2_a_sample_reg          <= r_cmult2_a_sample_reg;
        r_cmult2_b_sample_reg          <= r_cmult2_b_sample_reg; 
        r_fft2_data_in_reg             <= r_fft2_data_in_reg;     
        r_ram_read_col_addr_reg        <= r_ram_read_col_addr_reg;        
        r_ram_read_row_addr_reg        <= r_ram_read_row_addr_reg;        
        r_ram_read_row_addr_cdemod_reg <= r_ram_read_row_addr_cdemod_reg; 
        r_ram_write_addr_reg           <= r_ram_write_addr_reg;           
        r_ds_index_reg                 <= r_ds_index_reg;                 
        r_demprod_index_reg            <= r_demprod_index_reg;            
        r_cemod_index_reg              <= r_cemod_index_reg;              
        r_alpha_index_reg              <= r_alpha_index_reg;              
    end
end

// fsm output and next state logic
always_comb begin : fsmd_next_state_output_logic

    // set sigs to intial values 
    state_next = S_IDLE;
    
    w_reset_imod4_count = '0; // added
    
    w_pre_downshift_buffer_load_en = '0;
    w_scd_done                     = '0;
  
    w_cmult1_input_en        = '0;
    w_s_cmult1_axis_a_tvalid = '0; 
    w_cmult1_a_sample_ld     = '0;
    w_s_cmult1_axis_b_tvalid = '0;
    w_cmult1_b_sample_ld     = '0; 
    
    w_cmult2_input_en        = '0;
    w_s_cmult2_axis_a_tvalid = '0;
    w_cmult2_a_sample_ld     = '0;
    w_s_cmult2_axis_b_tvalid = '0;
    w_cmult2_b_sample_ld     = '0;
    
    w_fft1_m_axis_data_tready = '0;

    w_fft2_s_axis_config_tvalid = '0;
    w_fft2_s_axis_data_tvalid   = '0;
    w_fft2_s_axis_data_tlast    = '0;

    w_ram_porta_en     = '0;
    w_ram_portb_col_en = '0;
    w_ram_write_en     = '0;      
    w_ram_portb_row_en = '0;      

    w_fft2_data_in_ld   = '0;
    r_demprod_index_clr = '0;
    r_demprod_index_inc = '0;
            
    r_fft2_load_index_clr = '0;
    r_fft2_load_index_inc = '0;

    w_cemod_index_en = '0;
    w_alpha_index_en = '0;

    r_cmult1_dout_count_clr = '0;
    r_cmult1_dout_count_inc = '0;

    r_cmult2_dout_count_clr = '0;
    r_cmult2_dout_count_inc = '0;

    r_exp_rom_addr_inc = '0;

    r_ds_index_clr = '0;
    r_ds_index_inc = '0;

    r_ram_read_row_addr_cdemod_clr = '0;
    r_ram_read_row_addr_cdemod_inc = '0;

    r_ram_read_row_addr_ld  = '0;
    r_ram_read_row_addr_clr = '0;
    r_ram_read_row_addr_inc = '0;

    r_ram_write_addr_clr = '0;
    r_ram_write_addr_inc = '0;

    r_ram_read_col_addr_clr = '0;
    r_ram_read_col_addr_inc = '0;
            
    w_xdem_buffer_load_en       = '0;
    w_xdem_conj_buffer_load_en  = '0;

    case (state_reg)
        S_IDLE : begin
            // set sigs to intial values
            w_cmult1_input_en        = '0;
            w_s_cmult1_axis_a_tvalid = '0; 
            w_cmult1_a_sample_ld     = '0;
            w_s_cmult1_axis_b_tvalid = '0;
            w_cmult1_b_sample_ld     = '0; 
    
            w_cmult2_input_en        = '0;
            w_s_cmult2_axis_a_tvalid = '0;
            w_cmult2_a_sample_ld     = '0;
            w_s_cmult2_axis_b_tvalid = '0;
            w_cmult2_b_sample_ld     = '0;

            w_fft2_s_axis_config_tvalid = '0;
            w_fft2_s_axis_data_tvalid   = '0;
            w_fft2_s_axis_data_tlast    = '0;

            w_ram_write_en     = '0;      
            w_ram_portb_row_en = '0;      

            w_fft2_data_in_ld   = '0;
            r_demprod_index_clr = '1;
            r_demprod_index_inc = '0;
            
            r_fft2_load_index_clr = '1;
            r_fft2_load_index_inc = '0;

            w_cemod_index_en = '0;
            w_alpha_index_en = '0;

            r_cmult1_dout_count_clr = '1;
            r_cmult1_dout_count_inc = '0;

            r_cmult2_dout_count_clr = '1;
            r_cmult2_dout_count_inc = '0;

            r_exp_rom_addr_inc = '0;

            r_ds_index_clr = '1;
            r_ds_index_inc = '0;

            r_ram_read_row_addr_cdemod_clr = '1;
            r_ram_read_row_addr_cdemod_inc = '0;

            r_ram_read_row_addr_ld  = '0;
            r_ram_read_row_addr_clr = '1;
            r_ram_read_row_addr_inc = '0;

            r_ram_write_addr_clr = '1;
            r_ram_write_addr_inc = '0;

            r_ram_read_col_addr_clr = '1;
            r_ram_read_col_addr_inc = '0;
            
            w_xdem_buffer_load_en       = '0;
            w_xdem_conj_buffer_load_en  = '0;
            // -------------------------
            
            // added
            w_fft1_m_axis_data_tready = '1; 
            if (i_fft1_m_axis_data_tvalid) state_next = S_GET_SAMPLES;
            else state_next = S_IDLE;            
        end
        S_GET_SAMPLES : begin
            // clrs are 1 on start, now set to 0
            r_fft2_load_index_clr          = '0;
            r_demprod_index_clr            = '0;
            r_cmult1_dout_count_clr        = '0;
            r_cmult2_dout_count_clr        = '0;
            r_ds_index_clr                 = '0;
            r_ram_read_row_addr_cdemod_clr = '0;
            r_ram_read_row_addr_clr        = '0;
            r_ram_write_addr_clr           = '0;
            r_ram_read_col_addr_clr        = '0;
            // ---------------------------------
            
            w_cmult2_input_en         = '0;
            r_ram_write_addr_inc      = '0; // added
            w_scd_done                = '0;
            w_ram_porta_en            = '1; // enable ram port a (write col)
            w_ram_portb_col_en        = '1; // enable ram port b (read col) (early)
            w_fft1_m_axis_data_tready = '1; 
            if (i_fft1_m_axis_data_tlast) begin // if tlast then write enable
                w_ram_write_en            = '1; 
                w_fft1_m_axis_data_tready = '0; // disable tready
                state_next                = S_WRITE_RAM; // next state
            end
            else begin
                w_ram_write_en            = '0; 
                state_next                = S_GET_SAMPLES;
            end
        end 
        S_WRITE_RAM : begin
            w_cmult2_input_en    = '0;
            w_ram_portb_col_en   = '1; // !!
            w_ram_porta_en       = '1; // !!
            r_ram_write_addr_inc = '1; // inc write addr
            w_ram_write_en       = '0; // disable write
            if (r_ram_write_addr_out) begin // all blocks stored
                r_ram_write_addr_inc = '0; 
                r_ram_write_addr_clr = '1;
                state_next           = S_LOAD_BUFF;
            end
            else begin
                r_ram_write_addr_clr = '0;
                state_next           = S_GET_SAMPLES;
            end
        end
        S_LOAD_BUFF : begin
            w_cmult2_input_en              = '0;
            w_ram_portb_col_en             = '1;
            w_ram_porta_en                 = '1;
            r_ram_write_addr_clr           = '0;
            r_ram_write_addr_inc           = '0;
            w_pre_downshift_buffer_load_en = '1; // flag to enable buffer load
            r_ram_read_col_addr_inc        = '1; // increase read addr
            w_cmult1_input_en              = '1; // agregado para q solo meta un set de muestras
            state_next                     = S_WAIT_CMULT1_VALID;
        end
        S_WAIT_CMULT1_VALID : begin
            if (!i_m_cmult1_axis_dout_tvalid) state_next = S_DOWN_SHIFT;
            else state_next = S_WAIT_CMULT1_VALID;
        end     
        S_DOWN_SHIFT : begin
            w_cmult2_input_en              = '0;
            w_ram_portb_col_en             = '1;
            w_ram_porta_en                 = '1;
            w_pre_downshift_buffer_load_en = '0; // added
            w_cmult1_input_en              = '1; //  !!
        
            // cmult1 input management
            r_ram_read_col_addr_inc = '0;
            if (w_cmult1_input_en) begin
                w_s_cmult1_axis_a_tvalid = '1; // data a valid
                w_cmult1_a_sample_ld     = '1; // load data a en
                w_s_cmult1_axis_b_tvalid = '1; // data b valid
                w_cmult1_b_sample_ld     = '1; // load data b en
                r_ds_index_inc           = '1; // inc pre downshift buffer idx
                r_exp_rom_addr_inc       = '1; // inc exp rom addr
                if (r_ds_index_out) begin 
                    r_ds_index_inc           = '0;
                    r_ds_index_clr           = '1;
                    w_cmult1_a_sample_ld     = '0; // load data a en // added
                    w_cmult1_b_sample_ld     = '0; // load data b en // added
                    w_s_cmult1_axis_a_tvalid = '0;
                    w_s_cmult1_axis_b_tvalid = '0;
                    w_cmult1_input_en        = '0; // loaded data, now wait
                end
                else r_ds_index_clr = '0;
            end

            // cmult1 output 
            // shiftreg to store product samples, tvalid as enable signal
            if (i_m_cmult1_axis_dout_tvalid) begin
                r_cmult1_dout_count_inc = '1;
            end
            else begin
                r_cmult1_dout_count_inc = '0;
            end

            // emulated cmult1_dout_tlast with a counter to store shift_reg in ram
            // added s_write_ram_ds for better sync and correct values
            if (r_cmult1_dout_count_out) begin
                w_ram_write_en          = '1;
                r_cmult1_dout_count_inc = '0;
                r_cmult1_dout_count_clr = '1;
                state_next              = S_WRITE_RAM_DS;
            end
            else begin
                w_ram_write_en          = '0;
                r_cmult1_dout_count_clr = '0;
                state_next              = S_DOWN_SHIFT;
            end
        end
        S_WRITE_RAM_DS : begin
            w_reset_imod4_count  = '1; // 
            w_cmult2_input_en    = '0;
            w_cmult1_input_en    = '0;
            r_ds_index_clr       = '1; // added
            w_ram_portb_col_en   = '1;
            w_ram_porta_en       = '1;
            r_ram_write_addr_inc = '1;
            w_ram_write_en       = '0; // disable...
            if (r_ram_write_addr_out) begin // once all p blocks are downshifted
                w_ram_porta_en       = '0; // ram stays as is
                w_ram_portb_col_en   = '0; // no more col read
                w_ram_portb_row_en   = '1; // enable row read for fft2
                r_ram_write_addr_inc = '0;
                r_ram_write_addr_clr = '1; 
                r_exp_rom_addr_inc   = '0; // added
                state_next           = S_CONF_FFT;
            end
            else begin
                w_ram_portb_row_en   = '0;
                r_ram_write_addr_clr = '0;
                state_next           = S_LOAD_BUFF;
            end
        end
        S_CONF_FFT : begin
            w_cmult2_input_en           = '0;
            w_cmult1_input_en           = '0;
            w_ram_portb_col_en          = '1;
            r_ram_read_col_addr_clr     = '1; // !!
            r_ram_write_addr_clr        = '0; // added 
            r_ds_index_clr              = '0; // added 
            w_fft2_s_axis_data_tlast    = '0; // no data tlast 
            w_fft2_s_axis_data_tvalid   = '0; // no data tvalid
            w_fft2_s_axis_config_tvalid = '1; // set config tvalid
            if (i_fft2_s_axis_config_tready) state_next = S_LOAD_CDEMOD; // wait for config tready   
            else state_next = S_CONF_FFT;
        end
        S_LOAD_CDEMOD : begin
            w_cmult2_input_en           = '0;
            w_cmult1_input_en           = '0;
            w_ram_portb_col_en          = '1;
            r_ram_read_row_addr_ld      = '0; // added
            r_ram_read_col_addr_inc     = '1; // !!
            w_fft2_s_axis_config_tvalid = '0;
            w_fft2_s_axis_data_tvalid   = '0;
            // load complex demodulate at f1 (non-conjugate)
            w_xdem_buffer_load_en = '1; // load buffer en
            w_cemod_index_en      = '1; // !!
            
            if (r_ram_read_row_addr_cdemod_out) begin
                r_ram_read_row_addr_cdemod_clr = '1;
                state_next                     = S_DONE;
            end
            else begin
                r_ram_read_row_addr_cdemod_clr = '0;
                state_next                     = S_LOAD_CDEMOD_SYNC;
            end     
        end
        S_LOAD_CDEMOD_SYNC : begin
            w_cmult2_input_en              = '0;
            w_cmult1_input_en              = '0;
            w_ram_portb_col_en             = '1;
            w_xdem_buffer_load_en          = '1; // load buffer en
            r_ram_read_row_addr_cdemod_inc = '0;
            r_ram_read_row_addr_clr        = '0;
            r_ram_read_col_addr_inc        = '1; 
            state_next                     = S_LOAD_CDEMOD_SYNC_EX;
        end
        S_LOAD_CDEMOD_SYNC_EX : begin
            w_cmult2_input_en              = '0;
            w_cmult1_input_en              = '0;
            w_ram_portb_col_en             = '1;
            w_xdem_buffer_load_en          = '1; // load buffer en
            r_ram_read_row_addr_cdemod_inc = '0;
            r_ram_read_row_addr_clr        = '0;
            r_ram_read_col_addr_inc        = '1; 
            
            if (r_ram_read_col_addr_out2) begin
                r_ram_read_col_addr_inc = '0;
                r_ram_read_col_addr_clr = '1;
                r_ram_read_row_addr_clr = '1;
                state_next              = S_ALPHA_INDX_CALC;
            end
            else begin
                r_ram_read_col_addr_clr = '0;
                state_next              = S_LOAD_CDEMOD_SYNC_EX;
            end
        end
  
        S_ALPHA_INDX_CALC : begin
            w_cmult2_input_en       = '0;
            w_cmult1_input_en       = '0;
            w_ram_portb_col_en      = '1;
            r_ram_read_col_addr_inc = '1; // !!
            w_xdem_buffer_load_en   = '0; // added 
            w_alpha_index_en        = '1; 
            state_next              = S_LOAD_CDEMOD_CONJ;
        end
        S_LOAD_CDEMOD_CONJ : begin
            w_cmult2_input_en       = '0;
            w_cmult1_input_en       = '0;
            w_ram_portb_col_en      = '1;
            r_ram_read_row_addr_inc = '0; // added
            w_alpha_index_en        = '0; // added
        
            // if x(n) = y(n) then we can estime only half of the scd, since the pairs are symmetrical
            // calculate the alpha index, doing r_ram_read_row_addr_cdemod - r_ram_read_row_addr
            // if alpha is negative then go straight to s_wait_next_block and skip the current block 
            // if alpha is positive then stay here and do the product

            if (r_alpha_index_check_flag) begin
                r_ram_read_col_addr_clr = '1; /// !!
                state_next = S_WAIT_NEXT_BLOCK;
            end
            else begin
                w_xdem_conj_buffer_load_en = '1; // load real and imag part to conjugate
                w_cmult2_input_en          = '1; // enable cmult
                r_ram_read_col_addr_inc    = '1; // 
                if (r_ram_read_col_addr_out2) begin
                    r_ram_read_col_addr_inc = '0;
                    r_ram_read_col_addr_clr = '1;
                    state_next              = S_WAIT_CMULT2_VALID;
                end
                else begin
                    r_ram_read_col_addr_clr = '0;
                    state_next              = S_LOAD_CDEMOD_CONJ;
                end
            end
        end
        S_WAIT_CMULT2_VALID : begin
            if (!i_m_cmult2_axis_dout_tvalid) state_next = S_CDEMOD_PROD;
            else state_next = S_WAIT_CMULT2_VALID;
        end
        
        S_CDEMOD_PROD : begin
            w_ram_portb_col_en         = '1;
            w_cmult1_input_en          = '0;
            w_xdem_conj_buffer_load_en = '0; // added
            w_cmult2_input_en          = '1; // 

            // cmult2 input management
            if (w_cmult2_input_en) begin
                w_s_cmult2_axis_a_tvalid = '1;
                w_cmult2_a_sample_ld     = '1; // load freq 1 sample, non conj 
                w_s_cmult2_axis_b_tvalid = '1;
                w_cmult2_b_sample_ld     = '1; // load freq 2 sample, conj {-imag,real}
                r_demprod_index_inc      = '1;
                if (r_demprod_index_out) begin
                    r_demprod_index_inc      = '0;
                    r_demprod_index_clr      = '1;
                    w_s_cmult2_axis_a_tvalid = '0;
                    w_s_cmult2_axis_b_tvalid = '0;
                    w_cmult2_a_sample_ld     = '0; // added
                    w_cmult2_b_sample_ld     = '0; // added
                    w_cmult2_input_en        = '0; // data loaded, wait
                end
                else r_demprod_index_clr = '0;
            end

            // cmult2 output 
            // shiftreg to store product samples, tvalid as enable signal
            if (i_m_cmult2_axis_dout_tvalid) begin
                r_cmult2_dout_count_inc = '1;
            end
            else begin
                r_cmult2_dout_count_inc = '0;
            end

            if (r_cmult2_dout_count_out) begin
                r_cmult2_dout_count_inc = '0; // dudo
                r_cmult2_dout_count_clr = '1;
                state_next              = S_CONF_LOAD_FFT;
            end
            else begin
                r_cmult2_dout_count_clr = '0;
                state_next              = S_CDEMOD_PROD;
            end
        end
        S_CONF_LOAD_FFT : begin
            r_demprod_index_clr = '1; // !!
            w_cmult2_input_en   = '0;
            w_cmult1_input_en   = '0;
            w_ram_portb_col_en  = '1;
            // add an extra clock delay for better sync 
            if (i_fft2_s_axis_data_tready) state_next = S_LOAD_FFT; // once fft core tready start sending data
            else state_next = S_CONF_LOAD_FFT; // no tready wait
        end
        S_LOAD_FFT : begin
            w_cmult2_input_en         = '0;
            w_cmult1_input_en         = '0; 
            w_ram_portb_col_en        = '1;
            w_fft2_s_axis_data_tlast  = '0; // imitates behaviour of provided testbench
            w_fft2_s_axis_data_tvalid = '1; // set data tvalid   
            if (i_fft2_s_axis_data_tready) begin // only send data if tready is set
                // reuse index (same size)
                w_fft2_data_in_ld   = '1; // send data sample to fft core
                r_demprod_index_inc = '1; // increase sample index
                if (r_demprod_index_out) begin // once np samples sent
                    w_fft2_s_axis_data_tlast = '1; // set data tlast
                    r_demprod_index_clr      = '1; // reset sample index 
                    r_demprod_index_inc      = '0;
                    state_next               = S_WAIT_NEXT_BLOCK; // added for better sync
                end
                else begin
                    r_demprod_index_clr = '0;
                    state_next          = S_LOAD_FFT; // ??
                end
            end
            else begin
                w_fft2_data_in_ld   = '0;
                r_demprod_index_inc = '0;
                state_next          = S_WAIT_READY; // no tready wait   
            end
        end
        S_WAIT_READY : begin
            w_ram_portb_col_en = '1;
            w_cmult1_input_en  = '0;
            w_cmult2_input_en  = '0;
            if (i_fft2_s_axis_data_tready) state_next = S_LOAD_FFT; // tready set go back
            else state_next = S_WAIT_READY;
        end
        S_WAIT_NEXT_BLOCK : begin
            w_cmult1_input_en         = '0;
            w_cmult2_input_en         = '0;
            r_ram_read_row_addr_inc   = '1; 
            w_ram_portb_col_en        = '1;
            // once the whole data block is fed wait for one clock (better sync) 
            w_fft2_s_axis_data_tvalid = '0; // disable tvalid 
            if (r_ram_read_row_addr_out) begin // once np conj
                r_ram_read_row_addr_ld         = '1; // reset to read addr ref
                r_ram_read_col_addr_inc        = '1; //
                r_ram_read_row_addr_cdemod_inc = '1; // 
                state_next                     = S_LOAD_CDEMOD; 
            end
            else if (i_fft2_s_axis_data_tready) begin // once core is ready go again
                r_ram_read_row_addr_ld = '0;
                state_next             = S_ALPHA_INDX_CALC;
            end
            else state_next = S_WAIT_NEXT_BLOCK; // no tready keep waiting
        end
        S_DONE : begin
            w_cmult2_input_en = '0;
            w_cmult1_input_en = '0;
            w_scd_done        = '1; // tell first stage control scd is done
            state_next        = S_IDLE; // start again
        end
    endcase
end

always_ff @(posedge clock) begin : registered_output
    r_fft2_s_axis_config_tvalid = w_fft2_s_axis_config_tvalid;
    r_fft2_s_axis_data_tvalid   = w_fft2_s_axis_data_tvalid;
    r_fft2_s_axis_data_tlast    = w_fft2_s_axis_data_tlast;
    r_fft1_m_axis_data_tready   = w_fft1_m_axis_data_tready;

    r_s_cmult1_axis_a_tvalid = w_s_cmult1_axis_a_tvalid;
    r_s_cmult1_axis_b_tvalid = w_s_cmult1_axis_b_tvalid;
    r_s_cmult2_axis_a_tvalid = w_s_cmult2_axis_a_tvalid;
    r_s_cmult2_axis_b_tvalid = w_s_cmult2_axis_b_tvalid;

    r_ram_write_en     = w_ram_write_en;
    r_ram_porta_en     = w_ram_porta_en;
    r_ram_portb_col_en = w_ram_portb_col_en;
    r_ram_portb_row_en = w_ram_portb_row_en;

    r_scd_done = w_scd_done;
end

// fft
assign o_fft2_s_axis_config_tvalid = r_fft2_s_axis_config_tvalid;
assign o_fft2_s_axis_config_tdata  = w_fft2_s_axis_config_tdata;

assign o_fft2_s_axis_data_tvalid = r_fft2_s_axis_data_tvalid;
assign o_fft2_s_axis_data_tlast  = r_fft2_s_axis_data_tlast;
assign o_fft2_s_axis_data_tdata  = r_fft2_data_in_reg;

assign o_fft1_m_axis_data_tready = r_fft1_m_axis_data_tready;

// cmult
assign o_s_cmult1_a_sample      = r_cmult1_a_sample_reg;
assign o_s_cmult1_axis_a_tvalid = r_s_cmult1_axis_a_tvalid;
assign o_s_cmult1_b_sample      = r_cmult1_b_sample_reg;
assign o_s_cmult1_axis_b_tvalid = r_s_cmult1_axis_b_tvalid;

assign o_s_cmult2_a_sample      = r_cmult2_a_sample_reg;
assign o_s_cmult2_axis_a_tvalid = r_s_cmult2_axis_a_tvalid;
assign o_s_cmult2_b_sample      = r_cmult2_b_sample_reg;
assign o_s_cmult2_axis_b_tvalid = r_s_cmult2_axis_b_tvalid;

// ram
assign o_ram_data_in_reg          = r_ram_data_in_reg;
assign o_ram_write_en             = r_ram_write_en;
assign o_ram_porta_en             = r_ram_porta_en;
assign o_ram_portb_col_en         = r_ram_portb_col_en;
assign o_ram_portb_row_en         = r_ram_portb_row_en;
assign o_ram_read_col_addr        = r_ram_read_col_addr_reg;
assign o_ram_read_row_addr        = r_ram_read_row_addr_reg;
assign o_ram_read_row_addr_cdemod = r_ram_read_row_addr_cdemod_reg;
assign o_ram_write_addr           = r_ram_write_addr_reg;

// control
assign o_scd_done = r_scd_done;

endmodule