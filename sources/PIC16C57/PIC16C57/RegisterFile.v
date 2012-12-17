`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:01:04 10/06/2012 
// Design Name: 
// Module Name:    testMemory 
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
module RegisterFile(out, statusOut, PCOut, portAOut, portBOut, portCOut, PCHOut, dataIn, statusIn, PCHIn, portAIn, portBIn, portCIn, StatusEn, addressIn, write, PCInc, clk, rst);
	output	reg	[3:0] portAOut;
	output	reg	[7:0]	out, portBOut, portCOut;
	output	reg	[2:0]	PCHOut;
	output	reg	[7:0]	statusOut;
	output			[10:0]	PCOut;
	input				[7:0]	dataIn, statusIn;
	input				[3:0]	portAIn;
	input				[7:0] portBIn, portCIn;
	input				[2:0]	PCHIn;
	input				[4:0]	addressIn;
	input						write, PCInc, StatusEn, clk, rst;
	
	reg	[7:0]	memoryArray[127:0];
	
	assign PCOut = {PCHOut, memoryArray[8'h02]};
	
	parameter INDF_ADDR = 7'h00;
	parameter TMR0_ADDR = 7'h01;
	parameter PCL_ADDR = 7'h02;
	parameter STATUS_ADDR = 7'h03;
	parameter FSR_ADDR = 7'h04;
	parameter PORTA_ADDR = 7'h05;
	parameter PORTB_ADDR = 7'h06;
	parameter PORTC_ADDR = 7'h07;
	
	wire	[7:0]	FSROut = memoryArray[FSR_ADDR];
	reg	[7:0]	address;
	
	reg [7:0]	temp;
	
	integer index;
	reg	[7:0]	currentState;
	always@(FSROut[6:5] or addressIn or memoryArray[FSR_ADDR])
	begin
		address = {FSROut[6:5],addressIn};
		if(addressIn == 5'b00000)
		begin
			address = memoryArray[FSR_ADDR];
		end
		if(FSROut[6:5] == 2'b01 || FSROut[6:5] == 2'b10 || FSROut[6:5] == 2'b11)
		begin
			if(5'h00 <= addressIn && addressIn <= 5'h0F)
			begin
				address = {2'b00,addressIn};
			end
		end
	end
	
	always@(posedge clk)
	begin
		currentState <= memoryArray[address];
		if(rst)
		begin
			for(index = 0 ; index < 128 ; index = index + 1)
			begin
				if(index != PCL_ADDR) memoryArray[index] <= 8'd0;
			end
			memoryArray[PCL_ADDR] <= 8'd0;
			PCHOut <= 3'd0;
		end
		else
		begin
			if(write)
			begin
				memoryArray[address] <= dataIn;
				case(address)
					PCL_ADDR:
						PCHOut <= PCHIn;
					STATUS_ADDR:
					begin
						for(index = 0 ; index < 8 ; index = index + 1)
						begin
							if(currentState[index] != dataIn[index])
							begin
								currentState[index] <= dataIn[index];
							end
						end
						memoryArray[address] <= currentState;
					end					
				endcase
			end
			else
			begin
				if(PCInc)
				begin
					{PCHOut, memoryArray[PCL_ADDR]} <= {PCHOut, memoryArray[PCL_ADDR]} + 11'd1;
				end
				else if(StatusEn)
				begin
					memoryArray[STATUS_ADDR] <= statusIn;					
				end
			end
		end
		case(address)
			PORTA_ADDR:
				out <= {4'b0000,portAIn};
			PORTB_ADDR:
				out <= portBIn;
			PORTC_ADDR:
				out <= portCIn;
			default:
				out <= memoryArray[address];
		endcase		
		
	end
	
	always@(memoryArray[8'h05] or memoryArray[8'h06] or memoryArray[8'h07])
	begin
		temp = memoryArray[8'h05];
		portAOut = temp[3:0];
		portBOut = memoryArray[8'h06];
		portCOut = memoryArray[8'h07];
	end
	
	always@(memoryArray[8'h03])
	begin
		statusOut = memoryArray[8'h03];
	end
	

endmodule
