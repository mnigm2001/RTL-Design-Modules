// Design and verify an 8-bit odd counter

// Interface Definition
// Counter should reset to a value of 8'h1
// Counter should increment by 2 on every cycle
// The module should have the following interface:


// Odd counter

module day5 (
  input     wire        clk,
  input     wire        reset,

  output    logic[7:0]  cnt_o
);

// logic[7:0] cnt;

  // Write your logic here...
  always_ff @ (posedge clk or posedge reset) begin
    if (reset) begin
        cnt_o <= 8'b1;
    end else begin
        cnt_o <= cnt_o + 8'd2;
    end
  end

endmodule
