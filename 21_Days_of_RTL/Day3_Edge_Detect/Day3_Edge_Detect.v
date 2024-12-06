 // An edge detector

module day3 (
  input     wire    clk,
  input     wire    reset,

  input     wire    a_i,

  output    wire    rising_edge_o,
  output    wire    falling_edge_o,
  output    wire    dual_edge_o
);

 logic d_q;
// rising edge detector
 always_ff @ (posedge clk or posedge reset) begin
    if(reset) begin
        d_q <= 1'b0;
    end else begin
        d_q <= a_i;
    end
 end

 assign rising_edge_o = a_i & (!d_q);
 assign falling_edge_o = (!a_i) & d_q;
 assign dual_edge_o = a_i ^ d_q;


//falling edge detector

  
endmodule
