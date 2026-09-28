module phase_corrector_stream #(
    parameter integer NB_DATA          = 16,
    parameter integer NBF_IN           = 13,  // FFT1 input format: 16,13
    parameter integer NBF_OUT          = 15,  // stored/CMULT2 format: 16,15
    parameter integer FFT_ID           = 0,   // 0..3 -> k mod 4
    parameter bit     SATURATE_NEG     = 1'b1,
    parameter bit     SATURATE_RESIZE  = 1'b1
) (
    input  logic                     clock,
    input  logic                     i_reset,
    input  logic                     i_enable,

    // AXI-Stream input from one FFT1 core. Complex format: {imag, real}.
    // Numerical format expected by the current design: signed Q(16,13).
    input  logic [2*NB_DATA - 1 : 0] i_s_axis_tdata,
    input  logic                     i_s_axis_tvalid,
    input  logic                     i_s_axis_tlast,
    output logic                     o_s_axis_tready,

    // AXI-Stream phase-corrected output.
    // Numerical format produced by the current design: signed Q(16,15).
    output logic [2*NB_DATA - 1 : 0] o_m_axis_tdata,
    output logic                     o_m_axis_tvalid,
    output logic                     o_m_axis_tlast,
    input  logic                     i_m_axis_tready
);

    // -------------------------------------------------------------------------
    // Phase correction
    // For L = NP/4: exp(-j*pi/2 * k * i) can only be: +1, -j, -1, +j and therefore no complex multiplier is required.
    //
    // In the original architecture:
    //
    //     FFT1 output / phase-corrector input : 16,13
    //     old CMULT1 phase-corrector output   : 16,15
    //
    // Removing CMULT1 also removed that binary-point conversion, this module now restores it explicitly after the swap/sign operation.
    // 16,13 -> 16,15 which corresponds to a raw left shift by two bits, with saturation.
    // -------------------------------------------------------------------------

    localparam integer FRAC_SHIFT = NBF_OUT - NBF_IN;
    localparam integer EXT_W      = NB_DATA + FRAC_SHIFT;

    logic [1 : 0] r_i_mod4;
    logic [1 : 0] w_phase;

    logic signed [NB_DATA - 1 : 0] w_in_re;
    logic signed [NB_DATA - 1 : 0] w_in_im;

    // Phase-corrected values still expressed in Q(16,NBF_IN).
    logic signed [NB_DATA - 1 : 0] w_corr_re;
    logic signed [NB_DATA - 1 : 0] w_corr_im;

    // Extended/scaled values used for Q-format conversion.
    logic signed [EXT_W - 1 : 0] w_corr_re_ext;
    logic signed [EXT_W - 1 : 0] w_corr_im_ext;
    logic signed [EXT_W - 1 : 0] w_scaled_re;
    logic signed [EXT_W - 1 : 0] w_scaled_im;

    // Final Q(16,NBF_OUT) samples.
    logic signed [NB_DATA - 1 : 0] w_out_re;
    logic signed [NB_DATA - 1 : 0] w_out_im;

    logic [2*NB_DATA - 1 : 0] r_tdata;
    logic                     r_tvalid;
    logic                     r_tlast;

    // One-stage elastic pipeline.
    assign o_s_axis_tready = i_enable && (!r_tvalid || i_m_axis_tready);

    assign w_in_re = $signed(i_s_axis_tdata[NB_DATA-1:0]);
    assign w_in_im = $signed(i_s_axis_tdata[2*NB_DATA-1:NB_DATA]);

    // -------------------------------------------------------------------------
    // Saturating two's-complement negation.
    // This operates BEFORE the binary-point conversion, so the numerical range is the original Q(16,NBF_IN) range.
    // -------------------------------------------------------------------------
    function automatic logic signed [NB_DATA - 1 : 0] neg_value(
        input logic signed [NB_DATA - 1 : 0] value
    );
        logic signed [NB_DATA - 1 : 0] min_negative;
        logic signed [NB_DATA - 1 : 0] max_positive;
        begin
            min_negative = {1'b1, {(NB_DATA-1){1'b0}}};
            max_positive = {1'b0, {(NB_DATA-1){1'b1}}};

            if (SATURATE_NEG && (value == min_negative)) neg_value = max_positive;
            else                                         neg_value = -value;
        end
    endfunction

    // -------------------------------------------------------------------------
    // Saturating fixed-point conversion.
    // For 16,13 -> 16,15: raw_out = raw_in << 2 and the widened intermediate prevents wrap-around before saturation.
    // Values outside the Q1.15 range saturate instead of wrapping.
    // -------------------------------------------------------------------------
    function automatic logic signed [NB_DATA - 1 : 0] resize_saturate(
        input logic signed [EXT_W - 1 : 0] value
    );
        logic signed [EXT_W - 1 : 0] max_ext;
        logic signed [EXT_W - 1 : 0] min_ext;
        begin
            max_ext = $signed({1'b0, {(NB_DATA-1){1'b1}}});
            min_ext = $signed({1'b1, {(NB_DATA-1){1'b0}}});

            if      (SATURATE_RESIZE && (value > max_ext)) resize_saturate = {1'b0, {(NB_DATA-1){1'b1}}};
            else if (SATURATE_RESIZE && (value < min_ext)) resize_saturate = {1'b1, {(NB_DATA-1){1'b0}}};
            else                                           resize_saturate = value[NB_DATA-1:0];
        end
    endfunction

    // -------------------------------------------------------------------------
    // Phase = (FFT_ID * i) mod 4
    //   00 -> +1
    //   01 -> -j
    //   10 -> -1
    //   11 -> +j
    // -------------------------------------------------------------------------
    always_comb begin : phase_select
        case (FFT_ID % 4)
            0 : w_phase = 2'b00;
            1 : w_phase = r_i_mod4;
            2 : w_phase = {r_i_mod4[0], 1'b0};
            3 : w_phase = {(r_i_mod4[1] ^ r_i_mod4[0]), r_i_mod4[0]};
            default: w_phase = 2'b00;
        endcase
    end

    // -------------------------------------------------------------------------
    // Complex multiplication by {+1, -j, -1, +j}, no DSP is required.
    // -------------------------------------------------------------------------
    always_comb begin : phase_correction
        case (w_phase)
            2'b00: begin // +1 : a + jb
                w_corr_re =  w_in_re;
                w_corr_im =  w_in_im;
            end
            2'b01: begin // -j : b - ja
                w_corr_re =  w_in_im;
                w_corr_im =  neg_value(w_in_re);
            end
            2'b10: begin // -1 : -a - jb
                w_corr_re =  neg_value(w_in_re);
                w_corr_im =  neg_value(w_in_im);
            end
            2'b11: begin // +j : -b + ja
                w_corr_re =  neg_value(w_in_im);
                w_corr_im =  w_in_re;
            end
            default: begin
                w_corr_re = w_in_re;
                w_corr_im = w_in_im;
            end
        endcase
    end

    // -------------------------------------------------------------------------
    // Restore the fixed-point conversion previously performed by CMULT1.
    //
    // Q(16,13) -> Q(16,15) is a constant left shift by 2, this is wiring/shift/saturation logic only.
    // -------------------------------------------------------------------------
    always_comb begin : fixed_point_resize
        w_corr_re_ext = {{FRAC_SHIFT{w_corr_re[NB_DATA-1]}}, w_corr_re};
        w_corr_im_ext = {{FRAC_SHIFT{w_corr_im[NB_DATA-1]}}, w_corr_im};

        w_scaled_re = w_corr_re_ext <<< FRAC_SHIFT;
        w_scaled_im = w_corr_im_ext <<< FRAC_SHIFT;

        w_out_re = resize_saturate(w_scaled_re);
        w_out_im = resize_saturate(w_scaled_im);
    end

    // -------------------------------------------------------------------------
    // Output pipeline register + FFT-bin position counter.
    // r_i_mod4 advances only on a successful input transfer, preserving phase alignment under backpressure.
    // -------------------------------------------------------------------------
    always_ff @(posedge clock) begin : output_pipeline
        if (i_reset) begin
            r_i_mod4 <= '0;
            r_tdata  <= '0;
            r_tvalid <= '0;
            r_tlast  <= '0;
        end
        else if (i_enable) begin
            if (o_s_axis_tready) begin
                r_tvalid <= i_s_axis_tvalid;
                if (i_s_axis_tvalid) begin
                    // Store/output Q(16,NBF_OUT), not the original Q13 value.
                    r_tdata <= {w_out_im, w_out_re};
                    r_tlast <= i_s_axis_tlast;
                    if (i_s_axis_tlast) r_i_mod4 <= 2'b00;
                    else                r_i_mod4 <= r_i_mod4 + 2'b01;
                end
                else r_tlast <= 1'b0;
            end
        end
    end

    assign o_m_axis_tdata  = r_tdata;
    assign o_m_axis_tvalid = r_tvalid && i_enable;
    assign o_m_axis_tlast  = r_tlast && r_tvalid && i_enable;

endmodule
