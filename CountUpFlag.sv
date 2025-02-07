`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/03/2025 11:09:06 PM
// Design Name: 
// Module Name: CountUpFlag
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


module CountUpFlag #(
    parameter int CLK_RATE = 100_000_000,
    parameter int DIV_FACTOR = 2
)(
    input logic clk,
    output logic [$clog2(integer'(CLK_RATE/DIV_FACTOR)):0] count
    );
//    localparam WIDTH = $clog2(integer'(CLK_RATE/DIV_FACTOR));
    localparam COUNT_MAX = integer'(CLK_RATE/DIV_FACTOR);
    
    // 1/DIV_FACTOR of a second for the given CLK_RATE
    always @(posedge clk) begin
        if (count >= COUNT_MAX) begin
            count <= 0;
        end
        count <= count + 1;
    end
    
    
endmodule
