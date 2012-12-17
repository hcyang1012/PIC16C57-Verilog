`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:49 09/18/2012 
// Design Name: 
// Module Name:    Stack 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Stack(out, in, instruction, clk, rst);
	output	reg	[10:0]	out;
	input				[10:0]	in;
	
	input				[1:0]		instruction;
	input							clk, rst;
	
	
	parameter	PUSH	= 2'd0;
	parameter	POP	= 2'd1;
	parameter	S_NO	= 2'd2;
	
	
	wire	[10:0]	level1Out;
	reg	[10:0]	level1In;
	reg 				level1En, level2En;
	
	always@(level1Out)
	begin
		out = level1Out;
	end
	Register11Bit stack_level1 (
		 .out(level1Out), 
		 .in(level1In), 
		 .rst(rst), 
		 .en(level1En), 
		 .clk(clk)
		 );
	
	wire	[10:0]	level2Out;
	reg	[10:0]	level2In;
	

	Register11Bit stack_level2 (
		 .out(level2Out), 
		 .in(level2In), 
		 .rst(rst), 
		 .en(level2En), 
		 .clk(clk)
		 );

	always@(instruction or in or level1Out or level2Out)
	begin
		level1In = 11'b0;
		level2In = 11'b0;
		
		level1En = 1'b0;
		level2En = 1'b0;
		
		case(instruction)
			PUSH:
			begin
				level1In = in;
				level2In = level1Out;
				
				level1En = 1'b1;
				level2En = 1'b1;
			end
			POP:
			begin
				level1In = level2Out;

				level1En = 1'b1;
				level2En = 1'b0;
			end
			default:
			begin
				
			end
		endcase
	end
	

endmodule