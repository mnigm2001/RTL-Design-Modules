
`timescale 1ns/1ns
`include "Day2_D_FF.v"


module Day2_D_FF_TB ();

  logic     clk;
  logic      reset;

  logic      d_i;

  logic      q_norst_o;
  logic      q_syncrst_o;
  logic      q_asyncrst_o;

  Day2_D_FF DAY2 (.*);

  initial begin
    $dumpfile("Day2_D_FF.vcd");
    $dumpvars(0, Day2_D_FF_TB);
  end

  // Generate clk
  always begin

    clk = 1'b1;
    #5;
    clk = 1'b0;
    #5;
  end

  // Stimulus
  initial begin
    $display("Start of simulation");
    
    reset = 1'b1;
    d_i = 1'b0;
    @(posedge clk);
    reset = 1'b0;
    @(posedge clk);
    d_i = 1'b1;
    @(posedge clk);
    @(posedge clk);
    @(negedge clk);
    reset = 1'b1;
    @(posedge clk);
    @(posedge clk);
    reset = 1'b0;
    @(posedge clk);
    @(posedge clk);
    
    $display("End of simulation");
    
    $finish();

  end

endmodule