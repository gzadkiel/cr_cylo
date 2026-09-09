// delta alpha = 1/N cyclic freq res
// cyclic freq = fk - fl ------> a_i
// spectral freq = (fk + fl)/2 -> f_j

module detection_compare #(
    parameter NB_DATA   = 16,  //! Data width
              NB_THRES  = 33,  //! Threshold width
              NP        = 32,  //! Number of data samples
              P_MAX     = 128, //! Number of data blocks
              NB_DETECT = 16 
) (
    input  logic                            clock,                     //! System clock
    input  logic                            i_reset,                   //! Active-high synchronous reset
    input  logic                            i_enable,                  //! Module enable signal
    input  logic                            i_scd_mode,
    input  logic        [$clog2(P_MAX) : 0] i_p_frames,
    input  logic signed [NB_THRES  - 1 : 0] i_threshold,               //! Comparison threshold input
    input  logic        [2*NB_DATA - 1 : 0] i_fft2_m_axis_data_tdata,  //! Output data from second-stage FFT
    input  logic        [7             : 0] i_fft2_m_axis_data_tuser,  // added -- INDICE PARA LA SALIDA !!!
    input  logic                            i_fft2_m_axis_data_tvalid, //! Asserted by the FFT2 Core when output data is valid
    input  logic                            i_fft2_m_axis_data_tlast,  //! Asserted by the FFT2 Core on the last sample of the output frame
    output logic                            o_m_fft2_axis_data_tready, //! Downstream FFT2 ready signal
    output logic        [NB_DETECT - 1 : 0] o_detect_counter           //! Amount of detections
);

localparam NB_MOD_QUAD = 2*(NB_DATA) + 1; //! Number of bits of squared modulus

logic signed [NB_MOD_QUAD   - 1 : 0] r_comparison;     //! Comparison value
logic        [NB_DETECT     - 1 : 0] r_detect_counter; //! Detection counter

// debuggg
logic signed [31 : 0] w_fft2_im_part;
logic signed [31 : 0] w_fft2_re_part;
logic signed [63 : 0] w_square_prod_im;
logic signed [63 : 0] w_square_prod_re;

// added to correct previous error:
// centrado en q = 0, tengo q tomar PL/NP2 para cada lado, esto es equiv a tomar P/8 para cada lado
// como esta en natural order a la salida, tomo del 0 al 7 y del ultimo hasta ultimo -7
logic [$clog2(P_MAX) - 1 : 0] q_max;
assign q_max = i_p_frames >> 3; 

always_comb begin : compare_value_calc
    if (i_enable && i_fft2_m_axis_data_tvalid && o_m_fft2_axis_data_tready) begin
        w_fft2_im_part = i_fft2_m_axis_data_tdata[2*NB_DATA - 1 : NB_DATA];
        w_fft2_re_part = i_fft2_m_axis_data_tdata[NB_DATA - 1 : 0];
        w_square_prod_im = w_fft2_im_part * w_fft2_im_part;
        w_square_prod_re = w_fft2_re_part * w_fft2_re_part;
        if (i_scd_mode) begin // scd_mode == 1, scd_reduced
            if ( (i_fft2_m_axis_data_tuser < q_max) || (i_fft2_m_axis_data_tuser > (i_p_frames - q_max)) ) r_comparison = w_square_prod_im + w_square_prod_re;
            else r_comparison = '0;
        end
        else begin // scd_mode == 0, scd_full         
            r_comparison = w_square_prod_im + w_square_prod_re;
        end
    end
    else r_comparison = '0;
end

always_ff @(posedge clock) begin : detection_counter
    if (i_reset) r_detect_counter <= '0;
    else if (i_enable) begin
        if (r_comparison > i_threshold) r_detect_counter <= r_detect_counter + 1'b1;
    end
    else r_detect_counter <= r_detect_counter;
end

assign o_m_fft2_axis_data_tready = 1'b1;
assign o_detect_counter          = r_detect_counter;
 
endmodule