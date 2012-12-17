`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:59:25 09/15/2012 
// Design Name: 
// Module Name:    decoder 
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
module decoder(operation, literal, address, instruction, d, BIT);
	output	reg	[5:0]	operation;
	output	reg	[8:0]	literal;
	output	reg	[4:0]	address;
	output	reg			d;
	output	reg	[2:0]	BIT;
	input		[11:0]		instruction;

	parameter ADDWF = 6'd0;
	parameter OTHERS = 6'd1;
	parameter ANDWF = 6'd2;
	parameter CLRF = 6'd3;
	parameter CLRW = 6'd4;
	parameter DECF = 6'd5;
	parameter DECFSZ = 6'd6;
	parameter COMF = 6'd7;
	parameter INCF = 6'd8;
	parameter INCFSZ = 6'd9;
	parameter IORWF = 6'd10;
	parameter MOVF = 6'd11;
	parameter MOVWF = 6'd12;
	parameter RLF = 6'd13;
	parameter RRF = 6'd14;
	parameter SUBWF = 6'd15;
	parameter SWAPF = 6'd16;
	parameter XORWF = 6'd17;
	parameter BCF = 6'd18;
	parameter BSF = 6'd19;
	parameter BTFSC = 6'd20;
	parameter BTFSS = 6'd21;
	parameter ANDWL = 6'd22;
	parameter CALL = 6'd23;
	parameter RETLW = 6'd24;
	parameter GOTO = 6'd25;
	parameter IORLW = 6'd26;
	parameter XORLW = 6'd27;
	parameter MOVLW = 6'd28;
	parameter TRIS = 6'd29;
	parameter OPTION = 6'd30;
	
	always@(*)
	begin
		literal = instruction[8:0];
		d = instruction[5];
		BIT = instruction[7:5];
		address = instruction[4:0];
		casex(instruction[11:6])
			6'b000111:
			begin
				operation = ADDWF;
			end
			
			6'b000101:
			begin
				operation = ANDWF;
			end
			
			6'b000001:
			begin
				if(instruction[5] == 1)
				begin
					operation = CLRF;
				end
				else
				begin
					operation = CLRW;
				end
			end
			
			6'b000011:
			begin
				operation = DECF;
			end
			
			6'b001011:
			begin
				operation = DECFSZ;
			end
			
			6'b001001:
			begin
				operation = COMF;
			end
			
			6'b001010:
			begin
				operation = INCF;		
			end			

			6'b001111:
			begin
				operation = INCFSZ;		
			end

			6'b000100:
			begin
				operation = IORWF;		
			end

			6'b001000:
			begin
				operation = MOVF;			
			end

			6'b000000:
			begin
				if(instruction[5] == 1'b1)
				begin
					operation = MOVWF;		
				end
				else if(instruction[2:0] == 3'd5 || instruction[2:0] == 3'd6 || instruction[2:0] == 3'd7)
				begin
					operation = TRIS;	
				end
				else if(instruction[1:0] == 2'b10)
				begin
					operation = OPTION;	
				end
				else
				begin	//NOP
					operation = OTHERS;		
				end
			end

			6'b001101:
			begin
				operation = RLF;
			end

			6'b001100:
			begin
				operation = RRF;
			end
			
			6'b000010:
			begin
				operation = SUBWF;
			end
			
			6'b001110:
			begin
				operation = SWAPF;
			end
			
			6'b000110:
			begin
				operation = XORWF;
			end
			
			6'b0100xx:
			begin
				operation = BCF;
			end
			6'b0101xx:
			begin
				operation = BSF;
			end
			
			6'b0110xx:
			begin
				operation = BTFSC;
			end
			
			6'b0111xx:
			begin
				operation = BTFSS;
			end
			
			6'b1110xx:
			begin
				operation = ANDWL;
			end
			
			6'b1001xx:
			begin
				operation = CALL;
				address = 5'h02;
				literal = {1'b0,instruction[7:0]};
			end

			6'b1000xx:
			begin
				operation = RETLW;
				address = 5'h02;
			end
			
			6'b101xxx:
			begin
				operation = GOTO;
				address = 5'h02;
			end
			
			6'b1101xx:
			begin
				operation = IORLW;
			end
		
			6'b1111xx:
			begin
				operation = XORLW;
			end
		
			6'b1100xx:
			begin
				operation = MOVLW;
			end
			
			
			
			default:
			begin
				operation = OTHERS;
			end
		endcase
	end
endmodule
