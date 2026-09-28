module scd_fft1_bank_tdp_ram #(
    parameter integer DATA_WIDTH = 32,
    parameter integer DEPTH      = 1024,
    parameter integer ADDR_WIDTH = $clog2(DEPTH)
) (
    input  logic                      clock,

    // Port A: write during load phase, read during processing phase.
    input  logic                      i_porta_en,
    input  logic                      i_porta_we,
    input  logic [ADDR_WIDTH - 1 : 0] i_porta_addr,
    input  logic [DATA_WIDTH - 1 : 0] i_porta_din,
    output logic [DATA_WIDTH - 1 : 0] o_porta_dout,

    // Port B: read-only during processing phase.
    input  logic                      i_portb_en,
    input  logic [ADDR_WIDTH - 1 : 0] i_portb_addr,
    output logic [DATA_WIDTH - 1 : 0] o_portb_dout
);

    (* ram_style = "block" *) logic [DATA_WIDTH-1 : 0] mem [0 : DEPTH-1];

    // True-dual-port inference template:
    // Port A = read/write, Port B = read.
    always_ff @(posedge clock) begin
        if (i_porta_en) begin
            if (i_porta_we) mem[i_porta_addr] <= i_porta_din;
            o_porta_dout <= mem[i_porta_addr];
        end
    end

    always_ff @(posedge clock) begin
        if (i_portb_en) o_portb_dout <= mem[i_portb_addr];
    end

endmodule
