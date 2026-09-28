module squarediffmacc_mod #(
    parameter integer IN_WIDHT  = 12,  //! input data width
    parameter integer OUT_WIDTH = 32,  //! MACC output width
    parameter integer N_SAMPLES = 256  //! maximum number of samples
) (
    input  logic                                clk,          //! system clock
    input  logic                                i_cenable,    //! input sample enable
    input  logic                                i_reset,      //! active-high synchronous reset
    input  logic        [$clog2(N_SAMPLES) : 0] i_noise_size, //! number of samples used
    input  logic signed [IN_WIDHT      - 1 : 0] i_data,       //! input data sample
    output logic signed [OUT_WIDTH     - 1 : 0] o_accum,      //! accumulated squared samples
    output logic                                o_valid       //! one-clock output-valid pulse
);

localparam integer CNT_WIDTH = $clog2(N_SAMPLES + 1);

// -----------------------------------------------------------------------------
// pipeline:
//  input sample -> square register -> accumulator
//
// exactly i_noise_size input samples are accepted, the last registered square
// is accumulated before o_valid is asserted, avoiding the off-by-one behavior
// of the previous implementation.
// -----------------------------------------------------------------------------

logic signed [2*IN_WIDHT - 1 : 0] w_sq_data;
logic signed [2*IN_WIDHT - 1 : 0] r_sq_data;
logic signed [OUT_WIDTH  - 1 : 0] w_sq_ext;
logic signed [OUT_WIDTH  - 1 : 0] r_accum;

logic [CNT_WIDTH - 1 : 0] r_sample_count;
logic                     r_sq_valid;
logic                     r_sq_last;
logic                     r_input_done;
logic                     r_valid_out;

assign w_sq_data = i_data * i_data;

// a square is always non-negative, therefore zero extension is intentional.
assign w_sq_ext = {{(OUT_WIDTH - 2*IN_WIDHT){1'b0}}, r_sq_data};

always_ff @(posedge clk) begin : square_and_accumulate
    if (i_reset) begin
        r_sq_data      <= '0;
        r_accum        <= '0;
        r_sample_count <= '0;
        r_sq_valid     <= '0;
        r_sq_last      <= '0;
        r_input_done   <= '0;
        r_valid_out    <= '0;
    end
    else begin
        // internal valid is a pulse.
        r_valid_out <= 1'b0;

        // ---------------------------------------------------------------------
        // stage 2: accumulate the square registered on the previous cycle.
        // ---------------------------------------------------------------------
        if (r_sq_valid) begin
            r_accum <= r_accum + w_sq_ext;
            if (r_sq_last) r_valid_out <= 1'b1;
        end

        // ---------------------------------------------------------------------
        // stage 1: accept exactly i_noise_size samples.
        // i_noise_size must remain stable while an estimation is active.
        // ---------------------------------------------------------------------
        r_sq_valid <= 1'b0;
        r_sq_last  <= 1'b0;

        if (i_cenable && !r_input_done && (i_noise_size != 0)) begin
            r_sq_data  <= w_sq_data;
            r_sq_valid <= 1'b1;

            if (r_sample_count == (i_noise_size - 1'b1)) begin
                r_sq_last    <= 1'b1;
                r_input_done <= 1'b1;
            end
            else r_sample_count <= r_sample_count + 1'b1;
        end
    end
end

assign o_accum = r_accum;
assign o_valid = r_valid_out;

endmodule
