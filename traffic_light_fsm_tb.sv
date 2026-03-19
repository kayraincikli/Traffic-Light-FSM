`timescale 1ns/1ps

module traffic_light_fsm_tb;

    logic clk;
    logic reset;

    logic ns_red;
    logic ns_yellow;
    logic ns_green;

    logic ew_red;
    logic ew_yellow;
    logic ew_green;

    traffic_light_fsm #(
        .CLK_FREQ_HZ(100),
        .STATE_TIME_SEC(5)
    ) dut (
        .clk(clk),
        .reset(reset),
        .ns_red(ns_red),
        .ns_yellow(ns_yellow),
        .ns_green(ns_green),
        .ew_red(ew_red),
        .ew_yellow(ew_yellow),
        .ew_green(ew_green)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1'b1;
        #20;
        reset = 1'b0;

    end

    logic [1:0] prev_state;

    initial begin
        prev_state = 2'bxx;
        $display("Simulation started...");
    end

    always @(posedge clk) begin
        if (reset) begin
            prev_state <= 2'bxx;
        end
        else begin
            if (dut.state != prev_state) begin
                $display("time = %0t ns, state = %0d, NS[R,Y,G]=%b%b%b, EW[R,Y,G]=%b%b%b",
                         $time, dut.state,
                         ns_red, ns_yellow, ns_green,
                         ew_red, ew_yellow, ew_green);
                prev_state <= dut.state;
            end
        end
    end

endmodule
