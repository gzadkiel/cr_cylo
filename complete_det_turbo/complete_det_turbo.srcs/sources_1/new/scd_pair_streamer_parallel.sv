module scd_pair_streamer_parallel #(
    parameter integer N_BANKS        = 4,
    parameter integer N_ENGINES      = 4,
    parameter integer NP             = 32,
    parameter integer P_MIN          = 8,
    parameter integer P_MAX          = 128,
    parameter integer DATA_WIDTH     = 32,
    parameter integer COMPONENT_W    = DATA_WIDTH/2,
    parameter integer BANK_DEPTH     = P_MAX / N_BANKS,
    parameter integer MEM_DEPTH      = NP * BANK_DEPTH,
    parameter integer MEM_ADDR_WIDTH = $clog2(MEM_DEPTH),
    parameter integer BANK_SEL_WIDTH = $clog2(N_BANKS),
    parameter integer ENGINE_SEL_W   = $clog2(N_ENGINES),
    parameter integer BIN_WIDTH      = $clog2(NP),
    parameter integer K_WIDTH        = $clog2(P_MAX),
    parameter integer PAIR_COUNT     = (NP * (NP-1)) / 2,
    parameter integer PAIR_ID_WIDTH  = $clog2(PAIR_COUNT)
) (
    input  logic                          clock,
    input  logic                          i_reset,
    input  logic                          i_clear,
    input  logic                          i_start,
    input  logic [$clog2(P_MAX)      : 0] i_p_frames,

    // Read interface to the N_BANKS FFT1-storage banks.
    output logic                          o_rd_en     [N_BANKS],
    output logic [MEM_ADDR_WIDTH - 1 : 0] o_rd_addr_a [N_BANKS],
    output logic [MEM_ADDR_WIDTH - 1 : 0] o_rd_addr_b [N_BANKS],
    input  logic [DATA_WIDTH     - 1 : 0] i_rd_data_a [N_BANKS],
    input  logic [DATA_WIDTH     - 1 : 0] i_rd_data_b [N_BANKS],

    // N_ENGINES independent complex-product streams.
    // A = X[i,k], B = conj(X[j,k]), only for i > j.
    output logic [DATA_WIDTH     - 1 : 0] o_cmult_a_tdata [N_ENGINES],
    output logic [DATA_WIDTH     - 1 : 0] o_cmult_b_tdata [N_ENGINES],
    output logic                          o_cmult_tvalid  [N_ENGINES],
    output logic                          o_pair_tlast    [N_ENGINES],
    output logic [BIN_WIDTH      - 1 : 0] o_pair_i        [N_ENGINES],
    output logic [BIN_WIDTH      - 1 : 0] o_pair_j        [N_ENGINES],
    output logic [PAIR_ID_WIDTH  - 1 : 0] o_pair_id       [N_ENGINES],

    output logic                          o_busy,
    output logic                          o_done
);

    // N_BANKS is dictated by the four FFT1 streams / memories.
    // N_ENGINES is independent and may be 1, 2 or 4 (<= N_BANKS).
    
    // Engines are launched one clock apart, since P is a multiple of N_BANKS. 
    // That phase offset is preserved when a new (i,j) pair starts, so engines access different banks in the same cycle.

    logic                         r_engine_active  [N_ENGINES];
    logic [K_WIDTH       - 1 : 0] r_engine_k       [N_ENGINES];
    logic [BIN_WIDTH     - 1 : 0] r_engine_i       [N_ENGINES];
    logic [BIN_WIDTH     - 1 : 0] r_engine_j       [N_ENGINES];
    logic [PAIR_ID_WIDTH - 1 : 0] r_engine_pair_id [N_ENGINES];

    logic [BIN_WIDTH     - 1 : 0] r_next_i;
    logic [BIN_WIDTH     - 1 : 0] r_next_j;
    logic [PAIR_ID_WIDTH     : 0] r_pairs_assigned;
    logic [PAIR_ID_WIDTH - 1 : 0] r_next_pair_id;
    logic                         r_running;

    // Metadata pipeline matching the one-cycle synchronous RAM read latency.
    logic                          r_resp_valid   [N_ENGINES];
    logic [BANK_SEL_WIDTH - 1 : 0] r_resp_bank    [N_ENGINES];
    logic                          r_resp_last    [N_ENGINES];
    logic [BIN_WIDTH      - 1 : 0] r_resp_i       [N_ENGINES];
    logic [BIN_WIDTH      - 1 : 0] r_resp_j       [N_ENGINES];
    logic [PAIR_ID_WIDTH  - 1 : 0] r_resp_pair_id [N_ENGINES];

    logic                          w_req_granted [N_ENGINES];
    logic [BANK_SEL_WIDTH - 1 : 0] w_req_bank    [N_ENGINES];

    logic                        w_assign_valid;
    logic [ENGINE_SEL_W - 1 : 0] w_assign_engine;
    logic                        w_pairs_left;
    logic                        w_all_engines_idle;
    logic                        w_all_resp_idle;
    logic                        w_p_is_power_of_two;

    assign o_busy       = r_running;
    assign w_pairs_left = (r_pairs_assigned < PAIR_COUNT);

    assign w_p_is_power_of_two = (i_p_frames != 0) && ((i_p_frames & (i_p_frames - 1'b1)) == 0);

    // Assign at most one new pair per cycle, this deliberate staggering is what gives different engines different k mod N_BANKS phases.
    always_comb begin : ASSIGN_SELECT
        w_assign_valid  = '0;
        w_assign_engine = '0;

        if (r_running && w_pairs_left) begin
            // First priority: an engine sending k = P-1 this cycle can start the next pair on the same clock edge, with no temporal gap.
            for (int eng = 0; eng < N_ENGINES; eng++) begin
                if (!w_assign_valid && r_engine_active[eng] && (r_engine_k[eng] == i_p_frames - 1'b1)) begin
                    w_assign_valid  = 1'b1;
                    w_assign_engine = eng[ENGINE_SEL_W-1:0];
                end
            end
            // During startup, use the first idle engine, this launches engines one clock apart: engine0, then engine1, etc.
            for (int eng = 0; eng < N_ENGINES; eng++) begin
                if (!w_assign_valid && !r_engine_active[eng]) begin
                    w_assign_valid  = 1'b1;
                    w_assign_engine = eng[ENGINE_SEL_W-1:0];
                end
            end
        end
    end

    // Read crossbar, each engine requests two values from the SAME bank: X[i,k] and X[j,k]. 
    // The bank is k mod N_BANKS and the local temporal address is floor(k/N_BANKS).
    always_comb begin : READ_CROSSBAR
        logic   [N_BANKS - 1 : 0] bank_used;
        integer                   bank;
        integer                   group;
        integer                   addr_a;
        integer                   addr_b;

        bank_used = '0;

        for (int bank_idx = 0; bank_idx < N_BANKS; bank_idx++) begin
            o_rd_en[bank_idx]     = '0;
            o_rd_addr_a[bank_idx] = '0;
            o_rd_addr_b[bank_idx] = '0;
        end

        for (int eng = 0; eng < N_ENGINES; eng++) begin
            w_req_granted[eng] = '0;
            w_req_bank[eng]    = '0;

            if (r_engine_active[eng]) begin
                bank   = r_engine_k[eng] % N_BANKS;
                group  = r_engine_k[eng] / N_BANKS;
                addr_a = r_engine_i[eng] * BANK_DEPTH + group;
                addr_b = r_engine_j[eng] * BANK_DEPTH + group;

                w_req_bank[eng] = bank[BANK_SEL_WIDTH-1:0];

                if (!bank_used[bank]) begin
                    bank_used[bank]    = 1'b1;
                    w_req_granted[eng] = 1'b1;
                    o_rd_en[bank]      = 1'b1;
                    o_rd_addr_a[bank]  = addr_a[MEM_ADDR_WIDTH-1:0];
                    o_rd_addr_b[bank]  = addr_b[MEM_ADDR_WIDTH-1:0];
                end
            end
        end
    end

    // Route each bank response back to the engine that requested it one cycle earlier and conjugate operand B by negating only its imaginary component.
    always_comb begin : OUTPUT_CROSSBAR
        logic signed [COMPONENT_W - 1 : 0] b_re;
        logic signed [COMPONENT_W - 1 : 0] b_im;
        logic signed [COMPONENT_W - 1 : 0] b_im_conj;

        for (int eng = 0; eng < N_ENGINES; eng++) begin
            o_cmult_a_tdata[eng] = i_rd_data_a[r_resp_bank[eng]];

            b_re      = $signed(i_rd_data_b[r_resp_bank[eng]][COMPONENT_W-1:0]);
            b_im      = $signed(i_rd_data_b[r_resp_bank[eng]][DATA_WIDTH-1:COMPONENT_W]);
            b_im_conj = -b_im;

            o_cmult_b_tdata[eng] = {b_im_conj, b_re};
            o_cmult_tvalid[eng]  = r_resp_valid[eng];
            o_pair_tlast[eng]    = r_resp_valid[eng] && r_resp_last[eng];
            o_pair_i[eng]        = r_resp_i[eng];
            o_pair_j[eng]        = r_resp_j[eng];
            o_pair_id[eng]       = r_resp_pair_id[eng];
        end
    end

    always_comb begin
        w_all_engines_idle = 1'b1;
        w_all_resp_idle    = 1'b1;

        for (int eng = 0; eng < N_ENGINES; eng++) begin
            if (r_engine_active[eng]) w_all_engines_idle = 1'b0;
            if (r_resp_valid[eng]   ) w_all_resp_idle    = 1'b0;
        end
    end

    always_ff @(posedge clock) begin : PAIR_CONTROL
        if (i_reset || i_clear) begin
            r_running        <= '0;
            o_done           <= '0;
            r_next_i         <= {{(BIN_WIDTH-1){1'b0}}, 1'b1};
            r_next_j         <= '0;
            r_pairs_assigned <= '0;
            r_next_pair_id   <= '0;
            for (int eng = 0; eng < N_ENGINES; eng++) begin
                r_engine_active[eng]  <= '0;
                r_engine_k[eng]       <= '0;
                r_engine_i[eng]       <= '0;
                r_engine_j[eng]       <= '0;
                r_engine_pair_id[eng] <= '0;
                r_resp_valid[eng]     <= '0;
                r_resp_bank[eng]      <= '0;
                r_resp_last[eng]      <= '0;
                r_resp_i[eng]         <= '0;
                r_resp_j[eng]         <= '0;
                r_resp_pair_id[eng]   <= '0;
            end
        end
        else begin
            o_done <= 1'b0;

            if (i_start && !r_running) begin
                r_running        <= 1'b1;
                r_next_i         <= {{(BIN_WIDTH-1){1'b0}}, 1'b1};
                r_next_j         <= '0;
                r_pairs_assigned <= '0;
                r_next_pair_id   <= '0;

                for (int eng = 0; eng < N_ENGINES; eng++) begin
                    r_engine_active[eng] <= '0;
                    r_engine_k[eng]      <= '0;
                    r_resp_valid[eng]    <= '0;
                end
            end
            else if (r_running) begin
                // Register metadata for RAM requests issued in this cycle.
                for (int eng = 0; eng < N_ENGINES; eng++) begin
                    r_resp_valid[eng] <= w_req_granted[eng];

                    if (w_req_granted[eng]) begin
                        r_resp_bank[eng]    <= w_req_bank[eng];
                        r_resp_last[eng]    <= (r_engine_k[eng] == i_p_frames - 1'b1);
                        r_resp_i[eng]       <= r_engine_i[eng];
                        r_resp_j[eng]       <= r_engine_j[eng];
                        r_resp_pair_id[eng] <= r_engine_pair_id[eng];
                    end
                end

                // Advance temporal index k for every active engine.
                for (int eng = 0; eng < N_ENGINES; eng++) begin
                    if (r_engine_active[eng]) begin
                        if (r_engine_k[eng] == i_p_frames - 1'b1) begin
                            r_engine_active[eng] <= '0;
                            r_engine_k[eng]      <= '0;
                        end
                        else r_engine_k[eng] <= r_engine_k[eng] + 1'b1;
                    end
                end

                // Assign the next unique pair (i,j), with i>j only.
                if (w_assign_valid) begin
                    r_engine_active[w_assign_engine]  <= 1'b1;
                    r_engine_k[w_assign_engine]       <= '0;
                    r_engine_i[w_assign_engine]       <= r_next_i;
                    r_engine_j[w_assign_engine]       <= r_next_j;
                    r_engine_pair_id[w_assign_engine] <= r_next_pair_id;

                    r_pairs_assigned <= r_pairs_assigned + 1'b1;
                    r_next_pair_id   <= r_next_pair_id + 1'b1;

                    if ((r_next_j + 1'b1) < r_next_i) r_next_j <= r_next_j + 1'b1;
                    else if (r_next_i < NP-1) begin
                        r_next_i <= r_next_i + 1'b1;
                        r_next_j <= '0;
                    end
                end

                // Done means all pair data has left the RAM-side scheduler.
                // CMULT/FFT2 pipelines may still contain data and should be drained separately by the final stage controller.
                if (!w_pairs_left && w_all_engines_idle && w_all_resp_idle) begin
                    r_running <= 1'b0;
                    o_done    <= 1'b1;
                end
            end
            else begin
                for (int eng = 0; eng < N_ENGINES; eng++)
                    r_resp_valid[eng] <= 1'b0;
            end
        end
    end

endmodule
