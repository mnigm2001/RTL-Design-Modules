// A simple TB for mux
`timescale 1ns/1ns
// `include "MUX.sv"

module MUX_TB ();

  // NEW: Parameterized
  parameter int SEL_WIDTH = 2;
  parameter int DATA_WIDTH = 8;

  logic [DATA_WIDTH-1:0] data_i [SEL_WIDTH-1:0];
  logic [$clog2(SEL_WIDTH)-1:0] sel_i;
  logic [DATA_WIDTH-1:0] y_o;


  MUX #(.SEL_WIDTH(SEL_WIDTH), .DATA_WIDTH(DATA_WIDTH)) UUT (
    .data_i(data_i),
    .sel_i(sel_i),
    .y_o(y_o)
  );
  
  initial begin
    $dumpfile("MUX_TB.vcd");
    $dumpvars(0, MUX_TB);
    for (int i=0; i<SEL_WIDTH; i++) begin
      $dumpvars(0, MUX_TB.data_i[i]);
    end
  end

  initial begin
    for (int i = 0; i < 40; i++) begin
      for (int j = 0; j < SEL_WIDTH; j++) begin
        data_i[j]   = $urandom_range (0, 8'hFF);
      end
      sel_i = $urandom%SEL_WIDTH;
      #5;
    end
    $finish();
  end

endmodule