module pm_input_window #(
    parameter NP          = 64,
              NB_SAMPLES  = 12,
              NBF_SAMPLES = 11,
              NB_WINDOWS  = 8,
              NBF_WINDOWS = 7,
              NB_OUTPUT   = 16,
              NBF_OUTPUT  = 15
) (
    input  logic                             clock,
    input  logic                             i_reset,
    input  logic                             i_enable,
    input  logic        [1              : 0] i_window_sel, // added
    input  logic signed [NB_SAMPLES - 1 : 0] i_x,
    output logic signed [NB_OUTPUT  - 1 : 0] o_product [NP], 
    output logic                             o_valid
);

localparam WIN_COEFF = NP/2;
localparam L         = NP/4;                                                  //! decimation parameter
localparam NB_PROD   = NB_SAMPLES  + NB_WINDOWS;                              //! number of bits of product signal (r_prod)
localparam NBF_PROD  = NBF_SAMPLES + NBF_WINDOWS;                             //! number of frac bits of product signal (r_prod)
localparam NBI_TRUNC = (NB_PROD - NBF_PROD) - ((NB_OUTPUT - NBF_OUTPUT) - 1); //! bits to analize in order to trunc output 
localparam NB_N      = $clog2(NP);                                            //! counter limit bits
localparam NB_L      = $clog2(L) ;                                            //! upd counter limit bits

// signals
logic signed [NB_SAMPLES - 1 : 0] r_shiftreg [NP];
logic signed [NB_WINDOWS - 1 : 0] w_window_coeff [WIN_COEFF];
logic signed [NB_PROD    - 1 : 0] w_prod [NP];
logic signed [NB_OUTPUT  - 1 : 0] w_product [NP];
logic signed [NB_OUTPUT  - 1 : 0] r_product [NP];
logic        [NB_N           : 0] r_counter_limit;
logic        [NB_N           : 0] r_counter;
logic                             w_valid, r_valid;
logic                             r_flag_o_valid;

//`include "window_coeff.v"
always_comb begin : window_coeff_mux
    case (i_window_sel)
        2'b00 : begin
            // hamming
            w_window_coeff[ 0] = 8'b00001010;
            w_window_coeff[ 1] = 8'b00001011;
            w_window_coeff[ 2] = 8'b00001111;
            w_window_coeff[ 3] = 8'b00010100;
            w_window_coeff[ 4] = 8'b00011100;
            w_window_coeff[ 5] = 8'b00100101;
            w_window_coeff[ 6] = 8'b00110000;
            w_window_coeff[ 7] = 8'b00111100;
            w_window_coeff[ 8] = 8'b01001000;
            w_window_coeff[ 9] = 8'b01010011;
            w_window_coeff[10] = 8'b01011111;
            w_window_coeff[11] = 8'b01101001;
            w_window_coeff[12] = 8'b01110001;
            w_window_coeff[13] = 8'b01111000;
            w_window_coeff[14] = 8'b01111101;
            w_window_coeff[15] = 8'b01111111;
        end
        2'b01 : begin
            // blackman
            w_window_coeff[0 ] = 8'b00000000;
            w_window_coeff[1 ] = 8'b00000000;
            w_window_coeff[2 ] = 8'b00000010;
            w_window_coeff[3 ] = 8'b00000101;
            w_window_coeff[4 ] = 8'b00001001;
            w_window_coeff[5 ] = 8'b00001111;
            w_window_coeff[6 ] = 8'b00011000;
            w_window_coeff[7 ] = 8'b00100010;
            w_window_coeff[8 ] = 8'b00101111;
            w_window_coeff[9 ] = 8'b00111101;
            w_window_coeff[10] = 8'b01001100;
            w_window_coeff[11] = 8'b01011010;
            w_window_coeff[12] = 8'b01101000;
            w_window_coeff[13] = 8'b01110011;
            w_window_coeff[14] = 8'b01111011;
            w_window_coeff[15] = 8'b01111111;
        end 
        2'b10 : begin
            // rectangular
            w_window_coeff[0 ] = 8'b01111111;
            w_window_coeff[1 ] = 8'b01111111;
            w_window_coeff[2 ] = 8'b01111111;
            w_window_coeff[3 ] = 8'b01111111;
            w_window_coeff[4 ] = 8'b01111111;
            w_window_coeff[5 ] = 8'b01111111;
            w_window_coeff[6 ] = 8'b01111111;
            w_window_coeff[7 ] = 8'b01111111;
            w_window_coeff[8 ] = 8'b01111111;
            w_window_coeff[9 ] = 8'b01111111;
            w_window_coeff[10] = 8'b01111111;
            w_window_coeff[11] = 8'b01111111;
            w_window_coeff[12] = 8'b01111111;
            w_window_coeff[13] = 8'b01111111;
            w_window_coeff[14] = 8'b01111111;
            w_window_coeff[15] = 8'b01111111;
        end  
        default: begin
            // hamming
            w_window_coeff[ 0] = 8'b00001010;
            w_window_coeff[ 1] = 8'b00001011;
            w_window_coeff[ 2] = 8'b00001111;
            w_window_coeff[ 3] = 8'b00010100;
            w_window_coeff[ 4] = 8'b00011100;
            w_window_coeff[ 5] = 8'b00100101;
            w_window_coeff[ 6] = 8'b00110000;
            w_window_coeff[ 7] = 8'b00111100;
            w_window_coeff[ 8] = 8'b01001000;
            w_window_coeff[ 9] = 8'b01010011;
            w_window_coeff[10] = 8'b01011111;
            w_window_coeff[11] = 8'b01101001;
            w_window_coeff[12] = 8'b01110001;
            w_window_coeff[13] = 8'b01111000;
            w_window_coeff[14] = 8'b01111101;
            w_window_coeff[15] = 8'b01111111;
        end
    endcase
end

always_ff @(posedge clock) begin : input_samples_shift_reg
    if (i_reset) begin
        for (int ptr_reset = 0 ; ptr_reset < NP ; ptr_reset = ptr_reset + 1) begin
            r_shiftreg[ptr_reset] <= {NB_SAMPLES{1'b0}};
        end 
    end
    else if (i_enable) begin
        for (int ptr_en = 0 ; ptr_en < (NP - 1) ; ptr_en = ptr_en + 1) begin
            r_shiftreg[ptr_en] <= r_shiftreg[ptr_en + 1];     
        end 
        r_shiftreg[NP - 1] <= i_x;  
    end
    else begin
        for (int ptr_sr = 0 ; ptr_sr < NP ; ptr_sr = ptr_sr + 1) begin
            r_shiftreg[ptr_sr] <= r_shiftreg[ptr_sr];
        end  
    end
end

always_ff @(posedge clock) begin : flag_o_valid_control
    if (i_reset) r_flag_o_valid  <= 1'b0;
    else if (i_enable) begin
        if (r_counter == r_counter_limit - 1) r_flag_o_valid  <= 1'b1;
        else r_flag_o_valid  <= 1'b0;
    end
    else r_flag_o_valid  <= r_flag_o_valid;
end

always_ff @(posedge clock) begin : input_samples_counter
    if (i_reset) begin
        r_counter       <= {{NB_N+1}{1'b0}};
        r_counter_limit <= {1'b1,{NB_N{1'b0}}}; 
    end
    else if (i_enable) begin
        r_counter <= r_counter + 1'b1;
        if (r_counter == r_counter_limit) begin
            r_counter_limit <= {{(NB_N + 1 - NB_L){1'b0}},{NB_L{1'b1}}};
            r_counter       <= {{NB_N + 1}{1'b0}};
        end
        else begin
            r_counter_limit <= r_counter_limit;
        end
    end
    else begin
        r_counter       <= r_counter;
        r_counter_limit <= r_counter_limit;
    end
end

always_comb begin : parallel_product
    w_valid = 1'b1 & r_flag_o_valid;
    if (r_flag_o_valid) begin
        for (int ptr_prod = 0 ; ptr_prod < (NP / 2) ; ptr_prod = ptr_prod + 1) begin                               
            w_prod[ptr_prod]          = w_window_coeff[ptr_prod] * r_shiftreg[ptr_prod];    
            w_prod[NP - 1 - ptr_prod] = w_window_coeff[ptr_prod] * r_shiftreg[ptr_prod + NP - (2*ptr_prod + 1)];
        end
    end
    else begin // to avoid latch infer
        for (int ptr_prod = 0 ; ptr_prod < (NP / 2) ; ptr_prod = ptr_prod + 1) begin                                  
            w_prod[ptr_prod]          = '0;    
            w_prod[NP - 1 - ptr_prod] = '0;
        end
    end
end

generate
    genvar i;
    for (i = 0; i < NP ; i = i + 1) begin
        assign w_product[i] = (~|w_prod[i][NB_PROD - 1 -: NBI_TRUNC] || &w_prod[i][NB_PROD - 1 -: NBI_TRUNC]) ?  w_prod[i][NB_PROD - NBI_TRUNC -: NB_OUTPUT] : (w_prod[i][NB_PROD - 1]) ? {1'b1,{NB_OUTPUT - 1{1'b0}}} : {1'b0,{NB_OUTPUT - 1{1'b1}}};
    end
endgenerate

always_ff @(posedge clock) begin : register_output
    r_valid <= w_valid;
    for (int ptr_out = 0 ; ptr_out < NP ; ptr_out = ptr_out + 1) begin                                  
        r_product[ptr_out] <= w_product[ptr_out];    
    end
end

assign o_valid   = r_valid; 
assign o_product = r_product;

endmodule