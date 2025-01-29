
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/21/2025 10:14:01 PM
// Design Name: 
// Module Name: BlinkLEDTB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//`timescale 1ns/1ps

//module BlinkLEDTB();
//    logic clock;
//    logic dp;
//    logic [0:3] an;
//    logic [0:6] seg;

//    // Instantiate the DUT
//    BlinkLED DUT (
//        .clock(clock),
//        .dp(dp),
//        .an(an),
//        .seg(seg)
//    );

//    // Generate the clock
//    always begin
//        clock = 1'b0;
//        #5;
//        clock = 1'b1;
//        #5;
//    end

//    // Monitor outputs
//    initial begin
//        $display("Starting Simulation");
//        $monitor("Time: %0t | seg: %0h | count: %0d", $time, seg, DUT.count);
//        #500000000; // Extend simulation duration (e.g., 500 ms)
//        $finish;
//    end
//endmodule



