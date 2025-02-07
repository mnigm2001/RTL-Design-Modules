`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2025 08:32:37 PM
// Design Name: 
// Module Name: ButtonDebounceCounter
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
    it counts up to a given number of clock cycles before registering the next push */
module ButtonDebounceCounter #(
    parameter int N_CYC_DEB = 300_000
)(
    input logic clk,
    input logic btnC,
    output logic btnCDeb
    );
    
    /* Buffer btnC Detect Rising Edge */
    logic btnCBuf = 0;
    always @(posedge clk) btnCBuf <= btnC;
    
    /* Detect Rising Edge */
    logic countEn;
    assign countEn  = !btnCBuf && btnC;
    
    /* Count up to Number of Cycles */
    logic [$clog2(N_CYC_DEB):0] count = 0;
    always @(posedge clk) begin
        if (countEn) begin
            count <= count + 1;
            if (count >= N_CYC_DEB) count <= 0;
        end
    end
endmodule
