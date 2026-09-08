module comblock_adapter #(
    parameter NB_SAMPLE_DATA = 12
)(
    input  logic clock,
    
    // ComBlock OUT FIFO (PS -> PL): incoming data
    input  logic                        i_cb_OUT_FIFO_0_fifo_aempty_o,
    input  logic [2*NB_SAMPLE_DATA : 0] i_cb_OUT_FIFO_0_fifo_data_o,
    input  logic                        i_cb_OUT_FIFO_0_fifo_empty_o,
    input  logic                        i_cb_OUT_FIFO_0_fifo_underflow_o,
    input  logic                        i_cb_OUT_FIFO_0_fifo_valid_o,
    output logic                        o_cb_OUT_FIFO_0_fifo_re_i,

    // ComBlock OUT_REG0 (PS -> PL): control signals
    input logic [31 : 0] i_cb_OUT_REGS_0_reg0_o,
    input logic [31 : 0] i_cb_OUT_REGS_0_reg1_o,

    // ComBlock IN_REG0 (PL -> PS): status/results
    output logic [31 : 0] o_cb_IN_REGS_0_reg0_i,
    
    output logic [31 : 0] o_cb_IN_REGS_0_reg1_i,
    output logic [31 : 0] o_cb_IN_REGS_0_reg2_i,
    output logic [31 : 0] o_cb_IN_REGS_0_reg3_i,
    output logic [31 : 0] o_cb_IN_REGS_0_reg4_i,
    output logic [31 : 0] o_cb_IN_REGS_0_reg5_i,

    // top_mux inputs/outputs
    output logic top_mux_reset,
    output logic top_mux_enable,
    output logic top_mux_noise_data_valid,
    output logic top_mux_signal_data_valid,
    
    output logic [10 : 0] top_mux_data_size,
    output logic [10 : 0] top_mux_noise_size,
    output logic [1  : 0] top_mux_window_sel,
    output logic [3  : 0] top_mux_pfa_value,
    
    output logic top_mux_scd_mode,
    
    output logic signed [NB_SAMPLE_DATA - 1 : 0] top_mux_data_re,
    output logic signed [NB_SAMPLE_DATA - 1 : 0] top_mux_data_im,
    
    input logic signed [64 : 0] top_mux_threshold,
    input logic signed [33 : 0] top_mux_noise_power,
    
    input  logic [15 : 0] top_mux_detect,
    input  logic          top_mux_detection_done,
    input  logic          top_mux_threshold_est_done
);

logic                          r_top_mux_reset, w_top_mux_reset;           
logic                          r_top_mux_enable, w_top_mux_enable;            
logic                          r_top_mux_noise_data_valid, w_top_mux_noise_data_valid;
logic                          r_top_mux_signal_data_valid, w_top_mux_signal_data_valid;
logic [10                 : 0] r_top_mux_data_size, w_top_mux_data_size;
logic [10                 : 0] r_top_mux_noise_size, w_top_mux_noise_size;
logic [1                  : 0] r_top_mux_window_sel, w_top_mux_window_sel;
logic [3                  : 0] r_top_mux_pfa_value, w_top_mux_pfa_value;
logic [NB_SAMPLE_DATA - 1 : 0] r_top_mux_data_im, w_top_mux_data_im;
logic [NB_SAMPLE_DATA - 1 : 0] r_top_mux_data_re, w_top_mux_data_re;

logic                          r_top_mux_scd_mode, w_top_mux_scd_mode;

//==============================================================================
// Control signals from OUT_REG0
assign w_top_mux_reset             = i_cb_OUT_REGS_0_reg0_o[0];
assign w_top_mux_enable            = i_cb_OUT_REGS_0_reg0_o[1];
assign w_top_mux_noise_data_valid  = i_cb_OUT_REGS_0_reg0_o[2];
assign w_top_mux_signal_data_valid = i_cb_OUT_REGS_0_reg0_o[3];

assign w_top_mux_data_size  = i_cb_OUT_REGS_0_reg0_o[14 : 4 ];
assign w_top_mux_noise_size = i_cb_OUT_REGS_0_reg0_o[25 : 15];
assign w_top_mux_window_sel = i_cb_OUT_REGS_0_reg0_o[27 : 26];
assign w_top_mux_pfa_value  = i_cb_OUT_REGS_0_reg0_o[31 : 28];

assign w_top_mux_scd_mode = i_cb_OUT_REGS_0_reg1_o[0];
//==============================================================================

//==============================================================================
// Results into IN_REG0
assign o_cb_IN_REGS_0_reg0_i = {{(32 - 16 - 1 - 1){1'b0}}, 
                               top_mux_threshold_est_done, 
                               top_mux_detection_done    ,
                               top_mux_detect            };
                               
assign o_cb_IN_REGS_0_reg1_i = top_mux_noise_power[31 : 0 ];
assign o_cb_IN_REGS_0_reg2_i = top_mux_noise_power[33 : 31];

assign o_cb_IN_REGS_0_reg3_i = top_mux_threshold[31 : 0 ];
assign o_cb_IN_REGS_0_reg4_i = top_mux_threshold[63 : 32];
assign o_cb_IN_REGS_0_reg5_i = top_mux_threshold[64];
//==============================================================================
    
//==============================================================================
// FIFO READ ENABLE CONTROL
// control of fifo read in signal
logic w_fifo_read_en;

always_comb begin : check_fifo_empty_read_enable
    // ONLY read if the FIFO has data AND the PS has commanded a run.
    if (!i_cb_OUT_FIFO_0_fifo_empty_o && (w_top_mux_signal_data_valid || w_top_mux_noise_data_valid)) begin
        w_fifo_read_en = 1'b1;
    end 
    else begin
        w_fifo_read_en = 1'b0;
    end
end

assign o_cb_OUT_FIFO_0_fifo_re_i = w_fifo_read_en;
//==============================================================================

//==============================================================================
// FIFO READ CONTROL
// read data from FIFO
logic signed [NB_SAMPLE_DATA - 1 : 0] i_cb_OUT_FIFO_0_fifo_data_re;
logic signed [NB_SAMPLE_DATA - 1 : 0] i_cb_OUT_FIFO_0_fifo_data_im;

always_ff @(posedge clock) begin : get_fifo_samples
    if (top_mux_reset) begin
        i_cb_OUT_FIFO_0_fifo_data_im <= '0;
        i_cb_OUT_FIFO_0_fifo_data_re <= '0;
    end
    else if (w_fifo_read_en) begin 
        i_cb_OUT_FIFO_0_fifo_data_im <= i_cb_OUT_FIFO_0_fifo_data_o[2*NB_SAMPLE_DATA - 1 : NB_SAMPLE_DATA];
        i_cb_OUT_FIFO_0_fifo_data_re <= i_cb_OUT_FIFO_0_fifo_data_o[NB_SAMPLE_DATA   - 1 : 0];
    end
    else begin
        i_cb_OUT_FIFO_0_fifo_data_im <= i_cb_OUT_FIFO_0_fifo_data_im;
        i_cb_OUT_FIFO_0_fifo_data_re <= i_cb_OUT_FIFO_0_fifo_data_re;
    end
end

assign w_top_mux_data_im = i_cb_OUT_FIFO_0_fifo_data_im;
assign w_top_mux_data_re = i_cb_OUT_FIFO_0_fifo_data_re;
//==============================================================================

//==============================================================================
// register all outputs to avoid timing issues
always_ff @(posedge clock) begin 
    r_top_mux_reset             <= w_top_mux_reset;
    r_top_mux_enable            <= w_top_mux_enable;
    r_top_mux_noise_data_valid  <= w_top_mux_noise_data_valid;
    r_top_mux_signal_data_valid <= w_top_mux_signal_data_valid;
    r_top_mux_data_size         <= w_top_mux_data_size;
    r_top_mux_noise_size        <= w_top_mux_noise_size;
    r_top_mux_window_sel        <= w_top_mux_window_sel;
    r_top_mux_pfa_value         <= w_top_mux_pfa_value;
    r_top_mux_data_im           <= w_top_mux_data_im;
    r_top_mux_data_re           <= w_top_mux_data_re;
    
    r_top_mux_scd_mode          <= w_top_mux_scd_mode;
end
//==============================================================================

assign top_mux_reset             = r_top_mux_reset;  
assign top_mux_enable            = r_top_mux_enable;  
assign top_mux_noise_data_valid  = r_top_mux_noise_data_valid;  
assign top_mux_signal_data_valid = r_top_mux_signal_data_valid;  
assign top_mux_data_size         = r_top_mux_data_size;  
assign top_mux_noise_size        = r_top_mux_noise_size;  
assign top_mux_window_sel        = r_top_mux_window_sel;  
assign top_mux_pfa_value         = r_top_mux_pfa_value;  
assign top_mux_data_im           = r_top_mux_data_im;  
assign top_mux_data_re           = r_top_mux_data_re;  

assign top_mux_scd_mode = r_top_mux_scd_mode;

endmodule