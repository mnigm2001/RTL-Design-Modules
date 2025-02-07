`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/03/2025 11:40:41 PM
// Design Name: 
// Module Name: SevenSegmentDigitSwitchControl
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

/*
    Each Switch Represents a segment of the 7-segment display for a given digit, with led to match switch
*/
module SevenSegmentDigitSwitchControl(
    input logic [0:11] sw,
    output dp,
    output [0:3] an,
    output logic [0:6] seg,
    output logic [0:11] led
);
    // Toggle respective LED: DOESNT WORK
    assign led = sw;
    
    // Drive low DP and 4th segment display
    assign dp = ~sw[7];
    assign an = ~sw[8:11];

    // SW0 - A --> SW6 --> G
    assign seg = ~sw[0:6];
    
    /*
    switch the 5th switch: sw = 001_0000 --> seg = 110_1111
    first 3 switchs: sw = 000_0111 --> seg = 111_1000
    
    110_1111 
    
    */

endmodule
