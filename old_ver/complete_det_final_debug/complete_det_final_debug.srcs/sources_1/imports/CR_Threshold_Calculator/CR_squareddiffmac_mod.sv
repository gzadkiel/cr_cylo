module squarediffmacc_mod # (
    parameter IN_WIDHT  = 12,  //! input data width
              OUT_WIDTH = 32,  //! MACC output width
              N_SAMPLES = 256  //! number of samples
) (
    input  logic                                clk,          //! system clock 
    input  logic                                i_cenable,    //! clock enable
    input  logic                                i_reset,      //! system reset
    input  logic        [$clog2(N_SAMPLES) : 0] i_noise_size,
    input  logic signed [IN_WIDHT      - 1 : 0] i_data,       //! input data sample
    output logic signed [OUT_WIDTH     - 1 : 0] o_accum,      //! output from MACC
    output logic                                o_valid       //! output valid
);

localparam CNT_WIDTH = $clog2(N_SAMPLES); //! counter width

// signals
logic        [CNT_WIDTH      : 0] r_counter;   //! sample counter     
logic signed [2*IN_WIDHT - 1 : 0] r_sq_data;   //! squared data
logic signed [OUT_WIDTH  - 1 : 0] r_accum;     //! accumulated data
logic                             r_valid_out; //! valid output signal
logic                             r_accumen;   //! MACC Module enable signal

always_ff @(posedge clk) begin: mult_and_acc
    if (i_reset) begin
        r_counter   <= {CNT_WIDTH{1'b0}};
        r_sq_data   <= {2*IN_WIDHT{1'b0}}; 
        r_accum     <= {OUT_WIDTH{1'b0}};
        r_valid_out <= 1'b0;
        r_accumen   <= 1'b1;
    end
    else if (i_cenable & r_accumen) begin
        r_sq_data <= i_data * i_data;
        r_accum   <= r_accum + r_sq_data;
        r_counter <= r_counter + 1'b1;
        if (r_counter == (i_noise_size)) begin 
            r_counter   <= {CNT_WIDTH{1'b0}};
            r_accumen   <= 1'b0;
            r_valid_out <= 1'b1;
        end
        else begin
            r_accumen   <= 1'b1;
            r_valid_out <= 1'b0;
        end
    end
    else begin // avoid latch
        r_counter   <= r_counter;
        r_sq_data   <= r_sq_data; 
        r_accum     <= r_accum;
        r_valid_out <= r_valid_out;
        r_accumen   <= r_accumen;
    end
end

// Output accumulation result
assign o_accum = r_accum;
assign o_valid = r_valid_out;
     
endmodule