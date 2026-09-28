module fft2_config_parallel #(
    parameter integer N_ENGINES        = 4,
    parameter integer P_MIN            = 8,
    parameter integer P_MAX            = 128,
    parameter integer AXI_CONFIG_WIDTH = 17
) (
    input  logic                            clock,
    input  logic                            i_reset,
    input  logic                            i_clear,
    input  logic                            i_start,
    input  logic [$clog2(P_MAX)        : 0] i_p_frames,

    input  logic                            i_s_axis_config_tready [N_ENGINES],
    output logic                            o_s_axis_config_tvalid [N_ENGINES],
    output logic [AXI_CONFIG_WIDTH - 1 : 0] o_s_axis_config_tdata,

    output logic                            o_config_done
);

    logic [4 : 0] NFFT;
    logic [7 : 0] SCALE_SCH;
    logic         FWD_INV;
    logic         r_done [N_ENGINES];
    logic         r_active;
    logic         w_all_done;

    // Runtime FFT2 sizes supported by the current Xilinx FFT configuration.
    always_comb begin
        case (i_p_frames)
            128 : begin 
                NFFT      = 5'b00111; 
                SCALE_SCH = 8'b01011011; 
            end
             64 : begin 
                NFFT      = 5'b00110; 
                SCALE_SCH = 8'b00011011; 
            end
             32 : begin 
                NFFT      = 5'b00101; 
                SCALE_SCH = 8'b00001011; 
            end
             16 : begin 
                NFFT      = 5'b00100; 
                SCALE_SCH = 8'b00000111; 
            end
              8 : begin 
                NFFT      = 5'b00011; 
                SCALE_SCH = 8'b00000011; 
            end
            default: begin
                NFFT      = 5'b00111;
                SCALE_SCH = 8'b01011011;
            end
        endcase
    end

    assign FWD_INV = 1'b1;
    assign o_s_axis_config_tdata = {SCALE_SCH, FWD_INV, 3'b000, NFFT};

    always_comb begin
        w_all_done = 1'b1;
        for (int eng = 0; eng < N_ENGINES; eng++) begin
            o_s_axis_config_tvalid[eng] = r_active && !r_done[eng];
            if (!r_done[eng]) w_all_done = 1'b0;
        end
    end

    assign o_config_done = w_all_done;

    always_ff @(posedge clock) begin
        if (i_reset || i_clear) begin
            r_active <= 1'b0;
            for (int eng = 0; eng < N_ENGINES; eng++)
                r_done[eng] <= 1'b0;
        end
        else begin
            if (i_start && !r_active) begin
                r_active <= 1'b1;
                for (int eng = 0; eng < N_ENGINES; eng++)
                    r_done[eng] <= 1'b0;
            end
            else if (r_active) begin
                for (int eng = 0; eng < N_ENGINES; eng++) begin
                    if (!r_done[eng] && i_s_axis_config_tready[eng]) r_done[eng] <= 1'b1;
                end
                if (w_all_done) r_active <= 1'b0;
            end
        end
    end

endmodule
