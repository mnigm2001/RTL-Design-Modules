`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 07:07:00 PM
// Design Name: 
// Module Name: top
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


module top();
    logic clk;
    logic [3:0] addr;
    logic [7:0] data_o;
    
    ROM_16_by_8 ROM(
        .clk(clk),
        .addr(addr),
        .data_o(data_o)
    );
endmodule

//module ROM #(
//    parameter WIDTH=8,
//    parameter LENGTH=32
//)(
//    input logic [] addr_i,
//    output logic [] data_o
//);
//endmodule

/*
Design a 16x8-bit ROM (16 words, 8 bits each). The ROM should be initialized with a predefined program 
    (e.g., a simple 8-bit counter pattern from 0x00 to 0x0F). The output should be synchronous to a clock input.
Inputs:
clk (1-bit)
addr (4-bit input)

Output:
data_out (8-bit)

Requirement:
Read is synchronous: data_out updates on the rising edge of clk.
*/

`define ROM_INIT_RANDOM_UNSEEDED
//`define ROM_INIT_MEM_FILE

module ROM_16_by_8 (
    input logic clk,
    input logic [3:0] addr,
    output logic [7:0] data_o
);
    logic [7:0] ROM [0:15];
    
    // Initialize ROM
    `ifdef ROM_INIT_RANDOM_UNSEEDED
        initial foreach(ROM[i]) ROM[i] = $random;
     `elsif ROM_INIT_MEM_FILE
        initial  begin
            $readmemh("../../../srcs/sources_1/imports/new/rom_init.mem", ROM);
            #10;
            for (int i = 0; i < 16; i++)
                $display("ROM[%0d] = %h", i, ROM[i]);
        end 
     `else
        initial ROM = '{8'h4F, 8'h33, 8'h1A, 8'h03, 8'hDE, 8'hAD, 8'hBE, 8'hEF, 8'hFA, 8'hCE, 8'hAD, 8'hD1, 8'h36, 8'h99, 8'h5A, 8'h81};
     `endif
    
    always @(posedge clk) data_o <= ROM[addr];      

endmodule

/*

Problem Statement:

Build a priority arbiter module.
It takes N request signals (req[N-1:0]) as inputs.
It outputs a grant signal (grant[N-1:0]) where exactly one grant is HIGH, corresponding to the highest-priority request (priority = lowest index).
If multiple requests are HIGH, grant the lowest index one.
If no request is active, no grant should be asserted (all zeros).

Requirements:
N should be parameterized (not hardcoded).
Synchronous: grant decision updated on the positive edge of clk.
Reset (reset_n, active low) should clear all grants.

Example Behavior (N = 4)
req	      grant
4'b0000	4'b0000
4'b0001	4'b0001
4'b1010	4'b0010
4'b1100	4'b0100
(req[1] gets priority over req[2], etc.)

*/

module prio_arbiter #(
    parameter int N = 4
) (
    input logic clk,
    input logic reset_n,
    input logic [N-1:0] req,
    output logic [N-1:0] grant   
);
    
    logic [$clog2(N)-1:0] count;
    always @ (posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            grant <= '0;
        end else begin
            grant <= '0;
            if (req != 0) begin
                grant[count] <= 1;
            end 
        end
 end
    
    always_comb begin
        count = 0;   
        for (int i=0; i<N; i++) begin
            if(req[i] == 1) begin
                count = i;
                break;
            end
        end
    end
    
endmodule 



/*
    GOAL: Find the lowest index '1 within an N-Width vector
    Approach 1: Shift + count -- too many clock cycles
        count reg WIDTH = N-1
    Approach 2: prio encoder -- scalability?
        
    E.g. req = 4'b1010
    req AND 1111   1010
    req XOR 1
    
     if (req[count] == 1'b1) begin
                grant <= count;
                count <= 0;
            end
            else count <= count + 1; 
        end
    
*/