`timescale 1ns/1ns
// `include "SR.sv"

module SR_TB ();

    logic        clk;
    logic        reset;
    logic        x_i;      
    logic[3:0]   sr_o;

    SR DUT (
        .clk(clk),
        .reset(reset),
        .x_i(x_i),
        .sr_o(sr_o)
    );

    initial begin
        $dumpfile("SR.vcd");
        $dumpvars(0, SR_TB);
    end

    always begin
        #5 clk = 1'b0;
        #5 clk = 1'b1;
    end

    initial begin
        $display("Start Simulation");
        reset = 1'b1;
        x_i = 1'b0;
        @(posedge clk);
        reset = 1'b0;

        for (int i=0; i<10; i++) begin
            @(posedge clk);
            x_i = $urandom_range(1'b1);
            $display("x_i = %d", x_i);
        end
        x_i = 1'b0;
        for (int i=0; i<6; i++) begin
            @(posedge clk);
        end
        $display("Ending Simulation");
        $finish();
    end

    

endmodule