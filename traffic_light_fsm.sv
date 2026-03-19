module traffic_light_fsm #(
    parameter int CLK_FREQ_HZ    = 100,
    parameter int STATE_TIME_SEC = 5
)(
    input  logic clk,
    input  logic reset,

    output logic ns_red,
    output logic ns_yellow,
    output logic ns_green,

    output logic ew_red,
    output logic ew_yellow,
    output logic ew_green
);

    typedef enum logic [1:0] {
        S0_NS_GREEN_EW_RED   = 2'b00,
        S1_NS_YELLOW_EW_RED  = 2'b01,
        S2_NS_RED_EW_GREEN   = 2'b10,
        S3_NS_RED_EW_YELLOW  = 2'b11
    } state_t;

    state_t state, nextstate;

    localparam longint TICKS_PER_STATE = CLK_FREQ_HZ * STATE_TIME_SEC;
    localparam int COUNTER_W = $clog2(TICKS_PER_STATE);

    logic [COUNTER_W-1:0] timer_count;
    logic timer_done;

    assign timer_done = (timer_count == TICKS_PER_STATE - 1);

    // State and timer registers
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state      <= S0_NS_GREEN_EW_RED;
            timer_count <= '0;
        end
        else begin
            state <= nextstate;

            if (state != nextstate)
                timer_count <= '0;
            else if (!timer_done)
                timer_count <= timer_count + 1'b1;
            else
                timer_count <= '0;
        end
    end

    // Next-state logic
    always_comb begin
        nextstate = state;

        case (state)
            S0_NS_GREEN_EW_RED: begin
                if (timer_done)
                    nextstate = S1_NS_YELLOW_EW_RED;
            end

            S1_NS_YELLOW_EW_RED: begin
                if (timer_done)
                    nextstate = S2_NS_RED_EW_GREEN;
            end

            S2_NS_RED_EW_GREEN: begin
                if (timer_done)
                    nextstate = S3_NS_RED_EW_YELLOW;
            end

            S3_NS_RED_EW_YELLOW: begin
                if (timer_done)
                    nextstate = S0_NS_GREEN_EW_RED;
            end

            default: begin
                nextstate = S0_NS_GREEN_EW_RED;
            end
        endcase
    end

    // Output logic
    always_comb begin
        ns_red    = 1'b0;
        ns_yellow = 1'b0;
        ns_green  = 1'b0;

        ew_red    = 1'b0;
        ew_yellow = 1'b0;
        ew_green  = 1'b0;

        case (state)
            S0_NS_GREEN_EW_RED: begin
                ns_green = 1'b1;
                ew_red   = 1'b1;
            end

            S1_NS_YELLOW_EW_RED: begin
                ns_yellow = 1'b1;
                ew_red    = 1'b1;
            end

            S2_NS_RED_EW_GREEN: begin
                ns_red   = 1'b1;
                ew_green = 1'b1;
            end

            S3_NS_RED_EW_YELLOW: begin
                ns_red    = 1'b1;
                ew_yellow = 1'b1;
            end

            default: begin
                ns_green = 1'b1;
                ew_red   = 1'b1;
            end
        endcase
    end

endmodule
