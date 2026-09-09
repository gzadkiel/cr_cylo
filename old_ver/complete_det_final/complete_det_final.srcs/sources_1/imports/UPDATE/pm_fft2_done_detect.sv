module fft_done_detector #(
    parameter TIMEOUT_CYCLES = 4
) (
    input  logic clock,
    input  logic i_reset,
    input  logic i_enable,

    input  logic s_axis_tvalid,
    input  logic s_axis_tready,
    input  logic s_axis_tlast,

    output logic done  // 1-cycle pulse after timeout expires with no new data
);

typedef enum {
    IDLE,
    ACTIVE,
    WAIT,  // post-tlast timeout window
    DONE} state_t;

state_t state, state_next;

logic beat;
assign beat = s_axis_tvalid & s_axis_tready;

// Timeout counter
logic [$clog2(TIMEOUT_CYCLES + 1) - 1 : 0] timeout_cnt;
logic timeout_expired;

assign timeout_expired = (timeout_cnt == '0);

always_ff @(posedge clock) begin
    if (i_reset) timeout_cnt <= '0;
    else if (state == ACTIVE && beat && s_axis_tlast) timeout_cnt <= TIMEOUT_CYCLES; // arm on tlast
    else if (state == WAIT && !timeout_expired) timeout_cnt <= timeout_cnt - 1'b1; // count down
    else timeout_cnt <= timeout_cnt; 
end

// state register
always_ff @(posedge clock) begin
    if (i_reset) state <= IDLE;
    else if (i_enable) state <= state_next;
    else state <= state;
end

// state_next-state logic
always_comb begin
    state_next = IDLE;
    unique case (state)
        IDLE:   if (beat)                 state_next = ACTIVE;
                else                      state_next = IDLE;
        ACTIVE: if (beat && s_axis_tlast) state_next = WAIT;
                else                      state_next = ACTIVE;
        WAIT:   if (beat)                 state_next = ACTIVE;   // new frame cancel timeout
                else if (timeout_expired) state_next = DONE;
                else                      state_next = WAIT;
        DONE:                             state_next = IDLE;
    endcase
end

assign done = (state == DONE);

endmodule