`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:17:13 11/30/2012
// Design Name:   PIC16C57
// Module Name:   //192.168.2.1/Term/sources/TB/PIC16C57_TB.v
// Project Name:  Term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PIC16C57
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PIC16C57_TB;

	// Inputs
	reg clk;
	reg rst;

	// Bidirs
	wire [3:0] RA;
	wire [7:0] RB;
	wire [7:0] RC;
	
	reg [3:0] RAIn;
	reg [7:0] RBIn, RCIn;
	
	assign RA = RAIn;
	assign RB = RBIn;
	assign RC = RCIn;
	// Instantiate the Unit Under Test (UUT)
	PIC16C57 uut (
		.RA(RA), 
		.RB(RB), 
		.RC(RC), 
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 1;
		#100
		rst = 0;
		#20000
		RAIn = 4'h1;
		#25000
		RAIn = 4'h0;
		
		
        
		// Add stimulus here

	end
   
	
	always
	begin
		#50
		clk = ~clk;
	end
endmodule

