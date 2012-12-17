`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:38:10 09/15/2012 
// Design Name: 
// Module Name:    DataBus 
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
module DataBus(out, statusIn, ALUIn, registerFileIn, WIn,select, clk);
	output	reg	[7:0] out;
	input				[7:0] statusIn, ALUIn, registerFileIn,WIn;
	input				[3:0]	select;
	input						clk;
	
	parameter W				= 4'd0;
	parameter ALU				= 4'd1;
	parameter registerFile	= 4'd2;
	parameter status			= 4'd3;
	
	
	reg		[7:0] nextData;
	always@(posedge clk)
	begin
		out <= nextData;
	end
	
	always@(select or ALUIn or registerFileIn or statusIn or WIn)
	begin
		case(select)
			ALU:				nextData = ALUIn;
			registerFile:	nextData = registerFileIn;
			status:			nextData = statusIn;
			W:					nextData = WIn;
			default:			nextData = 8'd0;
		endcase
	end
endmodule
