//! @title Detection Threshold ROM
//! @author gmarti

module threshold_rom #(
    parameter N_PFA  = 10, //! Number of false alarm probability values
              NB_OUT = 33 //! Threshold data width 
) (
    input  logic        [$clog2(N_PFA) - 1 : 0] i_pfa_addr, //! Input Pfa value
    output logic signed [NB_OUT        - 1 : 0] o_threshold //! Output threshold
);

logic signed [NB_OUT - 1 : 0] mem [N_PFA]; //! ROM

initial begin : load_rom
    $readmemb("pfa_n_based_threshold.mem", mem);
end

assign o_threshold = mem[i_pfa_addr];

endmodule