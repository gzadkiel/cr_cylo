module mc_claude_tb;

// Parameters
localparam N_DESIRED        = 1024;
localparam NB_SAMPLE_DATA   = 12;
localparam NBF_SAMPLE_DATA  = 9;
localparam NP_SAMPLES       = 32;
localparam P_MAX            = 128;
localparam N_NOISE_SAMPLES  = 256;
localparam NB_THRESHOLD     = 65;
localparam NBF_THRESHOLD    = 62;
localparam NB_WINDOW_COEFF  = 8;
localparam NBF_WINDOW_COEFF = 7;
localparam NB_EXP_COEFF     = 16;
localparam NB_DETECT        = 16;

// Monte Carlo parameters
localparam BLOCK_SIZE = 1280;
localparam N_TRIALS   = 1000;
localparam N_MONTECARLO = 1000;
localparam int RNG_SEED = 12345;

parameter COMPARISON_WIDTH = 65;

// Ports

  reg i_noise_data_valid; 
  reg i_signal_data_valid;

reg                         clock;
reg                         i_reset;
reg                         i_enable;
reg [1                 : 0] i_window_sel;
reg [10                : 0] i_data_size;
reg [8                 : 0] i_noise_size;
reg [NB_SAMPLE_DATA -1 : 0] i_data_re;
reg [NB_SAMPLE_DATA -1 : 0] i_data_im;
reg [3                 : 0] i_pfa_value;

wire [NB_DETECT - 1 : 0] o_detect;
wire                     o_est_done;
wire                     o_detection_done;

wire o_threshold_est_done;

// DUT
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

// Input memories
reg [11:0] in1_mem [0:1000*1280];
reg [11:0] in2_mem [0:1000*1280];

integer outfile;
integer trial;

logic [COMPARISON_WIDTH - 1 : 0] trial_max;

// Clock generation
always #0.5 clock = ~clock;

// FIX 1: $readmemb en bloque initial propio para evitar el warning "empty statement in sequential block"
initial begin
    $readmemb("in_real.mem", in1_mem);
    $readmemb("in_imag.mem", in2_mem);
end

// MONITOR DE LA SEÑAL 'comparison'
//  w_comparison: wire que captura el valor jerárquico al ancho correcto.
//  max_comparison: máximo acumulado, sólo escrito por este always_ff.
//  monitor_reset_max: pulso de 1 ciclo emitido por el proceso principal
//                     para limpiar el máximo al inicio de cada realización.
// RUTA JERÁRQUICA A LA SEÑAL 'comparison'

`define COMPARISON_PATH pm_top_mux.detection_compare_inst.r_comparison
wire [COMPARISON_WIDTH - 1 : 0] w_comparison;
assign w_comparison = COMPARISON_WIDTH'(`COMPARISON_PATH);

logic [COMPARISON_WIDTH - 1 : 0] max_comparison;    // solo escrito por always_ff
logic                            monitor_reset_max; // conducido desde initial

always_ff @(posedge clock) begin
    if      (i_reset                      ) max_comparison <= '0;
    else if (monitor_reset_max            ) max_comparison <= '0;
    else if (w_comparison > max_comparison) max_comparison <= w_comparison; 
end

// Main test
initial begin

    if (RNG_SEED != 0) $srandom(RNG_SEED);

    clock         = 1'b0;
    i_enable      = 1'b0;
    i_reset       = 1'b1;
    i_pfa_value   = 4'b0000;
    i_window_sel  = 2'b00;

    i_data_size   = 11'b10000000000;
    i_noise_size  = 9'b010000000;

    i_data_re  = '0;
    i_data_im  = '0;

    // Reset
    #27.5;
    i_reset = 1'b0;

    #5;
    i_enable = 1'b1;

    // Abrir archivo de resultados
    outfile = $fopen("mc_comparison_max.txt", "a"); // "a" = append
    if (!outfile) $fatal(1, "[MC] ERROR: no se puede crear mc_comparison_max.txt");

    // Monte Carlo loop
    for (trial = 0; trial < N_TRIALS ; trial = trial + 1) begin
        
        // Resetear el máximo de esta realización (pulso de 1 ciclo)
        @ (negedge clock);
        monitor_reset_max = 1'b1;
        @ (posedge clock);
        @ (negedge clock);
        monitor_reset_max = 1'b0;

        $display("========================================");
        $display("Starting trial %0d", trial);
        $display("========================================");
        
        i_noise_data_valid = '0;
        i_signal_data_valid = '0;
    
        i_data_re = '0;
        i_data_im = '0;
        
        #10 i_noise_data_valid = 1'b1;

        for (int k = 0; k < 256; k = k + 1) begin
            @(posedge clock);
            i_data_re <= in1_mem[k + trial*BLOCK_SIZE];
            @(posedge clock);
            //i_data_im <= in2_mem[k + trial*BLOCK_SIZE];
            i_data_im <= '0;
        end
        
        #5 i_noise_data_valid = 1'b0;
        #5 i_signal_data_valid = 1'b1;
        
        for (int k = 0; k < 1024; k = k + 1) begin
            @(posedge clock);
            i_data_re <= in1_mem[k + trial*BLOCK_SIZE];
            @(posedge clock);
            //i_data_im <= in2_mem[k + trial*BLOCK_SIZE];
            i_data_im <= '0;
        end
        
        #5 i_signal_data_valid = 1'b0;
        
        wait(o_detection_done == 1'b1);
        
        trial_max = max_comparison;
        $fwrite(outfile, "%0d\n", trial_max);
        
        $display("[MC] Trial %5d  max_comparison = %0d", trial, trial_max);

        // if ((trial % 250 == 0) || (trial == N_MONTECARLO - 1))
        //    $display("[MC] Trial %5d / %0d   max_comparison = %0d", trial + 1, N_MONTECARLO, trial_max);
            
    end
    
    $fclose(outfile);

    // Results
    $display("");
    $display("========================================");
    $display("MONTE CARLO RESULTS");
    $display("========================================");
    $display("Trials      = %0d", N_TRIALS);
    $display("========================================");

    #100;
    $finish;

end

endmodule