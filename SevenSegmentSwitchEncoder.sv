`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 12:22:10 AM
// Design Name: 
// Module Name: SevenSegmentSwitchEncoder
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


module SevenSegmentSwitchEncoder(
    input logic [0:8] sw,
    output dp,
    output [0:3] an,
    output logic [0:6] seg,
    output logic [0:8] led
);
    // Toggle respective LED: DOESNT WORK
    assign led = sw;
    
    // Drive low DP and 4th segment display
    assign dp = ~sw[4];
    assign an = ~sw[5:8];
    
    /*
    switch the 5th switch: sw = 001_0000 --> seg = 110_1111
    first 3 switchs: sw = 000_0111 --> seg = 111_1000
    
    Switch 4th switch: sw = b'1000 d'8 
    
    */
    
    always_comb begin
        case (sw[3:0])
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
