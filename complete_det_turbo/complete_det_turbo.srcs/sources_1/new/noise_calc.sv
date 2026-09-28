module noise_calc #(
    parameter integer NB_DATA   = 12,   
    parameter integer N_SAMPLES = 1024,
    parameter integer NB_OUT    = 48    
) (
    input  logic                                clk,         
    input  logic                                i_reset,     
    input  logic                                i_cenable,    
    input  logic        [$clog2(N_SAMPLES) : 0] i_noise_size, 
    input  logic signed [NB_DATA       - 1 : 0] i_data,       
    output logic signed [NB_OUT        - 1 : 0] o_variance,   
    output logic                                o_div_done   
);

logic signed [NB_OUT - 1 : 0] r_noise_var;
logic signed [NB_OUT - 1 : 0] r_macc_out;
logic                         r_macc_out_valid;
logic                         r_div_done;

// -----------------------------------------------------------------------------
// division by N is implemented as a right shift.
// supported noise sizes are powers of two.
// -----------------------------------------------------------------------------

always_ff @(posedge clk) begin : divide_accumulation
    if (i_reset) begin
        r_noise_var <= '0;
        r_div_done  <= '0;
    end
    else begin
        // pulse only when a new variance value is produced.
        r_div_done <= 1'b0;

        // once the MACC has completed, finish the calculation regardless of the current value of i_cenable.
        if (r_macc_out_valid) begin
            case (i_noise_size)
                1024 : r_noise_var <= r_macc_out >>> 10;
                 512 : r_noise_var <= r_macc_out >>> 9;
                 256 : r_noise_var <= r_macc_out >>> 8;
                 128 : r_noise_var <= r_macc_out >>> 7;
                  64 : r_noise_var <= r_macc_out >>> 6;
                  32 : r_noise_var <= r_macc_out >>> 5;
                default: r_noise_var <= r_macc_out >>> 10;
            endcase
            r_div_done <= 1'b1;
        end
    end
end

squarediffmacc_mod #(
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
