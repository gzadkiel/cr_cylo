module first_stage_fsmd #(
    parameter P_MAX            = 64, 
              NP               = 64, 
              NB_DATA          = 16, 
              NBF_DATA         = 15, 
              NB_WIN           = 8, 
              NBF_WIN          = 7,
              AXI_CONFIG_WIDTH = 7 // 6 bit SCALE_SCH + 1 bit FWD_INV
) (
    input  logic                     clock,
    input  logic                     i_reset,
    input  logic                     i_enable,
    input  logic                     i_scd_done,
    input  logic [$clog2(P_MAX) : 0] i_p_frames, // added 
    
    output logic                     o_input_win_enable,
    
    // fft signals
    input  logic                            i_s_axis_data_tready, 
    output logic                            o_s_axis_data_tlast,
    output logic                            o_s_axis_data_tvalid,
    output logic [2*NB_DATA        - 1 : 0] o_s_axis_data_tdata,
    input  logic                            i_s_axis_config_tready,
    output logic                            o_s_axis_config_tvalid,
    output logic [AXI_CONFIG_WIDTH - 1 : 0] o_s_axis_config_tdata,
    
    // ram signals
    input  logic                            i_window_prod_valid_re,
    input  logic                            i_window_prod_valid_im,
    input  logic [2*NB_DATA        - 1 : 0] i_ram_data_out [NP],
    output logic                            o_ram_porta_enable,
    output logic                            o_ram_portb_enable,
    output logic [$clog2(P_MAX)    - 1 : 0] o_ram_write_addr,
    output logic [$clog2(P_MAX)    - 1 : 0] o_ram_read_addr 
);

typedef enum {S_IDLE,           
              S_STR_RAM,      
              S_LD_BUFF,
              S_CONF_LD_FFT,      
              S_LD_FFT,       
              S_WAIT_RDY,     
              S_WAIT_NXT_BLOCK,
              S_DONE} state_type;

state_type state_reg, state_next;

localparam INDX_WIDTH = $clog2(NP   ); //! fft input buffer index
localparam ADDR_WIDTH = $clog2(P_MAX); //! ram address width

localparam AXI_CONFIG_DATA_WIDTH = 7; //! fft core config data width 
localparam AXI_CONFIG_FWIN_WIDTH = 1; //! forward/inverse fft field width
localparam AXI_CONFIG_SCAL_WIDTH = 6; //! scaling schedule field width

// fft config sigs
logic [AXI_CONFIG_FWIN_WIDTH - 1 : 0] FWD_INV; //! fwd/inv fft
logic [AXI_CONFIG_SCAL_WIDTH - 1 : 0] SCALE_SCH ; //! scaling schedule of internal fft stages
logic [AXI_CONFIG_DATA_WIDTH - 1 : 0] w_s_axis_config_tdata; //! initial fft core config

// fft input buffer sigs
logic                      r_fft_input_buffer_ld;
logic [2*NB_DATA  - 1 : 0] r_fft_input_buffer [NP];
logic [2*NB_DATA  - 1 : 0] r_fft_data_in_reg, r_fft_data_in_next; //! fft input sample, format {imag,real}
logic                      r_fft_data_in_ld; //! flag to load fft input sample
logic [INDX_WIDTH - 1 : 0] r_index_reg, r_index_next; //! index to feed samples from buffer to fft core
logic                      r_index_inc, r_index_out, r_index_clr; //! index control sigs

// ram sigs
logic [ADDR_WIDTH - 1 : 0] r_ram_write_addr_reg, r_ram_write_addr_next; //! ram write address signal
logic                      r_ram_write_addr_inc, r_ram_write_addr_out, r_ram_write_addr_clr; //! write addr control sigs
logic [ADDR_WIDTH     : 0] r_ram_read_addr_reg, r_ram_read_addr_next; //! ram read address signal
logic                      r_ram_read_addr_inc, r_ram_read_addr_out, r_ram_read_addr_clr; //! read addr control sigs
logic                      w_ram_porta_enable, w_ram_portb_enable; //! enable signal for ram port a (write)
logic                      r_ram_porta_enable, r_ram_portb_enable; //! enable signal for ram port b (read)

// fft axi-stream sigs
logic w_s_axis_data_tlast, w_s_axis_data_tvalid; 
logic r_s_axis_data_tlast, r_s_axis_data_tvalid;
logic w_s_axis_config_tvalid;
logic r_s_axis_config_tvalid;

// input_window enable signal
logic r_input_win_enable;
assign o_input_win_enable = r_input_win_enable;

//==============================================================================
// load fft input buffer
always_ff @(posedge clock) begin
    if (i_reset) begin
        for (int ptr_buffer = 0 ; ptr_buffer < NP ; ptr_buffer = ptr_buffer + 1) begin
            r_fft_input_buffer[ptr_buffer] = '0;
        end
    end
    else if (r_fft_input_buffer_ld) begin
        for (int ptr_buffer = 0 ; ptr_buffer < NP ; ptr_buffer = ptr_buffer + 1) begin
            r_fft_input_buffer[ptr_buffer] = i_ram_data_out[ptr_buffer];
        end
    end
    else begin
        for (int ptr_buffer = 0 ; ptr_buffer < NP ; ptr_buffer = ptr_buffer + 1) begin
            r_fft_input_buffer[ptr_buffer] = r_fft_input_buffer[ptr_buffer];
        end
    end
end
//==============================================================================

// fsmd state / data registers
always_ff @(posedge clock, posedge i_reset) begin : fsmd_state_register_control
    if (i_reset) begin
        state_reg            <= S_IDLE;
        r_index_reg          <= '0;
        r_fft_data_in_reg    <= '0;
        r_ram_read_addr_reg  <= '0;
        r_ram_write_addr_reg <= '0;
    end
    else if (i_enable) begin
        state_reg            <= state_next;
        r_ram_write_addr_reg <= r_ram_write_addr_next;
        r_ram_read_addr_reg  <= r_ram_read_addr_next;    
        r_index_reg          <= r_index_next;
        r_fft_data_in_reg    <= r_fft_data_in_next;
    end
    else begin
        state_reg            <= state_reg;   
        r_ram_write_addr_reg <= r_ram_write_addr_reg;   
        r_ram_read_addr_reg  <= r_ram_read_addr_reg;   
        r_index_reg          <= r_index_reg;   
        r_fft_data_in_reg    <= r_fft_data_in_reg; 
    end
end

// fsmd data path next-state logic
// ram write/read address
assign r_ram_write_addr_next = (r_ram_write_addr_clr) ? '0 : (r_ram_write_addr_inc) ? r_ram_write_addr_reg + 1'b1 : r_ram_write_addr_reg;
assign r_ram_write_addr_out  = (r_ram_write_addr_reg == i_p_frames - 1) ? '1 : '0; 
assign r_ram_read_addr_next  = (r_ram_read_addr_clr) ? '0 : (r_ram_read_addr_inc) ? r_ram_read_addr_reg + 1'b1 : r_ram_read_addr_reg;
assign r_ram_read_addr_out   = (r_ram_read_addr_reg == i_p_frames) ? '1 : '0;

// fft input buffer index
assign r_index_next       = (r_index_clr) ? '0 : (r_index_inc) ? r_index_reg + 1'b1 : r_index_reg;
assign r_index_out        = (r_index_reg == NP - 1) ? '1 : '0;
assign r_fft_data_in_next = (r_fft_data_in_ld) ? r_fft_input_buffer[r_index_reg] : r_fft_data_in_reg;

// fft runtime config
assign FWD_INV = 1'b1; // select forward fft mode
assign SCALE_SCH = 6'b010111; // select appropiate scaling factor for N = 32 
assign w_s_axis_config_tdata = {SCALE_SCH,FWD_INV}; // load config for fixed size

// fsmd control path next-state logic + outputs
always_comb begin : fsmd_next_state_output_logic
    
    state_next = S_IDLE;
    // default initial values
    r_fft_input_buffer_ld  = '0;
    r_input_win_enable     = '0;
    r_fft_data_in_ld       = '0;
    r_index_inc            = '0;
    r_index_clr            = '0;
    r_ram_write_addr_inc   = '0;
    r_ram_write_addr_clr   = '0;
    r_ram_read_addr_inc    = '0;
    r_ram_read_addr_clr    = '0;
    w_ram_porta_enable     = '0;
    w_ram_portb_enable     = '0;
    w_s_axis_data_tlast    = '0; 
    w_s_axis_data_tvalid   = '0; 
    w_s_axis_config_tvalid = '1;

    case (state_reg)
        S_IDLE : begin
            // set all sigs to default values
            r_fft_data_in_ld     = '0;
            r_index_inc          = '0;
            r_index_clr          = '1;
            r_ram_write_addr_inc = '0;
            r_ram_write_addr_clr = '1;
            r_ram_read_addr_inc  = '0;
            r_ram_read_addr_clr  = '1;
            w_ram_porta_enable   = '0;
            w_ram_portb_enable   = '0;
            // ------------------------------

            w_s_axis_data_tlast    = '0; 
            w_s_axis_data_tvalid   = '0; 
            w_s_axis_config_tvalid = '1; // set config_tvalid to 1 to load fft core config
            if (i_s_axis_config_tready) state_next = S_STR_RAM; // once config_tready from fft is 1 load config and start
            else state_next = S_IDLE; // wait for config_tready
        end
        S_STR_RAM : begin
            // clrs set to 1 on start, now set to 0
            r_index_clr          = '0;
            r_ram_write_addr_clr = '0;
            r_ram_read_addr_clr  = '0;
            // ---------------------------------

            r_input_win_enable     = '1; // added to stop input_window from working al pepe
            w_s_axis_config_tvalid = '0;
            w_ram_porta_enable     = '1; // enable ram write port
            w_ram_portb_enable     = '1; // enable ram read port (early)
            if (i_window_prod_valid_re && i_window_prod_valid_im) begin // valid output from input_window
                r_ram_write_addr_inc = '1; // write ram and increase write addr
                if (r_ram_write_addr_out) begin // once all blocks are stored
                    r_ram_write_addr_clr = '1; // reset write addr
                    w_ram_porta_enable   = '0; // disable write port
                    state_next           = S_LD_BUFF; // next state
                end
                else begin
                    w_ram_porta_enable   = '1;
                    state_next           = S_STR_RAM;
                end
            end
            else begin
                r_ram_write_addr_inc = '0;
                state_next           = S_STR_RAM; 
            end   
        end
        S_LD_BUFF : begin 
            // added for better control sig management
            r_ram_write_addr_inc = '0;
            r_ram_write_addr_clr = '0;
            r_ram_read_addr_clr  = '0; // !!
            w_ram_portb_enable   = '1; // !!
            // ---------------------------------------

            r_fft_input_buffer_ld = '1; // load ram data into fft input buffer
            r_ram_read_addr_inc   = '1; // increase read addr
            state_next            = S_CONF_LD_FFT; // next state
        end
        S_CONF_LD_FFT : begin
            // add an extra clock delay for better sync 
            // stop read addr inc, only inc when loading buffer on S_LD_BUFF !!
            r_ram_read_addr_inc = '0;
            r_ram_read_addr_clr = '0; // !!
            w_ram_portb_enable  = '1; // !!
            // ----------------------------------------------------------------
            if (i_s_axis_data_tready) state_next = S_LD_FFT; // if data_tready from fft is set, feed core
            else state_next = S_CONF_LD_FFT; // wait for data_ready
        end
        S_LD_FFT : begin
            w_ram_portb_enable   = '1; // !!
            r_ram_read_addr_clr  = '0;
            w_s_axis_data_tlast  = '0; // imitates behaviour of provided testbench
            w_s_axis_data_tvalid = '1; // set data_tvalid
            if (i_s_axis_data_tready) begin // only send data if core data_tready is set
                r_fft_data_in_ld = '1; // send data sample to fft core
                r_index_inc      = '1; // increase sample index
                if (r_index_out) begin // once np samples are sent
                    w_s_axis_data_tlast = '1; // set data_tlast
                    r_index_clr         = '1; // reset sample index 
                    state_next          = S_WAIT_NXT_BLOCK; // added for better sync
                    if (r_ram_read_addr_out) begin // once p blocks loaded
                        r_ram_read_addr_clr = '1; // reset read addr
                        state_next          = S_DONE; // all blocks transformed, done
                    end
                    else r_ram_read_addr_clr = '0;
                end
                else begin
                    w_s_axis_data_tlast = '0;
                    r_index_clr         = '0;
                    state_next          = S_LD_FFT;
                end
            end
            else begin
                r_fft_data_in_ld = '0;
                r_index_inc      = '0;
                state_next       = S_WAIT_RDY;
            end
        end
        S_WAIT_RDY : begin
            // if data_tready goes to 0 while feeding core
            if (i_s_axis_data_tready) state_next = S_LD_FFT;
            else state_next = S_WAIT_RDY;
        end
        S_WAIT_NXT_BLOCK : begin
            // once the whole data block is fed wait (better sync) 
            w_ram_portb_enable   = '1; // !!
            r_ram_read_addr_clr  = '0; // !!
            w_s_axis_data_tvalid = '0; // reset data_tvalid
            if (i_s_axis_data_tready) state_next = S_LD_BUFF; // if core is ready go again
            else state_next = S_WAIT_NXT_BLOCK; // no data_tready keep waiting
        end
        S_DONE : begin
           w_s_axis_data_tlast  = '0;
           w_s_axis_data_tvalid = '0;
           if (i_scd_done) state_next = S_IDLE;
           else state_next = S_DONE; 
        end
        default: state_next = S_IDLE; 
    endcase
end

// register all outputs to isolate modules and improve timing (opt)
always_ff @(posedge clock) begin : registed_output
    r_s_axis_data_tlast    <= w_s_axis_data_tlast;
    r_s_axis_data_tvalid   <= w_s_axis_data_tvalid;
    r_s_axis_config_tvalid <= w_s_axis_config_tvalid;

    r_ram_porta_enable <= w_ram_porta_enable;
    r_ram_portb_enable <= w_ram_portb_enable;
end

assign o_s_axis_data_tlast  = r_s_axis_data_tlast;
assign o_s_axis_data_tvalid = r_s_axis_data_tvalid;
assign o_s_axis_data_tdata  = r_fft_data_in_reg;

assign o_s_axis_config_tvalid = r_s_axis_config_tvalid;
assign o_s_axis_config_tdata  = w_s_axis_config_tdata;

assign o_ram_porta_enable     = r_ram_porta_enable;
assign o_ram_portb_enable     = r_ram_portb_enable;
assign o_ram_write_addr       = r_ram_write_addr_reg;
assign o_ram_read_addr        = r_ram_read_addr_reg;

endmodule