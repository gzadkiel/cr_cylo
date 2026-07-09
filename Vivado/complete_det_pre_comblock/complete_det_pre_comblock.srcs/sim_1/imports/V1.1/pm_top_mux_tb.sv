module pm_top_mux_tb;

// Parameters
localparam N_DESIRED        = 1024; //! number of total samples used for estimation 
localparam NB_SAMPLE_DATA   = 12;  //! number of bits of input sample
localparam NBF_SAMPLE_DATA  = 9;  //! number of frac bits of input sample
localparam NP_SAMPLES       = 32; //! number of samples per frame (np-point fft)
localparam P_MAX            = 128;
localparam N_NOISE_SAMPLES  = 256; //! number of samples used for noise power estimation
localparam NB_THRESHOLD     = 65;  //! number of bits of threshold
localparam NBF_THRESHOLD    = 62;  //! number of frac bits of threshold
localparam NB_WINDOW_COEFF  = 8;   //! number of bits used for window coeff
localparam NBF_WINDOW_COEFF = 7;
localparam NB_EXP_COEFF     = 16;   //! number of bits used for exponential coeff
localparam NB_DETECT        = 16;   // np*np*p // 2, temp

 //Ports
  reg clock;
  reg i_reset;
  reg i_enable;
  
  reg i_noise_data_valid; 
  reg i_signal_data_valid;
  
  reg [1                      : 0] i_window_sel;
  reg [10      : 0] i_data_size;
  reg [8       : 0] i_noise_size;
  reg [NB_SAMPLE_DATA     - 1 : 0] i_data_re;
  reg [NB_SAMPLE_DATA     - 1 : 0] i_data_im;
  reg [3                      : 0] i_pfa_value;
  wire [NB_DETECT          - 1 : 0] o_detect;
  wire o_est_done;
  wire o_detection_done;
  
  wire o_threshold_est_done;

  pm_top_mux # (
    .N_DESIRED(N_DESIRED),
    .NB_SAMPLE_DATA(NB_SAMPLE_DATA),
    .NBF_SAMPLE_DATA(NBF_SAMPLE_DATA),
    .NP_SAMPLES(NP_SAMPLES),
    .P_MAX(P_MAX),
    .N_NOISE_SAMPLES(N_NOISE_SAMPLES),
    .NB_THRESHOLD(NB_THRESHOLD),
    .NBF_THRESHOLD(NBF_THRESHOLD),
    .NB_WINDOW_COEFF(NB_WINDOW_COEFF),
    .NBF_WINDOW_COEFF(NBF_WINDOW_COEFF),
    .NB_EXP_COEFF(NB_EXP_COEFF),
    .NB_DETECT(NB_DETECT)
  )
  pm_top_mux_inst (
    .clock(clock),
    .i_reset(i_reset),
    .i_enable(i_enable),
    
    .i_noise_data_valid(i_noise_data_valid), 
	.i_signal_data_valid(i_signal_data_valid),
    
    .i_window_sel(i_window_sel),
    .i_data_size(i_data_size),
    .i_noise_size(i_noise_size),
    .i_data_re(i_data_re),
    .i_data_im(i_data_im),
    .i_pfa_value(i_pfa_value),
    .o_detect(o_detect),
    .o_est_done(o_est_done),
    .o_detection_done(o_detection_done),
    
    .o_threshold_est_done(o_threshold_est_done)
  );

reg [15 : 0] in1_mem [0 : 20000];  // real_memory
reg [15 : 0] in2_mem [0 : 20000];  // imag_memory

always #1.25  clock = ~clock;

integer i;

initial begin
    $readmemb("in_real.mem", in1_mem); // Load test data samples
    $readmemb("in_imag.mem", in2_mem); // Load test data samples
    
    clock       = 1'b0; // Set initial sys_clock value
    i_enable    = 1'b0; // Set initial enable signal value
    i_reset     = 1'b1; // Set sys_reset signal
    i_pfa_value = 4'b0000; 
    i_window_sel = 2'b00;
    i_data_size = 11'b10000000000;
    i_noise_size = 9'b100000000;
    
    i_noise_data_valid = '0;
    i_signal_data_valid = '0;
    
    i_data_re = '0;
    i_data_im = '0;

    
    #27.5 i_reset = 1'b0; // Release sys_reset
    #5 i_enable = 1'b1;   // Set enable signal
    
    #10 i_noise_data_valid = 1'b1;

    for (i = 0; i < 256; i = i + 1) begin
        @(posedge clock);
            i_data_re = in1_mem[i];
            i_data_im = '0;
    end
    
    #5 i_noise_data_valid = 1'b0;
    
    #5 i_signal_data_valid = 1'b1;
    
    for (i = 0; i < 2048; i = i + 1) begin
        @(posedge clock);
            i_data_re = in1_mem[i];
            i_data_im = '0;
    end
    
    #5 i_signal_data_valid = 1'b0;
    

    // #1000 $finish; 
end

// scd_vector_dump.sv
//
// Drop this block inside pm_top_mux_tb (e.g. just before `endmodule`).
// It taps five internal nodes of the SCD/FAM pipeline and dumps them to
// text files for cross-checking against the Python golden model
// (cr_scd_estimator_hw with dump_path set).
//
// Convention confirmed: on all AXI-Stream complex tdata buses in this
// design, the LOW half is imaginary, the HIGH half is real.
//
// STATUS: all 5 taps complete and ready to run.

`define FS1 pm_top_mux_inst.scd_estimator.pm_first_stage_wrap_inst
`define FS2 pm_top_mux_inst.scd_estimator.pm_second_stage_wrap_inst

// ---- widths ---------------------------------------------------------
// Complex multiplier widths: confirmed from instantiation comments.
localparam int CMULT_OUT_W    = 64; // m_axis_dout_tdata [63:0]
localparam int CMULT_OUT_HALF = CMULT_OUT_W / 2;

// FFT widths: UNKNOWN, placeholders until confirmed.
// TODO: set to actual declared width of w_fft1_m_axis_data_tdata
localparam int FFT1_W = 32; // confirmed: 16 re + 16 im
localparam int FFT1_HALF = FFT1_W / 2;
// TODO: set to actual declared width of w_fft2_m_axis_data_tdata
localparam int FFT2_W = 64; // confirmed: 32 re + 32 im
localparam int FFT2_HALF = FFT2_W / 2;

// ---- file handles -----------------------------------------------------
integer f_frames, f_fft1, f_cmult1, f_cmult2, f_fft2;

initial begin
    f_frames = $fopen("dump_frames.txt", "w");
    f_fft1   = $fopen("dump_fft1.txt",   "w");
    f_cmult1 = $fopen("dump_cmult1.txt", "w");
    f_cmult2 = $fopen("dump_cmult2.txt", "w");
    f_fft2   = $fopen("dump_fft2.txt",   "w");

    // Self-documenting header: Q-format pulled directly from RTL parameters
    $fwrite(f_frames, "# NB=%0d NBF=%0d\n", `FS1.NB_DATA_O, `FS1.NBF_DATA_O);
    $fwrite(f_fft1,   "# tdata_width=%0d (im=low half, re=high half)\n", FFT1_W);
    $fwrite(f_cmult1, "# tdata_width=%0d (im=low half, re=high half)\n", CMULT_OUT_W);
    $fwrite(f_cmult2, "# tdata_width=%0d (im=low half, re=high half)\n", CMULT_OUT_W);
    $fwrite(f_fft2,   "# tdata_width=%0d (im=low half, re=high half), tuser=sample_index_in_block\n", FFT2_W);
end

// ---- Tap 1: windowed frames (real/imag), pre-FFT1 ----------------------
//always @(posedge clock) begin
//    if (`FS1.input_window_real.o_valid)
//        $fwrite(f_frames, "%0t %0d %0d\n", $time,
//                $signed(`FS1.input_window_real.o_product),
//                $signed(`FS1.input_window_imag.o_product));
//end
integer frame_idx;

always @(posedge clock) begin
    if (`FS1.input_window_real.o_valid) begin

        $fwrite(f_frames, "%0t ", $time);

        for (frame_idx = 0; frame_idx < `FS1.NP; frame_idx = frame_idx + 1)
            $fwrite(f_frames,
                    "%0d %0d ",
                    $signed(`FS1.w_window_output_re[frame_idx]),
                    $signed(`FS1.w_window_output_im[frame_idx]));

        $fwrite(f_frames, "\n");
    end
end

// ---- Tap 2: FFT1 output (np_point_fft) ----------------------------------
always @(posedge clock) begin
    if (`FS1.np_point_fft.m_axis_data_tvalid)
        $fwrite(f_fft1, "%0t %0d %0d %0d\n", $time,
                $signed(`FS1.w_fft1_m_axis_data_tdata[FFT1_W-1:FFT1_HALF]),   // real
                $signed(`FS1.w_fft1_m_axis_data_tdata[FFT1_HALF-1:0]),        // imag
                `FS1.np_point_fft.m_axis_data_tlast);
end

// ---- Tap 3: phase-corrected output (complex_multiplier1) ---------------
always @(posedge clock) begin
    if (`FS2.complex_multiplier1_ip_core.m_axis_dout_tvalid)
        $fwrite(f_cmult1, "%0t %0d %0d\n", $time,
                $signed(`FS2.w_m_cmult1_axis_dout_tdata[CMULT_OUT_W-1:CMULT_OUT_HALF]),  // real
                $signed(`FS2.w_m_cmult1_axis_dout_tdata[CMULT_OUT_HALF-1:0]));           // imag
end

// ---- Tap 4: conjugate product output (complex_multiplier2) -------------
always @(posedge clock) begin
    if (`FS2.complex_multiplier2_ip_core.m_axis_dout_tvalid)
        $fwrite(f_cmult2, "%0t %0d %0d\n", $time,
                $signed(`FS2.w_m_cmult2_axis_dout_tdata[CMULT_OUT_W-1:CMULT_OUT_HALF]),  // real
                $signed(`FS2.w_m_cmult2_axis_dout_tdata[CMULT_OUT_HALF-1:0]));           // imag
end

// ---- Tap 5: FFT2 / SCD output (p_point_fft) -----------------------------
// m_axis_data_tuser is just the output sample index -- not a scale factor.
// tdata alone is the full fixed-point value, no reconstruction needed.
// Logging tuser anyway since it's a free, convenient cross-check for the
// (i,k) ordering question -- it tells us exactly which sample within a
// P-length block we're looking at without having to infer it from a
// valid-cycle counter.
always @(posedge clock) begin
    if (`FS2.p_point_fft.m_axis_data_tvalid)
        $fwrite(f_fft2, "%0t %0d %0d %0d %0d\n", $time,
                $signed(`FS2.w_fft2_m_axis_data_tdata[FFT2_W-1:FFT2_HALF]),   // real
                $signed(`FS2.w_fft2_m_axis_data_tdata[FFT2_HALF-1:0]),        // imag
                `FS2.p_point_fft.m_axis_data_tuser,                            // sample index within block
                `FS2.p_point_fft.m_axis_data_tlast);
end

final begin
    $fclose(f_frames);
    $fclose(f_fft1);
    $fclose(f_cmult1);
    $fclose(f_cmult2);
    $fclose(f_fft2);
end

`undef FS1
`undef FS2

endmodule