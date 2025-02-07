`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 09:09:22 PM
// Design Name: 
// Module Name: ButtonDebounceSRFiltering
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

/* This module debounces the momentary pushbuttons. When a button is pressed,
    the button data is buffered into a shift reg, the output is the union of the sr */
module ButtonDebounceSRFiltering #(
    parameter int SR_DEPTH = 100_000
)(
    input logic clk,
    input logic btnC,
    output logic btnCDeb
    );
    
    /* Shift Left */
    logic [SR_DEPTH:0] shiftReg = 0;
    always @(posedge clk) shiftReg <= {shiftReg[9:0], btnC};
    
    assign btnCDeb = &shiftReg;
    
endmodule
