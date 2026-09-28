`timescale 1ns / 1ps

module fam_detector_top_tb;

    // =========================================================================
    // Parameters
    // =========================================================================
    localparam integer N_DESIRED_MAX        = 1024;
    localparam integer NB_SAMPLE_DATA       = 12;
    localparam integer NBF_SAMPLE_DATA      = 9;
    localparam integer NP                   = 32;
    localparam integer P_MIN                = 8;
    localparam integer P_MAX                = 128;
    localparam integer N_BANKS              = 4;
    localparam integer N_ENGINES            = 4;
    localparam integer N_NOISE_SAMPLES_MAX  = 1024;
    localparam integer NBF_NOISE_DATA       = 9;
    localparam integer NB_THRESHOLD         = 65;
    localparam integer NBF_THRESHOLD        = 62;
    localparam integer NB_WINDOW_COEFF      = 8;
    localparam integer NBF_WINDOW_COEFF     = 7;
    localparam integer NB_DETECT            = 16;

    // =========================================================================
    // Test configuration
    // =========================================================================
    // Same basic configuration as the original testbench:
    //
    //   N = 1024
    //   NP = 32
    //   L = NP/4 = 8
    //   P = N/L = 128
    //
    // The external source supplies exactly N=TB_DATA_SIZE signal samples.
    // fam_detector_top appends the required zeros internally until N_tot.
    //
    // For N=1024, NP=32, L=8:
    //     N_tot = 1048
    //     external samples = 1024
    //     internal padding = 24 zeros
    //
    localparam integer TB_DATA_SIZE         = 1024;
    localparam integer TB_NOISE_SAMPLES     = 512;
    localparam integer TB_SIGNAL_SAMPLES    = TB_DATA_SIZE;
    localparam integer L                    = NP / 4;
    localparam integer TB_P_FRAMES          = TB_DATA_SIZE / L;
    localparam integer TB_N_TOT             = (TB_P_FRAMES - 1) * L + NP;
    localparam integer SIGNAL_MEM_OFFSET    = TB_NOISE_SAMPLES;

    // 00: Hamming
    // 01: Blackman
    // 10: Rectangular
    localparam logic [1:0] TB_WINDOW_SEL    = 2'b00;

    // PFA ROM index: keep same setting as original TB.
    localparam logic [3:0] TB_PFA_VALUE     = 4'b0000;

    // Select the desired threshold-ROM mode.
    localparam logic       TB_SCD_MODE      = 1'b0;

    // =========================================================================
    // DUT ports
    // =========================================================================
    logic clock;
    logic i_reset;
    logic i_enable;

    logic i_noise_data_valid;
    logic i_signal_data_valid;

    logic [1:0] i_window_sel;
    logic [$clog2(N_DESIRED_MAX):0] i_data_size;
    logic [$clog2(N_NOISE_SAMPLES_MAX):0] i_noise_size;

    logic signed [NB_SAMPLE_DATA-1:0] i_data_re;
    logic signed [NB_SAMPLE_DATA-1:0] i_data_im;

    logic [3:0] i_pfa_value;
    logic       i_scd_mode;

    logic signed [NB_THRESHOLD-1:0] o_threshold;
    logic signed [2*NB_SAMPLE_DATA + $clog2(N_NOISE_SAMPLES_MAX)-1:0]
                                      o_noise_pow;

    logic [NB_DETECT-1:0] o_detect;
    logic                 o_detection_done;
    logic                 o_threshold_est_done;
    logic                 o_error;

    // =========================================================================
    // DUT
    // =========================================================================
    fam_detector_top #(
        .N_DESIRED_MAX        (N_DESIRED_MAX),
        .NP                   (NP),
        .P_MIN                (P_MIN),
        .P_MAX                (P_MAX),
        .N_BANKS              (N_BANKS),
        .N_ENGINES            (N_ENGINES),

        .NB_SAMPLE_DATA       (NB_SAMPLE_DATA),
        .NBF_SAMPLE_DATA      (NBF_SAMPLE_DATA),

        .NB_WINDOW_COEFF      (NB_WINDOW_COEFF),
        .NBF_WINDOW_COEFF     (NBF_WINDOW_COEFF),

        .N_NOISE_SAMPLES_MAX  (N_NOISE_SAMPLES_MAX),
        .NBF_NOISE_DATA       (NBF_NOISE_DATA),

        .NB_THRESHOLD         (NB_THRESHOLD),
        .NBF_THRESHOLD        (NBF_THRESHOLD),

        .NB_DETECT            (NB_DETECT)
    ) dut (
        .clock                (clock),
        .i_reset              (i_reset),
        .i_enable             (i_enable),

        .i_noise_data_valid   (i_noise_data_valid),
        .i_signal_data_valid  (i_signal_data_valid),

        .i_window_sel         (i_window_sel),
        .i_data_size          (i_data_size),
        .i_noise_size         (i_noise_size),

        .i_data_re            (i_data_re),
        .i_data_im            (i_data_im),

        .i_pfa_value          (i_pfa_value),
        .i_scd_mode           (i_scd_mode),

        .o_threshold          (o_threshold),
        .o_noise_pow          (o_noise_pow),
        .o_detect             (o_detect),
        .o_detection_done     (o_detection_done),
        .o_threshold_est_done (o_threshold_est_done),
        .o_error              (o_error)
    );

    // =========================================================================
    // Input memories
    //
    // Keep exactly the same .mem-file structure used by the original TB:
    // noise samples first, followed by signal samples.
    // =========================================================================
    reg [15:0] in1_mem [0:20000];  // real memory
    reg [15:0] in2_mem [0:20000];  // imag memory

    // Same 2.5 ns clock period as the original testbench.
    always #3.33 clock = ~clock;

    integer i;
    integer signal_idx;

    // =========================================================================
    // Test sequence
    // =========================================================================
    initial begin
        // ---------------------------------------------------------------------
        // Load vectors
        // ---------------------------------------------------------------------
        $readmemb("in_real.mem", in1_mem);
        $readmemb("in_imag.mem", in2_mem);

        // ---------------------------------------------------------------------
        // Initial values
        // ---------------------------------------------------------------------
        clock               = 1'b0;
        i_enable            = 1'b0;
        i_reset             = 1'b1;

        i_noise_data_valid  = 1'b0;
        i_signal_data_valid = 1'b0;

        i_pfa_value         = TB_PFA_VALUE;
        i_window_sel        = TB_WINDOW_SEL;
        i_scd_mode          = TB_SCD_MODE;

        i_data_size         = TB_DATA_SIZE;
        i_noise_size        = TB_NOISE_SAMPLES;

        i_data_re           = '0;
        i_data_im           = '0;

        // ---------------------------------------------------------------------
        // Reset / global enable
        // ---------------------------------------------------------------------
        #27.5;
        i_reset = 1'b0;

        #5;
        i_enable = 1'b1;

        // =====================================================================
        // 1. Noise / threshold estimation
        // =====================================================================
        //
        // Drive on the falling edge so the sample is stable before the DUT
        // samples it on the following rising edge. This avoids a TB/DUT race.
        // ---------------------------------------------------------------------
        @(negedge clock);
        i_noise_data_valid = 1'b1;

        for (i = 0; i < TB_NOISE_SAMPLES; i = i + 1) begin
            i_data_re = in1_mem[i][NB_SAMPLE_DATA-1:0];
            i_data_im = '0;
            @(negedge clock);
        end

        i_noise_data_valid = 1'b0;
        i_data_re          = '0;
        i_data_im          = '0;

        // The optimized threshold calculator now contains a sequential
        // multiplier, so do not start SCD processing until the final threshold
        // is actually valid.
        wait (o_threshold_est_done === 1'b1);

        $display("[%0t] Threshold estimation complete", $time);
        $display("       noise power = %0d", o_noise_pow);
        $display("       threshold   = %0d", o_threshold);

        // =====================================================================
        // 2. Signal / SCD estimation
        // =====================================================================
        @(negedge clock);
        i_signal_data_valid = 1'b1;

        // Wait until the top is actually requesting the first external signal
        // sample. Startup/configuration clocks are not counted as input data.
        wait (dut.w_take_signal_sample === 1'b1);

        $display("[%0t] First stage ready for input samples", $time);
        $display("       P frames           = %0d", dut.w_p_frames_fs);
        $display("       external samples   = %0d", TB_SIGNAL_SAMPLES);
        $display("       internal N_tot     = %0d", TB_N_TOT);
        $display("       internal zero pad  = %0d", TB_N_TOT - TB_SIGNAL_SAMPLES);

        signal_idx = SIGNAL_MEM_OFFSET;

        // Supply exactly N external samples. The top advances its own input
        // counter only when w_take_signal_sample is asserted. After sample N-1,
        // the top automatically switches first_stage_wrapper to complex zeros.
        i = 0;
        while (i < TB_SIGNAL_SAMPLES) begin
            @(negedge clock);

            if (dut.w_take_signal_sample) begin
                i_data_re = in1_mem[signal_idx][NB_SAMPLE_DATA-1:0];
                i_data_im = in2_mem[signal_idx][NB_SAMPLE_DATA-1:0];

                signal_idx = signal_idx + 1;
                i          = i + 1;
            end
        end

        // Keep raw external input at zero after the Nth sample. The DUT now
        // performs its own zero padding up to N_tot.
        @(negedge clock);
        i_data_re = '0;
        i_data_im = '0;

        // Optional debug check: observe the internal padding phase.
        wait (dut.w_padding_sample === 1'b1);
        $display("[%0t] Internal zero-padding phase started", $time);

        // =====================================================================
        // 3. Wait for complete detection
        // =====================================================================
        wait (o_detection_done === 1'b1);

        $display("[%0t] Detection complete", $time);
        $display("       detections = %0d", o_detect);
        $display("       error      = %0b", o_error);

        if (o_error)
            $display("WARNING: DUT asserted o_error during the run.");

        // Match the software handshake: lower SIGNAL_VALID after observing DONE.
        @(negedge clock);
        i_signal_data_valid = 1'b0;

        wait (o_detection_done === 1'b0);

        #20;
        $finish;
    end

    // =========================================================================
    // Safety timeout
    // =========================================================================
    initial begin
        #2000000;
        $fatal(1, "Simulation timeout before detector completion.");
    end

endmodule
