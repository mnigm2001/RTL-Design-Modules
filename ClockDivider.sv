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
    parameter int DIV_FACTOR = 2
    
)(
    input logic reset,
    input logic clk_in,
    output logic clk_out
    );
    
    logic[$clog2(DIV_FACTOR)-1:0] count = 0;
    always @(posedge clk_in or posedge reset) begin
     if (reset) begin
        count <= 0;
        clk_out <= 1'b1;
     end else begin
     
        if (count == (DIV_FACTOR-1)) begin
            clk_out <= 1'b1;
            count <= 0;
        end
        else begin 
            clk_out <= 1'b0;
            count <= count + 1;
        end
    end 
    end
    
endmodule


/*
        3 -> 1/3 -- 1.5  -> 1/1.5 -> 2/3
        100Mhz/x = DIV_FACTOR
        x = 100MHz/DivFactor
        y = number of bits required to get the factor
        
        TODO: Python - plot the deviation 
    */