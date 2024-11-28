// A simple mux

module Day1_Mux(
  input   wire [7:0]    a_i,
  input   wire [7:0]    b_i,
  input   wire          sel_i,
  output  wire [7:0]    y_o
);

  // Write your logic here...
  assign y_o = (sel_i == 1'b0) ? a_i : b_i;

endmodule
