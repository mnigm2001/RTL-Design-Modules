`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2025 04:32:22 PM
// Design Name: 
// Module Name: FractionalClockDivider
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


module FractionalClockDivider (
    input logic clk_in,
    input logic reset,
    output logic clk_out
);
    localparam int NUMERATOR = 2;
    localparam int DENOMINATOR = 3;
    
    int accumulator = 0;
    logic toggle = 0;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            accumulator <= 0;
            toggle <= 0;
        end else begin
            accumulator <= accumulator + NUMERATOR;
            if (accumulator >= DENOMINATOR) begin
                accumulator <= accumulator - DENOMINATOR; // Keep remainder
                toggle <= ~toggle; // Toggle the output
            end
        end
    end

    assign clk_out = toggle; // Spread pulses evenly
endmodule

