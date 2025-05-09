`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2025 06:38:11 PM
// Design Name: 
// Module Name: ClockDividerTB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ClockDividerTB();

    logic clk_in;
    logic [2:0] clk_out;  // Array for outputs of each DUT instance

    // Clock generation
    always begin
        clk_in = 1'b0;
        #5;
        clk_in = 1'b1;
        #5;
    end

    // Generate block for instantiating DUTs
    genvar i;
    generate
        for (i = 0; i < 3; i = i + 0.5) begin : DUT_INSTANCES
            ClockDivider #(.DIV_FACTOR(i + 2.0)) DUT (
                .clk_in(clk_in),
                .clk_out(clk_out[i])
            );
        end
    endgenerate

    // Monitor the outputs
    initial begin
        $monitor("Time: %0t | clk_out[0]: %b | clk_out[1]: %b | clk_out[2]: %b", $time, clk_out[0], clk_out[1], clk_out[2]);
        #100 $finish;
    end
    
endmodule


 /*
    TODO:
        Is it better to have the ratios as parameters or what?
        best methods for testing?
    
        generating clocks methods
            How does the timescale directive work with each
        Arrays for stimulus
        threads
    */
