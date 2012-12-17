`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:15:40 11/30/2012
// Design Name:   DoorLock
// Module Name:   //192.168.2.1/Term/sources/TB/TB.v
// Project Name:  Term
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DoorLock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB;

	// Inputs
	reg [3:0] scanData;
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] out;
	wire [3:0] motorControl;
	wire [2:0] columnSel;

	// Instantiate the Unit Under Test (UUT)
	DoorLock uut (
		.out(out), 
		.motorControl(motorControl), 
		.columnSel(columnSel), 
		.scanData(scanData), 
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		scanData = 0;
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

