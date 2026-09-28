module phase_corrector_4lane #(
    parameter integer NB_DATA          = 16,
    parameter integer NBF_IN           = 13,
    parameter integer NBF_OUT          = 15,
    parameter bit     SATURATE_NEG     = 1'b1,
    parameter bit     SATURATE_RESIZE  = 1'b1
) (
    input  logic                     clock,
    input  logic                     i_reset,
    input  logic                     i_enable,

    input  logic [2*NB_DATA - 1 : 0] i_s_axis_tdata  [4],
    input  logic                     i_s_axis_tvalid [4],
    input  logic                     i_s_axis_tlast  [4],
    output logic                     o_s_axis_tready [4],

    output logic [2*NB_DATA - 1 : 0] o_m_axis_tdata  [4],
    output logic                     o_m_axis_tvalid [4],
    output logic                     o_m_axis_tlast  [4],
    input  logic                     i_m_axis_tready [4]
);

    // -------------------------------------------------------------------------
    // First-stage frame distribution:
    //
    //  lane 0 -> k = 0, 4 , 8 , ... -> k mod 4 = 0
    //  lane 1 -> k = 1, 5 , 9 , ... -> k mod 4 = 1
    //  lane 2 -> k = 2, 6 , 10, ... -> k mod 4 = 2
    //  lane 3 -> k = 3, 7 , 11, ... -> k mod 4 = 3
    //
    // Each lane therefore has a compile-time FFT_ID.
    //
    // Each phase_corrector_stream also performs the fixed-point conversion that the old CMULT1 used to provide:
    // 16,13 -> 16,15
    // -------------------------------------------------------------------------

    generate
        for (genvar lane = 0; lane < 4; lane++) begin : GEN_PHASE_CORRECTOR
            phase_corrector_stream #(
                .NB_DATA          (NB_DATA        ),
                .NBF_IN           (NBF_IN         ),
                .NBF_OUT          (NBF_OUT        ),
                .FFT_ID           (lane           ),
                .SATURATE_NEG     (SATURATE_NEG   ),
                .SATURATE_RESIZE  (SATURATE_RESIZE)) 
            u_phase_corrector (
                .clock             (clock                ),
                .i_reset           (i_reset              ),
                .i_enable          (i_enable             ),

                .i_s_axis_tdata    (i_s_axis_tdata[lane] ),
                .i_s_axis_tvalid   (i_s_axis_tvalid[lane]),
                .i_s_axis_tlast    (i_s_axis_tlast[lane] ),
                .o_s_axis_tready   (o_s_axis_tready[lane]),

                .o_m_axis_tdata    (o_m_axis_tdata[lane] ),
                .o_m_axis_tvalid   (o_m_axis_tvalid[lane]),
                .o_m_axis_tlast    (o_m_axis_tlast[lane] ),
                .i_m_axis_tready   (i_m_axis_tready[lane]));
        end
    endgenerate

endmodule
