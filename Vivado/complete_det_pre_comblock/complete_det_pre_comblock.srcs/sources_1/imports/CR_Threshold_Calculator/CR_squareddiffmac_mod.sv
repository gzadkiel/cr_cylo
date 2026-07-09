//! @title Multiply and Accumulate
//! @author gmarti
//
// Module: squarediffmacc_mod
// Description:
// Computes the squared magnitude of each input sample and accumulates the result over a fixed number of samples (`N_SAMPLES`). 
// The operation is equivalent to a sum of squares and is implemented efficiently in a single DSP block. Once all samples are processed, 
// the module asserts `o_valid` to indicate that the accumulated result (`o_accum`) is ready. The accumulator then stops until reset.


module squarediffmacc_mod # (
    parameter IN_WIDHT  = 12,  //! Input data width
              OUT_WIDTH = 32,  //! MACC output width
              N_SAMPLES = 256 //! Number of samples
) (
    input  logic                                clk,       //! System clock 
    input  logic                                i_cenable, //! Clock enable
    input  logic                                i_reset,   //! System reset
    input  logic        [$clog2(N_SAMPLES) : 0] i_noise_size,
    input  logic signed [IN_WIDHT      - 1 : 0] i_data,    //! Input data sample
    output logic signed [OUT_WIDTH     - 1 : 0] o_accum,   //! Output from MACC
    output logic                                o_valid    //! Output valid
);

// Localparam
localparam CNT_WIDTH = $clog2(N_SAMPLES); //! Counter width

// Signals
logic        [CNT_WIDTH      : 0] r_counter;   //! Sample counter     
logic signed [2*IN_WIDHT - 1 : 0] r_sq_data;   //! Squared data
logic signed [OUT_WIDTH  - 1 : 0] r_accum;     //! Accumulated data
logic                             r_valid_out; //! Valid output signal
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
        if (r_counter == (i_noise_size)) begin // como hay delay cuento 1 mas
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
