`timescale 1ns/1ns
`include "DFF_LUT.sv"

module DFF_LUT_TB ();

    logic clock;
    logic config_in;
    logic [1:0] select;
    logic MUX_output;

    DFF_LUT #(.WIDTH(16)) DUT (
        .clock(clock),
        .config_in(config_in),
        .select(select),
        .MUX_output(MUX_output)
    );

    initial begin
        $dumpfile("DFF_LUT_TB.vcd");
        $dumpvars(0, DFF_LUT_TB);
    end


    // Stimulus
    initial begin

    end

    initial begin
        config_in = 1'b0;
        select = 2'b0;

        @(posedge clock);
        @(posedge clock);
        config_in = 1'b1;
        @(posedge clock);
        @(posedge clock);
        config_in = 1'b0;
        @(posedge clock);
        @(posedge clock);
        config_in = 1'b1;
        @(posedge clock);
        @(posedge clock);
        config_in = 1'b0;

        @(posedge clock);
        @(posedge clock);
        @(posedge clock);
        select = 2'b10;    

        #40;

        $finish();          
    end

    always begin
        clock = 1'b0;
        #5;
        clock = 1'b1;
        #5;
    end

endmodule