//! @title Noise Cariance Calculator
//! @author gmarti
//
// Module: noise_calc
// Description:
// Estimates the noise variance over a block of N_SAMPLES input values. It instantiates the `squarediffmacc_mod` 
// module, which squares each sample and accumulates the result. Once the accumulation is complete, the output is 
// right-shifted (division by N_SAMPLES) to compute the variance. The module asserts `o_div_done` when the final 
// variance result is available.
// 
// I/O Signals:
// | Signal     | Dir  | Width / Type                         | Description                                                     |
// |------------|------|--------------------------------------|-----------------------------------------------------------------|
// | clk        | in   | 1 bit (logic)                        | System clock                                                    |
// | i_reset    | in   | 1 bit (logic)                        | Active-high system reset                                        |
// | i_cenable  | in   | 1 bit (logic)                        | Clock enable for processing                                     |
// | i_data     | in   | signed [NB_DATA-1:0]                 | Input noise sample                                              |
// | o_variance | out  | signed [NB_OUT-1:0]                  | Computed noise variance result                                  |
// | o_div_done | out  | 1 bit (logic)                        | Asserted high when variance calculation is complete             |


module noise_calc #(
    parameter NB_DATA   = 12,   //! Noise sample width
              N_SAMPLES = 256, //! Number of samples
              NB_OUT    = 48    //! Noise variance output width
) (
    input  logic                                clk,        //! System clock    
    input  logic                                i_reset,    //! Active-high system reset 
    input  logic                                i_cenable,  //! Clock enable for processing 
    input  logic        [$clog2(N_SAMPLES) : 0] i_noise_size, // added !!1
    input  logic signed [NB_DATA       - 1 : 0] i_data,     //! Input sample
    output logic signed [NB_OUT        - 1 : 0] o_variance, //! Computed variance output 
    output logic                                o_div_done  //! Output valid
);
    
// Localparam
// MACC N samples, NB_DATA bits each -> Output Width is 2*NB_DATA + log2(N)
//localparam NB_MACC_OUT = 2*NB_DATA + $clog2(N_SAMPLES); //! MACC Module output width
//localparam DIV         = $clog2(N_SAMPLES);             //! Number of shifts for division by 2

// Signals
logic [NB_OUT - 1 : 0] r_noise_var;      //! Noise variance result
logic [NB_OUT - 1 : 0] r_macc_out;       //! MACC Module output data
logic                  r_macc_out_valid; //! MACC Module valid output data
logic                  r_div_done;       //! Valid variance output

always_ff @(posedge clk) begin : feed_MACC_divide
    if (i_reset) begin
        r_noise_var <= '0;
        r_div_done  <= '0;
    end    
    else if (i_cenable & r_macc_out_valid) begin
            //r_noise_var <= r_macc_out >>> DIV;
            r_div_done  <= '1;
            case (i_noise_size)
                9'b100000000 : r_noise_var <= r_macc_out >>> 8; // 256
                9'b010000000 : r_noise_var <= r_macc_out >>> 7; // 128
                9'b001000000 : r_noise_var <= r_macc_out >>> 6; // 64
                9'b000100000 : r_noise_var <= r_macc_out >>> 5; // 32
                default: r_noise_var <= r_macc_out >>> 7;
            endcase
    end
    else begin // avoid latch
        r_div_done  <= r_div_done;
        r_noise_var <= r_noise_var;
    end
end

squarediffmacc_mod # (
    .IN_WIDHT  (NB_DATA  ),
    .OUT_WIDTH (NB_OUT   ),
    .N_SAMPLES (N_SAMPLES))
squarediffmacc_mod_inst (
    .clk          (clk             ),
    .i_cenable    (i_cenable       ),
    .i_reset      (i_reset         ),
    .i_noise_size (i_noise_size    ),
    .i_data       (i_data          ),
    .o_accum      (r_macc_out      ),
    .o_valid      (r_macc_out_valid));

assign o_div_done = r_div_done;
// assign o_variance = r_noise_var <<< 1;
assign o_variance = r_noise_var;

endmodule