`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/26/2025 09:34:00 PM
// Design Name: 
// Module Name: SevenSegment
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



module SevenSegment(
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

/*
0 - seg = 7'b0000001 7'h1
1 - seg = 7'h1001111 7'h4F
2 - seg = ABGED 7'b0010010 7'h12
3 - seg = ABGCD 7'b0000110 7'h6
4 - seg = BCFG 7'b1001100 7'h4C
5 - seg = ACDFG 7'h0100100 7'h24
6 - seg = 7'b0100000 7'20
7 - seg = ABC 7'b0001111 7'h0F
8 - seg = 7'd0 7'h0
9 - seg = 7'b0010000 0000100 7'h4
*/




/*
    Each Switch Represents a segment of the 7-segment display for a given digit, with led to match switch
*/
//module SevenSegment(
//    input logic [0:6] sw,
//    output dp,
//    output [0:3] an,
//    output logic [0:6] seg,
//    output logic [0:6] led
//);
//    // Toggle respective LED
//    assign led = sw;
    
//    // Drive low DP and 4th segment display
//    assign dp = 1'b0;
//    assign an = 4'h7;

//    /* SW0 - A --> SW6 --> G */
//    assign seg = ~sw;
    
//    /*
//    switch the 5th switch: sw = 001_0000 --> seg = 110_1111
//    first 3 switchs: sw = 000_0111 --> seg = 111_1000
//    */

//endmodule


/*
    Create Module SevenSegmentDigit - represents a single digit
        Automatically translates input numbers to the appropriate
        Parameterized for 4 digits maximum
    TOP: Create Module SevenSegmentControl - controls all 4 digits
*/



