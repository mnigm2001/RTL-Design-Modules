// A simple TB for mux
`timescale 1ns/1ns
`include "Day1_Mux.v"

module Day1_MUX_TB ();

  logic [7:0] a_i;
  logic [7:0] b_i;
  logic       sel_i;
  logic [7:0] y_o;

  Day1_Mux DAY1 (.*);
  
  
  initial begin
    $dumpfile("Day1_MUX_TB.vcd");
    $dumpvars(0, Day1_MUX_TB);

  end

  initial begin
    for (int i = 0; i < 10; i++) begin
      a_i   = $urandom_range (0, 8'hFF);
      b_i   = $urandom_range (0, 8'hFF);
      sel_i = $random%2;
      #5;
    end
    $finish();
  end

endmodule