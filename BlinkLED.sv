//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/21/2025 08:18:06 AM
// Design Name: 
// Module Name: BlinkLED
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


//module BlinkLED(
//    input clk,
//    output led
//    );
    
//reg [24:0] count = 0;
 
//assign led = count[24];
 
//always @ (posedge(clk)) count <= count + 1;
//endmodule


//module BlinkLED(
//    input clk,
//    output dp,
//    output [0:3] an,
//    output [0:6] seg
//    );
    
//    assign seg = 7'b1111001;
//    assign an = 4'b1011;
//    assign dp = 1'b0;
//endmodule;


// switch LED ON when switch is turned on
//module BlinkLED (
//    input sw,
//    output led
//);
//    assign led = (sw == 1'b1) ? 1'b1 : 1'b0;

//endmodule


// 7-Segment single bit count
module BlinkLED(
    input logic clk,
    output logic dp,
    output logic [0:3] an,
    output logic [0:6] seg
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
            4'd0: seg = 7'h40;
            4'd1: seg = 7'h79;
            4'd2: seg = 7'h24;
            4'd3: seg = 7'h30;
            4'd4: seg = 7'h19;
            4'd5: seg = 7'h12;
            4'd6: seg = 7'h2;
            4'd7: seg = 7'h78;
            4'd8: seg = 7'h0;
            4'd9: seg = 7'h10;
            default: seg = 7'h40;
        endcase
    end

/*
0 - seg = 7'b1000000 7'h40
1 - seg = 7'b1111001 7'h79
2 - seg = ABGED 7'b0100100 7'h24
3 - seg = ABGCD 7'b0110000 7'h30
4 - seg = BCFG 7'0011001 7'h19
5 - seg = ACDFG 7'0010010 7'h12
6 - seg = 7'b0000010 7'h2
7 - seg = ABC 7'b1111000 7'h78
8 - seg = 7'd0 7'h0
9 - seg = 7'b0010000 7'h10
*/
    
endmodule 


/* switches represent binary number 
    16 switches - 16 bits
    4 7-seg disp 0-9999
    14 bits - 16384
*/




