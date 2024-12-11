// A simple mux

module MUX #(
  parameter SEL_WIDTH = 2,
  parameter DATA_WIDTH = 8
) (
  input   logic [DATA_WIDTH-1:0]    data_i [ SEL_WIDTH-1:0],
  input   logic [$clog2(SEL_WIDTH)-1:0]         sel_i,
  output  logic [DATA_WIDTH-1:0]    y_o
);

always_comb begin
  y_o = data_i[sel_i];
end
endmodule
