`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:14:56 09/15/2012 
// Design Name: 
// Module Name:    ALU 
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
module ALU(out, Z, DC, Cout, test, A, B, Cin, command);
	output	reg	[7:0]	out;
	output	reg			Z, DC, Cout, test;
	input				[7:0] A,B;
	input				[7:0]	command;
	input						Cin;
	
	
	reg 	[4:0]	temp;
	
	//ALU Commands
	parameter AplusB = 8'd0;
	parameter AminusB = 8'd1;
	parameter AandB = 8'd2;
	parameter AxorA = 8'd3;
	parameter Bsub1 = 8'd4;
	parameter Bcomp = 8'd5;
	parameter Bplus1 = 8'd6;
	parameter AorB = 8'd7;
	parameter Bout = 8'd8;
	parameter Aout = 8'd9;
	parameter RLF	= 8'd10;
	parameter RRF	= 8'd11;
	parameter BsubA = 8'd12;
	parameter swapB = 8'd13;
	parameter AxorB = 8'd14;
	parameter BCF = 8'd15;
	parameter BSF = 8'd16;
	parameter BTest = 8'd17;
	
	always@(*)
	begin
		Cout = 1'b0;
		temp = 4'b0000;
		test = (B[A[2:0]] == 1'b0);
		out = 8'd0;
		DC = 1'd0;
		case(command)
			AplusB:
			begin
				{Cout,out} = A + B;
				temp = A[3:0] + B[3:0];
				DC = temp[4];
			end
			AminusB:
			begin
				out = A - B;
			end
			AandB:
			begin
				out = A & B ;
			end
			AxorA:
			begin
				out = A ^ A ;
			end
			Bsub1:
			begin
				out = B - 8'd1 ;
			end
			Bcomp:
			begin
				out = ~B;
			end
			Bplus1:
			begin
				out = B + 8'd1;
			end
			AorB:
			begin
				out = A | B;
			end
			Bout:
			begin
				out = B;
			end
			Aout:
			begin
				out = A;
			end	
			RLF:
			begin
				{Cout,out} = {B,Cin};
			end			
			RRF:
			begin
				{Cout,out} = {B[0],Cin,B[7:1]};
			end		
			BsubA:
			begin
				out = B - A;
				temp = B[3:0] - A[3:0];
				DC = temp[4];
				if(out[7] == 1)
					Cout = 1'b0;
				else
					Cout = 1'b1;
			end
			swapB :
			begin
				out = {B[3:0], B[7:4]};
			end
			AxorB :
			begin
				out = B ^ A ;
			end
			BCF :
			begin
				out = B;
				out[A[2:0]] = 1'b0;
			end
			BSF :
			begin
				out = B;
				out[A[2:0]] = 1'b1;
			end	

			BTest :
			begin
				out = B;
				test = (B[A[2:0]] == 1'b0);
			end
		endcase
	end

	always@(out)
	begin
		if(out == 8'd0)
		begin
			Z = 1'b1;
		end
		else
		begin
			Z = 1'b0;
		end
		
	end
		
	
endmodule
