`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2025 02:34:32 PM
// Design Name: 
// Module Name: SevenSegmentControl
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



module SevenSegmentControl(
    input clk,
    output dp,
    output [0:3] an,
    output logic [0:6] seg
    );
    
    logic clk_1of3;
    ClockDivider #() ClockDivider_3 (
        .clk_in(clk),
        .clk_out(clk_1of3)
    );
    
    // Clock Divide: 1/3 of a second for 100Mhz clk
    logic [24:0] clk_2of3 = 0;
    always @(posedge clk) clk_2of3 <= clk_2of3 + 1;

    // Count from 0-9 - 4 bits
    logic [3:0] count = 0;
    always @ (posedge clk_2of3[24]) count <= count + 1;
    
    // Drive low DP and 4th segment display
    assign dp = 1'b0;
    assign an = 4'h7;
    
    always_comb begin
        case (count)
            4'd0: seg = 7'h1;
            4'd1: seg = 7'h4F;
            4'd2: seg = 7'h12;
            4'd3: seg = 7'h6;
            4'd4: seg = 7'h4C;
            4'd5: seg = 7'h24;
            4'd6: seg = 7'h20;
            4'd7: seg = 7'hF;
            4'd8: seg = 7'h0;
            4'd9: seg = 7'h4;
            default: seg = 7'h7F;
        endcase
    end    
    
    
endmodule
