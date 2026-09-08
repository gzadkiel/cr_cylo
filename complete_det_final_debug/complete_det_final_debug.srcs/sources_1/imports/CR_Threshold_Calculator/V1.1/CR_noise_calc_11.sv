module noise_calc #(
    parameter NB_DATA   = 12,  //! noise sample width
              N_SAMPLES = 256, //! number of samples
              NB_OUT    = 48   //! noise variance output width
) (
    input  logic                                clk,          //! system clock    
    input  logic                                i_reset,      //! active-high system reset 
    input  logic                                i_cenable,    //! clock enable for processing 
    input  logic        [$clog2(N_SAMPLES) : 0] i_noise_size, //! number of samples used
    input  logic signed [NB_DATA       - 1 : 0] i_data,       //! input sample
    output logic signed [NB_OUT        - 1 : 0] o_variance,   //! estimated variance output 
    output logic                                o_div_done    //! output valid
);
    
// signals
logic [NB_OUT - 1 : 0] r_noise_var;      //! noise variance result
logic [NB_OUT - 1 : 0] r_macc_out;       //! MACC Module output data
logic                  r_macc_out_valid; //! MACC Module valid output data
logic                  r_div_done;       //! valid variance output

always_ff @(posedge clk) begin : feed_MACC_divide
    if (i_reset) begin
        r_noise_var <= '0;
        r_div_done  <= '0;
    end    
    else if (i_cenable & r_macc_out_valid) begin
            r_div_done  <= '1;
            case (i_noise_size)
                11'b10000000000 : r_noise_var <= r_macc_out >>> 10; // 1024
                11'b01000000000 : r_noise_var <= r_macc_out >>> 9;  // 512
                11'b00100000000 : r_noise_var <= r_macc_out >>> 8;  // 256
                11'b00010000000 : r_noise_var <= r_macc_out >>> 7;  // 128
                11'b00001000000 : r_noise_var <= r_macc_out >>> 6;  // 64
                11'b00000100000 : r_noise_var <= r_macc_out >>> 5;  // 32
                default: r_noise_var <= r_macc_out >>> 10;
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
assign o_variance = r_noise_var;

endmodule