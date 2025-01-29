`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2025 02:36:06 PM
// Design Name: 
// Module Name: ClockDivider
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


module ClockDivider #(
    parameter int CLK_RATE = 100_000_000,
    parameter real DIV_FACTOR = 3
    
)(
    input clk_in,
    output clk_out
    );
    /*
        3 -> 1/3 -- 1.5  -> 1/1.5 -> 2/3
        100Mhz/x = DIV_FACTOR
        x = 100MHz/DivFactor
        y = number of bits required to get the factor
        
        TODO: Python - plot the deviation 
    */
    localparam int count_width = $clog2(CLK_RATE/DIV_FACTOR);
    
    logic[0:count_width] count;
    always @(posedge clk_in) count <= count + 1;
    
    assign clk_out = count[count_width];
    
endmodule
