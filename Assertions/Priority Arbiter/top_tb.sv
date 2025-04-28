`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 07:03:05 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();

//    packed_array_3d packed_array_3d_test();
//    my_packed_array_3d my_packed_array_3d_test();
//    packed_unpacked_mix packed_unpacked_mix_test();
//    ROM_16_by_8_tb ROM_16_by_8_test();
    prio_encoder_tb prio_encoder_test();
endmodule


module copy_and_compare_array ();
    int arr1[5];
    int arr2[5];
    int status;
    initial begin
        foreach(arr1[i]) arr1[i] = $random;
        arr2 = arr1;
        status = (arr1 == arr2);
        $display("arr1 = %0p arr2 = %0p status = %0d" , arr1, arr2, status);
    end
endmodule

module packed_array_3d ();
    bit [2:0][3:0][7:0] m_data;
	initial begin
		m_data[0] = 32'hface_cafe;
		m_data[1] = 32'h1234_5678;
		m_data[2] = 32'hcade_fade;
		
		$display ("m_data = 0x%0h", m_data);
        foreach (m_data[i]) begin
          $display ("m_data[%0d] = 0x%0h", i, m_data[i]);
          foreach (m_data[i][j]) begin
            $display ("m_data[%0d][%0d] = 0x%0h", i, j, m_data[i][j]);
          end
        end
	end
endmodule


module my_packed_array_3d();
	bit [2:0][3:0][7:0] m_data;
	initial begin
		m_data[0] = 32'hface_cafe;
		m_data[1] = 32'h1234_5678;
        m_data[2] = 32'hcade_fade;
        $display ("m_data = %0h", m_data);
        $display("size1 = %0d | size2 = %0d | size3 = %0d", $size(m_data), $size(m_data[0]), $size(m_data[0][0]));
        for (int i=0; i<$size(m_data); i++) begin
            for (int j=0; j<$size(m_data[i]); j++) begin
              $display ("m_data[%0d][%0d] = %0h", i, j, m_data[i][j]);
            end
        end 
    end
endmodule


module packed_unpacked_mix();
  bit [3:0][7:0] 	stack [2][4]; 		// 2 rows, 4 cols

	initial begin
		// Assign random values to each slot of the stack
		foreach (stack[i])
            foreach (stack[i][j]) begin
                foreach (stack [i][j][k]) begin
                    stack[i][j][k] = $random;
                    $display ("stack[%0d][%0d][%0d] = 0x%0h", i, j, k,  stack[i][j][k]);
                end
            end 

		// Print contents of the stack
		$display ("stack = %p", stack);

		// Print content of a given index
        $display("stack[0][0][2] = 0x%0h", stack[0][0][2]);
	end
endmodule


module ROM_16_by_8_tb ();
    
    localparam int WIDTH = 8;
    localparam int DEPTH = 16;

    logic clk=0;
    logic [$clog2(DEPTH)-1:0] addr = 0;
    logic [WIDTH-1:0] data_o;
    
    ROM_16_by_8 DUT (
        .clk(clk),
        .addr(addr),
        .data_o(data_o)
    );
    
    logic [WIDTH-1:0] rom_copy [0:DEPTH-1]; // Shadow copy captured in first pass
    logic trigger_check;
    
    ROM_immutability_checker #(
        .WIDTH(8), 
        .DEPTH(16)
    ) rom_checker (
        .clk(clk),
        .observed_rom(rom_copy),
        .trigger_check(trigger_check)
    );
    
    
    always #5 clk = ~clk;
    
    initial begin
        
        @(posedge clk);
        trigger_check = 0;
    
        #100;
        for (int i=0; i<DEPTH; i++) begin
            addr = i;
            @(posedge clk);
            $display("%0t | data_o[%0d] = 0x%0h", $time, i, data_o);
            
            // Populate ROM copy for checker
            rom_copy[i] = data_o;
        end
        
        @(posedge clk);
        trigger_check = 1;
        
        #100;
        $finish;
    end
endmodule

/*
    
*/
module ROM_immutability_checker #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 16
) (
    input logic clk,
    input logic [WIDTH-1:0] observed_rom [0:DEPTH-1],
    input logic trigger_check
);
    logic [WIDTH-1:0] baseline_rom [0:DEPTH-1];
    bit initialized = 0;
    
    always @(posedge clk) begin
        if(!initialized) begin
            for (int i=0; i<DEPTH; i++)
                baseline_rom[i] <= observed_rom[i];
            initialized <= 1;
        end else if (trigger_check) begin
            for (int i=0; i<DEPTH; i++) begin
                assert (baseline_rom[i] == observed_rom[i])
                    else $fatal("%0t | ROM immutability violated at index %0d: expected %h, got %h", $time, i, baseline_rom[i], observed_rom[i]);
            end
        end
            
    
    end
    
endmodule 


module prio_encoder_tb ();

    localparam int N = 4;
    
    logic clk=0, reset_n=1;
    logic [N-1:0] req, grant;
    
    prio_arbiter #(
        .N(N)
    ) DUT (
        .clk(clk),
        .reset_n(reset_n),
        .req(req),
        .grant(grant)
    );
    
    always #5 clk=~clk; 
    
    initial begin
        reset_n = 1'b0;
        req = '0;
        #3;
        reset_n = 1'b1;
        @(negedge clk);
        
        for (int i=0; i<20; i++) begin
            $display("%t | req:%0b", $time, req);
            req = $random;
            @(posedge clk);
            $display("grant:%0b", grant);
        end
        #10;
        $finish();
    end
    
    //During reset, grant must be all zeros.
    /*
    Problem: Only checks WHEN the reset is triggered, not during reset
    property reset_grant;
        @(negedge reset_n) ($countones(grant) == 0);
    endproperty
    
    Good, but the one used is better
    property p_reset_clears_grant;
        @(posedge clk) (!reset_n) |-> (grant == 0);
    endproperty
    */
    property reset_behavior;
        @(posedge clk) disable iff (!reset_n)
        (grant == '0);
    endproperty
    assert property (reset_behavior);
    else $error(1, "[prio_encoder_tb][property_name] Assertion Failed: <describe violation> -- relevant signals=%b %b, time=%0t", signal1, signal2, $time);
    
    // At most one grant bit is HIGH at any clock cycle.
    /*
    Problem:
        ❗ Fails if grant is all zeros (grant = 0).
        In your arbiter design, it is legal for grant to be all 0 if no req is active.
        Thus: If you use $onehot(grant), you'll fail valid "idle" cycles when no request is pending.
    property one_hot_grant;
        @(posedge clk) disable iff (!reset_n)
        ($onehot(grant));
    endproperty
    We could instead do:
    property p_one_hot_grant_nonzero;
        @(posedge clk) disable iff (!reset_n)
        ( (grant == 0) || $onehot(grant) );
    endproperty
    */
    property one_hot_grant;
        @(posedge clk) disable iff (!reset_n)
        ($countones(grant) <= 1);    
    endproperty
    assert property (one_hot_grant);
    
    // If multiple req[i] are high, the grant must match the lowest index request.
    function automatic logic [N-1:0] expected_grant(input logic [N-1:0] req);
        expected_grant = '0;
        for(int i=0; i<N; i++) begin
            if(req[i] == 1) begin
                expected_grant = i;
                break;
            end
        end
    endfunction 
 
    property lowest_index_grant;
        @(posedge clk) disable iff (!reset_n)
        (grant == expected_grant(req));
    endproperty
    assert property (lowest_index_grant);
    
    // If all req bits are 0, grant must be 0.
    property all_req_bits_zero;
        @(posedge clk) disable iff(!reset_n)
        (!req |-> !grant);
    endproperty
    assert property (all_req_bits_zero);
    /*  Perfectly fine
        Alternatives:
            property all_req_grant_zero;
            @(posedge clk) disable iff (!reset_n)
            ( (req == '0) |-> (grant == '0) );
        endproperty
        property all_req_bits_zero_explicit;
            @(posedge clk) disable iff (!reset_n)
            (~(|req)) |-> (~(|grant));
        endproperty
    */
    
    
    // Once a grant is asserted, if req remains stable, grant should also stay stable (optional, extra polish).
    property grant_stability;
        @(posedge clk) disable iff (!reset_n)
        (($past(req) == req) |-> ($past(grant) == grant));
    endproperty
    /*
        Alternative:
        property grant_stability_stable;
            @(posedge clk) disable iff (!reset_n)
            ($stable(req)) |-> ($stable(grant));
        endproperty
    */
    assert property (grant_stability);
    


endmodule




