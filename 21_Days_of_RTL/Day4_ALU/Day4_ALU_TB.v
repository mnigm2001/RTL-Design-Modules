
`timescale 1ns/1ns
`include "Day4_ALU.v"

module day4_tb ();



    logic [7:0]   a_i;
    logic [7:0]   b_i;
    logic [2:0]   op_i;

    logic [7:0]   alu_o;

    day4 DAY4(.*);

    initial begin
        $dumpfile("Day4_ALU_TB.vcd");
        $dumpvars(0, day4_tb);
    end

    initial begin

        for (int i=0; i<10; i++) begin
            a_i = $urandom_range(0, 8'hFF);
            b_i = $urandom_range(0, 8'hFF);
            op_i = $urandom_range(0, 3'b111);
            #5;
        end
        $finish();

    end


    
endmodule