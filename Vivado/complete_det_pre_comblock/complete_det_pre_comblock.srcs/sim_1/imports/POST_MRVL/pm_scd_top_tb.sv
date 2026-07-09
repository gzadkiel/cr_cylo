module pm_scd_top_tb;

    // Parameters
    localparam  NB_DATA = 16;
    localparam  NBF_DATA = 15;
    localparam  NB_WIN = 8;
    localparam  NBF_WIN = 7;
    localparam  NP_SAMPLES = 8;
    localparam  P_FRAMES = 8;
    localparam  NB_EXP = 16;
    localparam  NB_FFT2_O = 32;

    // Derived
    localparam CLK_HALF   = 5;    // 100 MHz

    //Ports
    reg                   clock;
    reg                   i_reset;
    reg                   i_enable;
    reg [NB_DATA - 1 : 0] i_data_sample_re;
    reg [NB_DATA - 1 : 0] i_data_sample_im;
    reg                   i_fft2_axis_data_tready;
    wire [NB_FFT2_O - 1 : 0] o_fft2_axis_data_tdata;
    wire                     o_fft2_axis_data_tvalid;
    wire                     o_fft2_axis_data_tlast;
    wire                     o_estimate_done;

    reg [15 : 0] in1_mem [0 : 4095];  // real_memory
    reg [15 : 0] in2_mem [0 : 4095];  // imag_memory

    pm_scd_top # (
        .NB_DATA    (NB_DATA),
        .NBF_DATA   (NBF_DATA),
        .NB_WIN     (NB_WIN),
        .NBF_WIN    (NBF_WIN),
        .NP_SAMPLES (NP_SAMPLES),
        .P_FRAMES   (P_FRAMES),
        .NB_EXP     (NB_EXP),
        .NB_FFT2_O  (NB_FFT2_O))
    pm_scd_top_inst (
        .clock                   (clock),
        .i_reset                 (i_reset),
        .i_enable                (i_enable),
        .i_data_sample_re        (i_data_sample_re),
        .i_data_sample_im        (i_data_sample_im),
        .i_fft2_axis_data_tready (i_fft2_axis_data_tready),
        .o_fft2_axis_data_tdata  (o_fft2_axis_data_tdata),
        .o_fft2_axis_data_tvalid (o_fft2_axis_data_tvalid),
        .o_fft2_axis_data_tlast  (o_fft2_axis_data_tlast),
        .o_estimate_done         (o_estimate_done));

    // Clock generation
    initial clock = 1'b0;
    always #(CLK_HALF) clock = ~clock;

    initial begin : tb_main

        $readmemb("in_real.mem", in1_mem);
        $readmemb("in_imag.mem", in2_mem);
        
        i_enable = 1'b0;
        i_reset  = 1'b1;
        i_fft2_axis_data_tready = 1'b1;
        
        #17.5 i_reset = 1'b0; 
        #5 i_enable = 1'b1; 

        for (int i = 0; i < 2048; i = i + 1) begin
            @(posedge clock);
                i_data_sample_re = in1_mem[i];
                i_data_sample_im = in2_mem[i];
        end

        $finish;
    end

endmodule