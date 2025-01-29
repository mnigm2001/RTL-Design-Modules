`timescale 1ns/1ns

// Simple shift register
module SR(
  input     logic        clk,
  input     logic        reset,
  input     logic        x_i,      // Serial input

  output    logic[3:0]   sr_o
);

  logic[3:0] shift_reg;
  logic[3:0] shift_reg_next;
  
  always_ff @ (posedge clk or posedge reset) begin
    if (reset)
    	shift_reg <= 4'd0;
    else
        // shift_reg[3] <= x_i;
        // shift_reg <= {shift_reg[3:1]};
        shift_reg <= {x_i, shift_reg[3:1]};
        shift_reg_next <= shift_reg;
  end
  
  assign sr_o = shift_reg_next;

endmodule
