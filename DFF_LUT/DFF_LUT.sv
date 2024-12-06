`timescale 1ns/1ns

module DFF_LUT #(
    parameter WIDTH = 4
)(
    input logic clock,
    // input logic reset,

    input logic config_in,
    input logic [$clog2(WIDTH)-1:0] select,

    output logic MUX_output
);


logic [WIDTH-1:0] shift_reg;

always_ff @ (posedge clock) begin
    // if (reset)
    shift_reg <= {shift_reg[WIDTH-2:0], config_in};
end

always_comb begin
    MUX_output = shift_reg[select];
end

endmodule