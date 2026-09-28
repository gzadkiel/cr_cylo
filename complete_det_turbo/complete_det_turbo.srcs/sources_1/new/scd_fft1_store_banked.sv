module scd_fft1_store_banked #(
    parameter integer N_BANKS        = 4,
    parameter integer NP             = 32,
    parameter integer P_MIN          = 8,
    parameter integer P_MAX          = 128,
    parameter integer DATA_WIDTH     = 32,

    parameter integer BANK_DEPTH     = P_MAX / N_BANKS,
    parameter integer MEM_DEPTH      = NP * BANK_DEPTH,
    parameter integer MEM_ADDR_WIDTH = $clog2(MEM_DEPTH),
    parameter integer BIN_WIDTH      = $clog2(NP),
    parameter integer GROUP_ADDR_W   = $clog2(BANK_DEPTH),
    parameter integer GROUP_COUNT_W  = $clog2(BANK_DEPTH + 1)
) (
    input  logic                          clock,
    input  logic                          i_reset,
    input  logic                          i_clear,
    input  logic [$clog2(P_MAX)      : 0] i_p_frames,

    // One corrected FFT1 stream per physical bank, with N_BANKS = 4:
    //      bank 0 -> k = 0, 4, 8 , ...
    //      bank 1 -> k = 1, 5, 9 , ...
    //      bank 2 -> k = 2, 6, 10, ...
    //      bank 3 -> k = 3, 7, 11, ...
    input  logic [DATA_WIDTH     - 1 : 0] i_s_axis_tdata  [N_BANKS],
    input  logic                          i_s_axis_tvalid [N_BANKS],
    input  logic                          i_s_axis_tlast  [N_BANKS],
    output logic                          o_s_axis_tready [N_BANKS],

    // Two synchronous read ports per bank.
    input  logic                          i_rd_en     [N_BANKS],
    input  logic [MEM_ADDR_WIDTH - 1 : 0] i_rd_addr_a [N_BANKS],
    input  logic [MEM_ADDR_WIDTH - 1 : 0] i_rd_addr_b [N_BANKS],
    output logic [DATA_WIDTH     - 1 : 0] o_rd_data_a [N_BANKS],
    output logic [DATA_WIDTH     - 1 : 0] o_rd_data_b [N_BANKS],

    output logic                          o_load_done
);

    // -------------------------------------------------------------------------
    // Storage layout inside each bank
    //
    // addr = fft1_bin * BANK_DEPTH + frame_group
    // frame_group = floor(k / N_BANKS)
    //
    // For NP = 32, P_MAX = 128, N_BANKS = 4:
    //      BANK_DEPTH = 32
    //      MEM_DEPTH  = 1024
    //      each bank  = 1024 x 32 bits = 32768 bits -> one RAMB36-class BRAM
    // -------------------------------------------------------------------------

    logic [BIN_WIDTH     - 1 : 0] r_sample_idx  [N_BANKS];
    logic [GROUP_COUNT_W - 1 : 0] r_frame_group [N_BANKS];
    logic                         r_lane_done   [N_BANKS];

    logic [$clog2(P_MAX) : 0] w_frames_per_bank;
    logic                     w_p_is_power_of_two;

    logic [MEM_ADDR_WIDTH - 1 : 0] w_wr_addr [N_BANKS];
    logic                          w_wr_en   [N_BANKS];

    // RAM Port-A/B controls.
    logic                          w_ram_porta_en   [N_BANKS];
    logic                          w_ram_porta_we   [N_BANKS];
    logic [MEM_ADDR_WIDTH - 1 : 0] w_ram_porta_addr [N_BANKS];
    logic [DATA_WIDTH     - 1 : 0] w_ram_porta_din  [N_BANKS];

    logic                          w_ram_portb_en   [N_BANKS];
    logic [MEM_ADDR_WIDTH - 1 : 0] w_ram_portb_addr [N_BANKS];

    assign w_frames_per_bank   = i_p_frames / N_BANKS;
    assign w_p_is_power_of_two = (i_p_frames != 0) && ((i_p_frames & (i_p_frames - 1'b1)) == 0);

    // -------------------------------------------------------------------------
    // Load completion / AXI ready generation
    // -------------------------------------------------------------------------
    always_comb begin
        o_load_done = 1'b1;
        for (int bank = 0; bank < N_BANKS; bank++) begin
            o_s_axis_tready[bank] = !r_lane_done[bank];
            if (!r_lane_done[bank]) o_load_done = 1'b0;
        end
    end

    // -------------------------------------------------------------------------
    // Write address generation
    // -------------------------------------------------------------------------
    always_comb begin
        for (int bank = 0; bank < N_BANKS; bank++) begin
            w_wr_addr[bank] = (r_sample_idx[bank] * BANK_DEPTH) + r_frame_group[bank][GROUP_ADDR_W-1:0];
            w_wr_en[bank]   = !o_load_done && i_s_axis_tvalid[bank] && o_s_axis_tready[bank];
            // During load: Port A writes.
            // During processing: Port A becomes read port A.
            if (!o_load_done) begin
                w_ram_porta_en[bank]   = w_wr_en[bank];
                w_ram_porta_we[bank]   = w_wr_en[bank];
                w_ram_porta_addr[bank] = w_wr_addr[bank];
                w_ram_porta_din[bank]  = i_s_axis_tdata[bank];

                w_ram_portb_en[bank]   = '0;
                w_ram_portb_addr[bank] = '0;
            end
            else begin
                w_ram_porta_en[bank]   = i_rd_en[bank];
                w_ram_porta_we[bank]   = '0;
                w_ram_porta_addr[bank] = i_rd_addr_a[bank];
                w_ram_porta_din[bank]  = '0;

                w_ram_portb_en[bank]   = i_rd_en[bank];
                w_ram_portb_addr[bank] = i_rd_addr_b[bank];
            end
        end
    end

    // -------------------------------------------------------------------------
    // Four (parameterized N_BANKS) physically independent BRAM banks.
    // Keeping each memory in a dedicated submodule makes Vivado inference much more reliable than a two-dimensional mem[N_BANKS][MEM_DEPTH] array.
    // -------------------------------------------------------------------------
    generate
        for (genvar bank = 0; bank < N_BANKS; bank++) begin : GEN_BANK_RAM
            scd_fft1_bank_tdp_ram #(
                .DATA_WIDTH (DATA_WIDTH    ),
                .DEPTH      (MEM_DEPTH     ),
                .ADDR_WIDTH (MEM_ADDR_WIDTH)) 
            u_bank_ram (
                .clock        (clock                 ),

                .i_porta_en   (w_ram_porta_en[bank]  ),
                .i_porta_we   (w_ram_porta_we[bank]  ),
                .i_porta_addr (w_ram_porta_addr[bank]),
                .i_porta_din  (w_ram_porta_din[bank] ),
                .o_porta_dout (o_rd_data_a[bank]     ),

                .i_portb_en   (w_ram_portb_en[bank]  ),
                .i_portb_addr (w_ram_portb_addr[bank]),
                .o_portb_dout (o_rd_data_b[bank]     ));
        end
    endgenerate

    // -------------------------------------------------------------------------
    // Per-bank frame/sample counters.
    // RAM contents are intentionally NOT reset/cleared. A new run overwrites every location that will later be read.
    // -------------------------------------------------------------------------
    always_ff @(posedge clock) begin
        if (i_reset || i_clear) begin
            for (int bank = 0; bank < N_BANKS; bank++) begin
                r_sample_idx[bank]  <= '0;
                r_frame_group[bank] <= '0;
                r_lane_done[bank]   <= '0;
            end
        end
        else begin
            for (int bank = 0; bank < N_BANKS; bank++) begin
                if (w_wr_en[bank]) begin 
                    if (i_s_axis_tlast[bank]) begin
                        r_sample_idx[bank] <= '0;
                        if ((r_frame_group[bank] + 1'b1) >= w_frames_per_bank) r_lane_done[bank] <= 1'b1;
                        else                                                   r_frame_group[bank] <= r_frame_group[bank] + 1'b1;
                    end
                    else r_sample_idx[bank] <= r_sample_idx[bank] + 1'b1;
                end
            end
        end
    end

endmodule
