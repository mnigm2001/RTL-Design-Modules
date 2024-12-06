`timescale 1ns/1ns
`include "Day3_Edge_Detect.v"

module day3_tb ();

    logic clk;
    logic reset;

    logic a_i;

    logic rising_edge_o;
    logic falling_edge_o;
    logic dual_edge_o;

    day3 DAY3(.*);

    initial begin
        $dumpfile("Day3_Edge_Detect_TB.vcd");
        $dumpvars(0, day3_tb);
        $dumpvars(0, DAY3.d_q); // Add internal register d_q to the dump
    end

    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end

    initial begin
        $display("Starting Simulation \n");

        reset = 1'b1;
        a_i = 1'b0;
        @(posedge clk);
        reset = 1'b0;
        // @(posedge clk);
        // a_i = 1'b1;
        // @(posedge clk);
        // @(posedge clk);
        // @(posedge clk);
        // a_i = 1'b0;
        // @(posedge clk);
        // @(posedge clk);
        // a_i = 1'b1;
        // @(posedge clk);
        // @(posedge clk);
        // @(negedge clk);
        // a_i = 1'b0;
        // @(posedge clk);
        // @(posedge clk);

        #7;
        a_i = 1'b1;
        #10;
        a_i = 1'b0;
        #10;
        a_i = 1'b1;
        #10;
        a_i = 1'b0;
        #3;


        $display("Simulation Complete");
        $finish();

    end
endmodule