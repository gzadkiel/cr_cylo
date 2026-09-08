module pm_top_mux_fsmd #(
    parameter NB_SAMPLE_DATA    = 12,
    parameter N_NOISE_SAMPLES   = 256,
    parameter N_DESIRED_SAMPLES = 1024
) (
    input logic clock,
    input logic i_reset,
    input logic i_enable,     

    // added to provide modular design -----------------------------
    input logic [$clog2(N_DESIRED_SAMPLES) : 0] i_data_size,
    input logic [$clog2(N_DESIRED_SAMPLES) : 0] i_tot_data_size,
    input logic [$clog2(N_NOISE_SAMPLES)   : 0] i_noise_size,

    // added to provide better communication with PS ---------------
    input logic i_noise_data_valid,  //! Valid signal to proceed with noise power estimation
    input logic i_signal_data_valid, //! Valid signal to proceed with SCD estimation
    // -------------------------------------------------------------

    input  logic signed [NB_SAMPLE_DATA - 1 : 0] i_data_sample_re,
    input  logic signed [NB_SAMPLE_DATA - 1 : 0] i_data_sample_im,
    output logic signed [NB_SAMPLE_DATA - 1 : 0] o_data_sample_re,
    output logic signed [NB_SAMPLE_DATA - 1 : 0] o_data_sample_im,

    input  logic i_scd_estimate_done,
    output logic o_threshold_estimate_en,
    output logic o_scd_estimate_en,
    output logic o_compare_detect_en,
    output logic o_det_counter_reset,
    
    // added to reset estimator block between runs -----------------
    output logic o_scd_reset
    // -------------------------------------------------------------
);

typedef enum {INIT_ENA,
              EST_NOISE_WAIT_VALID,
              EST_NOISE,
              INPUT_SCD_WAIT_VALID,
              INPUT_SCD,
              ESTIMATE_SCD,
              RESET_DETECT,
              RESET_DETECT_EXTRA_CLOCK} state_type;

state_type state_reg, state_next;

localparam NB_NOISE_CNT = $clog2(N_NOISE_SAMPLES);
localparam NB_SAMPL_CNT = $clog2(N_DESIRED_SAMPLES);

// added to reset scd estimator between runs -----------------------
logic w_scd_reset;
assign w_scd_reset = ((state_reg == RESET_DETECT) || (state_reg == RESET_DETECT_EXTRA_CLOCK))  ? '1 : '0;
assign o_scd_reset = w_scd_reset;
// -----------------------------------------------------------------

logic w_threshold_estimate_en, r_threshold_estimate_en;
logic w_scd_estimate_en, r_scd_estimate_en;
logic w_compare_detect_en, r_compare_detect_en;
logic w_scd_input_sel;

logic [NB_NOISE_CNT : 0] r_noise_sample_counter_reg, w_noise_sample_counter_next;
logic w_noise_sample_counter_inc, w_noise_sample_counter_out, w_noise_sample_counter_clr;

logic [NB_SAMPL_CNT : 0] r_scd_sample_counter_reg, w_scd_sample_counter_next;
logic w_scd_sample_counter_inc, w_scd_sample_counter_out1, w_scd_sample_counter_out2, w_scd_sample_counter_clr;

logic w_det_counter_reset, r_det_counter_reset;

logic [NB_SAMPLE_DATA - 1 : 0] w_input_sample_re, r_input_sample_re; 
logic [NB_SAMPLE_DATA - 1 : 0] w_input_sample_im, r_input_sample_im;

assign w_noise_sample_counter_next = (w_noise_sample_counter_clr) ? '0 : (w_noise_sample_counter_inc) ? r_noise_sample_counter_reg + 1'b1 : r_noise_sample_counter_reg;
assign w_noise_sample_counter_out  = (r_noise_sample_counter_reg == i_noise_size + 1) ? '1 : '0;

assign w_scd_sample_counter_next = (w_scd_sample_counter_clr) ? '0 : (w_scd_sample_counter_inc) ? r_scd_sample_counter_reg + 1'b1 : r_scd_sample_counter_reg;
assign w_scd_sample_counter_out1 = (r_scd_sample_counter_reg == i_data_size - 1) ? '1 : '0;
assign w_scd_sample_counter_out2 = (r_scd_sample_counter_reg == i_tot_data_size - 1) ? '1 : '0; 

always_ff @(posedge clock) begin : regs_management 
    if (i_reset) begin
        r_noise_sample_counter_reg <= '0; 
        r_scd_sample_counter_reg   <= '0;
        state_reg                  <= INIT_ENA;
    end
    else if (i_enable) begin
        r_noise_sample_counter_reg <= w_noise_sample_counter_next; 
        r_scd_sample_counter_reg   <= w_scd_sample_counter_next;
        state_reg                  <= state_next;
    end
    else begin
        r_noise_sample_counter_reg <= r_noise_sample_counter_reg; 
        r_scd_sample_counter_reg   <= r_scd_sample_counter_reg;
        state_reg                  <= state_reg; 
    end
end

always_comb begin : input_sample_mux
    unique case (w_scd_input_sel)
        1'b0 : begin
            w_input_sample_re = i_data_sample_re;
            w_input_sample_im = i_data_sample_im;
        end 
        1'b1 : begin
            w_input_sample_re = 1'b0;
            w_input_sample_im = 1'b0;
        end 
    endcase
end

always_comb begin : control_fsmd
    // added intial values
    state_next                 = INIT_ENA;
    w_scd_estimate_en          = '0;
    w_compare_detect_en        = '0;
    w_scd_input_sel            = '0;
    w_noise_sample_counter_inc = '0;
    w_noise_sample_counter_clr = '0;
    w_scd_sample_counter_inc   = '0;
    w_scd_sample_counter_clr   = '0;
    w_det_counter_reset        = '0;
    w_threshold_estimate_en    = '0;

    case (state_reg)
        INIT_ENA : begin
            // added intial values
            w_scd_estimate_en   = '0;
            w_compare_detect_en = '0;
            w_scd_input_sel     = '0;
            
            w_noise_sample_counter_inc = '0;
            w_noise_sample_counter_clr = '1;

            w_scd_sample_counter_inc = '0;
            w_scd_sample_counter_clr = '1;

            w_det_counter_reset = '0;
            // -------------------

            w_threshold_estimate_en = '0;
            state_next              = EST_NOISE_WAIT_VALID;
        end 
        EST_NOISE_WAIT_VALID : begin
            if (i_noise_data_valid) begin
                w_threshold_estimate_en = '1;
                state_next              = EST_NOISE;
            end
            else state_next = EST_NOISE_WAIT_VALID;
        end
        EST_NOISE : begin
            // disable clears
            w_noise_sample_counter_clr = '0;
            w_scd_sample_counter_clr   = '0;
            w_threshold_estimate_en    = '1; /// !!
            // --------------
            
            w_noise_sample_counter_inc = '1;
            if (w_noise_sample_counter_out) begin
                w_noise_sample_counter_inc = '0;
                w_noise_sample_counter_clr = '1;
                w_threshold_estimate_en    = '0;
                w_scd_estimate_en          = '0;
                w_compare_detect_en        = '0;
                state_next                 = INPUT_SCD_WAIT_VALID;
            end
            else begin
                w_noise_sample_counter_clr = '0;
                state_next                 = EST_NOISE;
            end
        end
        INPUT_SCD_WAIT_VALID : begin
            if (i_signal_data_valid) begin
                w_det_counter_reset = '1; 
                w_scd_estimate_en   = '1;
                w_compare_detect_en = '1;
                state_next          = INPUT_SCD;
            end
            else state_next = INPUT_SCD_WAIT_VALID;
        end
        INPUT_SCD : begin
            w_noise_sample_counter_clr = '0; // added for better sig
            w_scd_estimate_en          = '1; // !! added for better sig
            w_compare_detect_en        = '1; // !! added for better sig
            w_scd_sample_counter_inc   = '1;
            if (w_scd_sample_counter_out1) w_scd_input_sel = '1;
            else w_scd_input_sel = w_scd_input_sel;
            if (w_scd_sample_counter_out2) begin
                w_scd_sample_counter_inc = '0;
                w_scd_sample_counter_clr = '1;
                state_next               = ESTIMATE_SCD;
            end
            else begin
                w_scd_sample_counter_inc = '1;
                w_scd_sample_counter_clr = '0;
                state_next               = INPUT_SCD;
            end
        end
        ESTIMATE_SCD : begin
            w_scd_estimate_en        = '1; // added
            w_scd_sample_counter_clr = '0; // added
            w_compare_detect_en      = '1; // added
        
            if (i_scd_estimate_done) begin
                state_next          = RESET_DETECT;
            end
            else begin
                w_det_counter_reset = '0;
                state_next          = ESTIMATE_SCD;
            end
        end
        RESET_DETECT : begin
            w_scd_input_sel     = '0;
            w_det_counter_reset = '1;
            state_next          = RESET_DETECT_EXTRA_CLOCK;
        end
        RESET_DETECT_EXTRA_CLOCK : begin
            w_scd_input_sel     = '0;
            w_det_counter_reset = '1;
            state_next          = INPUT_SCD_WAIT_VALID;
        end
    endcase
end

always_ff @(posedge clock) begin : registered_output
    r_input_sample_re <= w_input_sample_re;
    r_input_sample_im <= w_input_sample_im;

    r_threshold_estimate_en <= w_threshold_estimate_en;
    r_scd_estimate_en       <= w_scd_estimate_en;
    r_compare_detect_en     <= w_compare_detect_en;
    r_det_counter_reset     <= w_det_counter_reset;
end

assign o_data_sample_re        = r_input_sample_re; 
assign o_data_sample_im        = r_input_sample_im;

assign o_threshold_estimate_en = r_threshold_estimate_en;
assign o_scd_estimate_en       = r_scd_estimate_en;
assign o_compare_detect_en     = r_compare_detect_en;
assign o_det_counter_reset     = r_det_counter_reset;

    
endmodule