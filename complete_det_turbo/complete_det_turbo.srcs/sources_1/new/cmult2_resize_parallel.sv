module cmult2_resize_parallel #(
    parameter integer N_ENGINES   = 4,
    parameter integer RAW_WIDTH   = 80,
    parameter integer FULL_COMP_W = 33,
    parameter integer OUT_COMP_W  = 32,
    parameter integer REAL_LSB    = 0,
    parameter integer IMAG_LSB    = 40
) (
    input  logic [RAW_WIDTH    - 1 : 0] i_cmult_tdata  [N_ENGINES],
    input  logic                        i_cmult_tvalid [N_ENGINES],

    output logic [2*OUT_COMP_W - 1 : 0] o_tdata  [N_ENGINES],
    output logic                        o_tvalid [N_ENGINES]
);

    // 16-bit/component CMULT inputs -> 33-bit/component full-precision output.
    // Xilinx packing used here:
    //   real = TDATA[32:0]
    //   imag = TDATA[72:40]
    //
    // Preserve the original fixed-point resize: 33 bits -> 32 bits as {full[30:0], 1'b0}.

    logic signed [FULL_COMP_W - 1 : 0] full_re [N_ENGINES];
    logic signed [FULL_COMP_W - 1 : 0] full_im [N_ENGINES];
    logic signed [OUT_COMP_W  - 1 : 0] out_re  [N_ENGINES];
    logic signed [OUT_COMP_W  - 1 : 0] out_im  [N_ENGINES];

    always_comb begin
        for (int eng = 0; eng < N_ENGINES; eng++) begin
            full_re[eng] = $signed(i_cmult_tdata[eng][REAL_LSB +: FULL_COMP_W]);
            full_im[eng] = $signed(i_cmult_tdata[eng][IMAG_LSB +: FULL_COMP_W]);

            out_re[eng] = {full_re[eng][OUT_COMP_W-2:0], 1'b0};
            out_im[eng] = {full_im[eng][OUT_COMP_W-2:0], 1'b0};

            o_tdata[eng]  = {out_im[eng], out_re[eng]};
            o_tvalid[eng] = i_cmult_tvalid[eng];
        end
    end

endmodule
