//! @title Detection Threshold ROM
//! @author gmarti

module threshold_rom #(
    parameter N_PFA  = 10, //! Number of false alarm probability values
              NB_OUT = 33 //! Threshold data width 
) (
    input  logic                                i_enable,   //! ROM Output Enable
    input  logic        [$clog2(N_PFA) - 1 : 0] i_pfa_addr, //! Input Pfa value
    output logic signed [NB_OUT        - 1 : 0] o_threshold //! Output threshold
);

logic signed [NB_OUT - 1 : 0] mem [N_PFA]; //! ROM

// Initialization from MEM file 
// Example: N_SIGMA = 2, N_PFA = 2. Memfile looks like:
// [NB_OUT-1:0] [NB_OUT-1:0]
// [NB_OUT-1:0] [NB_OUT-1:0]

initial begin : load_rom
    $readmemb("pfa_n_based_threshold.mem", mem);
end

assign o_threshold = mem[i_pfa_addr];

//always_comb begin : ROM_read_op
//    o_threshold <= mem[i_pfa_addr];
//    //if (i_enable) o_threshold <= mem[i_pfa_addr];
//    //else o_threshold <= mem[0];
//end

endmodule