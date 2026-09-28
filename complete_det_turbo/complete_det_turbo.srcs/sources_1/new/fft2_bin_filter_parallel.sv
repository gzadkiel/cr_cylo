module fft2_bin_filter_parallel #(
    parameter integer N_ENGINES  = 4,
    parameter integer P_MIN      = 8,
    parameter integer P_MAX      = 128,
    parameter integer DATA_WIDTH = 64,
    parameter integer IDX_WIDTH  = $clog2(P_MAX),
    parameter integer Q_WIDTH    = $clog2(P_MAX) + 2
) (
    input  logic                             clock,
    input  logic                             i_reset,
    input  logic                             i_clear,
    input  logic [$clog2(P_MAX)         : 0] i_p_frames,

    // SCD comparison mode:
    //  1'b0 -> full mode:    propagate all P FFT2 bins
    //  1'b1 -> reduced mode: propagate only P/2 bins (P/4 on each side of q=0)
    input  logic                             i_scd_mode,

    input  logic        [DATA_WIDTH - 1 : 0] i_s_axis_tdata  [N_ENGINES],
    input  logic                             i_s_axis_tvalid [N_ENGINES],
    input  logic                             i_s_axis_tlast  [N_ENGINES],
    output logic                             o_s_axis_tready [N_ENGINES],

    output logic        [DATA_WIDTH - 1 : 0] o_m_axis_tdata  [N_ENGINES],
    output logic                             o_m_axis_tvalid [N_ENGINES],
    output logic                             o_m_axis_tlast  [N_ENGINES],
    input  logic                             i_m_axis_tready [N_ENGINES],

    output logic        [IDX_WIDTH  - 1 : 0] o_fft_bin_index [N_ENGINES],
    output logic signed [Q_WIDTH    - 1 : 0] o_q_index       [N_ENGINES]
);

    logic [IDX_WIDTH - 1 : 0] r_bin_index [N_ENGINES];
    logic [$clog2(P_MAX) : 0] w_q_max;

    // Reduced mode:
    // q_max = P/4 on EACH side of q=0, therefore P/2 bins are retained total.
    // Natural-order FFT output means no hardware fftshift is required:
    //
    //  keep 0 ... P/4-1
    //  keep 3P/4 ... P-1
    //
    // This is equivalent to retaining the central P/2 samples after fftshift.
    // Full mode bypasses this selection and propagates all P bins.
    
    assign w_q_max             = i_p_frames >> 2;

    always_comb begin : FILTER_COMB
        logic keep;
        logic signed [Q_WIDTH-1:0] signed_idx;
        logic signed [Q_WIDTH-1:0] signed_p;

        for (int eng = 0; eng < N_ENGINES; eng++) begin
            
            // Full mode reproduces the original "complete" comparison: every FFT2 bin is propagated to the detector.
            //
            // Reduced mode keeps the central P/2 bins after fftshift, represented in natural FFT order as:
            //  0 ... P/4-1
            //  3P/4 ... P-1

            keep = (!i_scd_mode || ((r_bin_index[eng] < w_q_max) || (r_bin_index[eng] >= (i_p_frames - w_q_max))));

            // Unused bins are consumed immediately, useful bins obey normal AXI backpressure from the following stage.
            // o_s_axis_tready[eng] = keep ? i_m_axis_tready[eng] : 1'b1; // non-realtime 
            o_s_axis_tready[eng] = 1'b1; // realtime 

            o_m_axis_tdata[eng]  = i_s_axis_tdata[eng];
            o_m_axis_tvalid[eng] = i_s_axis_tvalid[eng] && keep;
            o_m_axis_tlast[eng]  = i_s_axis_tlast[eng] && keep;
            o_fft_bin_index[eng] = r_bin_index[eng];

            signed_idx = $signed({1'b0, r_bin_index[eng]});
            signed_p   = $signed({1'b0, i_p_frames});

            // Signed FFT2-bin coordinate in Natural Order
            if (r_bin_index[eng] >= (i_p_frames >> 1)) o_q_index[eng] = signed_idx - signed_p;
            else                                       o_q_index[eng] = signed_idx;
        end
    end

    always_ff @(posedge clock) begin
        if (i_reset || i_clear) begin
            for (int eng = 0; eng < N_ENGINES; eng++)
                r_bin_index[eng] <= '0;
        end
        else begin
            for (int eng = 0; eng < N_ENGINES; eng++) begin
                if (i_s_axis_tvalid[eng] && o_s_axis_tready[eng]) begin
                    if (i_s_axis_tlast[eng]) r_bin_index[eng] <= '0;
                    else                     r_bin_index[eng] <= r_bin_index[eng] + 1'b1;
                end
            end
        end
    end

endmodule
