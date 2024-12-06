`timescale 1ns/1ns
`include "Day5_ODD_CNT.v"

module day5_tb ();

    logic clk;
    logic reset;
    logic[7:0] cnt_o;

    day5 UUT (.*);

    initial begin
        $dumpfile("Day5_ODD_CNT_TB.vcd");
        $dumpvars(0, day5_tb);
    end

    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end

    int count_width;
    initial begin
        $display("Starting Simulation");

        reset = 1'b1;
        #10;
        reset = 1'b0;

        // Computer Counter Width
        count_width = $bits(cnt_0);
        $display("cnt width = %d \n", count_width);

        // Count 
        // for (int i=1; i<260; i=i+2) begin
        //     @(posedge clk);
        //     $display("At time %0t. Expected: %0d, Got: %0d", $time, i, cnt_o);
        // end

        $display("End Simulation");
        $finish();

    end

endmodule


// iverilog -g 2012 -o .\Day5_ODD_CNT_TB.vcp .\Day5_ODD_CNT_TB.v
// vvp .\Day5_ODD_CNT_TB.vcp 