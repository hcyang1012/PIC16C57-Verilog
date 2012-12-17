`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:04:33 09/14/2012 
// Design Name: 
// Module Name:    Datapath 
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
module Datapath(RA, RB, RC, currentInstruction, d, statusOut, PCInc, statusEn, irEn, wEn, rfEn, trisEn, wSel, rfSel, ALUInst, portAIn, portBIn, portCIn, databusSelect, stackInstruction,ASel, clk, rst);
	output	reg		[3:0]	RA;
	output	reg		[7:0] RB, RC;
	output		[5:0]			currentInstruction;
	output					d;
	output			[7:0]	statusOut;
	input						PCInc, statusEn, irEn, wEn, rfEn, trisEn ;
	input				[7:0]	ALUInst;
	input				[3:0]	portAIn;
	input				[7:0]	portBIn, portCIn;
	input						wSel;
	input				[1:0]	rfSel;
	input 			[3:0]	databusSelect;
	input				[1:0]	stackInstruction;
	input 					clk, rst;
	input				[1:0]	ASel;
	
	
	wire [10:0]	PCOut;
	reg trisAEn, trisBEn, trisCEn ;
		 
		 
	//Data Bus
	wire	[7:0]	databus_out;
	wire	[7:0] databus_ALUOut;
	wire	[7:0] databus_RegisterFileOut;
	wire	[7:0]	databus_statusOut;
	wire	[7:0]	databus_wOut;
	wire	[2:0]	b;
	
	DataBus databus (
		 .out(databus_out), 
		 .ALUIn(databus_ALUOut), 
		 .registerFileIn(databus_RegisterFileOut), 
		 .statusIn(databus_statusOut),
		 .WIn(databus_wOut),
		 .select(databusSelect),
		 .clk(clk)
		 );
	
	//status
	wire	[2:0] PCHOut;
	wire			PA1Out, PA0Out, TOOut, PDOut, ZOut, DCOut, COut;
	wire			testIn, PA1In, PA0In, TOIn, PDIn, ZIn, DCIn, CIn;
	wire	[7:0]	statusIn;
	assign statusIn = {testIn, PCHOut[2], PCHOut[1], TOIn, PDIn, ZIn, DCIn, CIn};
	assign {PA2Out, PA1Out, PA0Out, TOOut, PDOut, ZOut, DCOut, COut} = statusOut;
	assign databus_statusOut = statusOut;	
		

	//Stack
	wire	[10:0] stack_out;
	Stack pic_stack (
    .out(stack_out), 
    .in(PCOut), 
    .instruction(stackInstruction), 
    .clk(clk), 
    .rst(rst)
    );
	 
	 //Memory
	 wire [11:0]	memoryOut;
	 memory programMemory(
		.data(memoryOut), 
		.address(PCOut),
		.rst(rst)
		);
	
	//IR
	wire [11:0]	irOut;
	Register12Bit IR (
		 .out(irOut), 
		 .in(memoryOut), 
		 .rst(rst), 
		 .en(irEn), 
		 .clk(clk)
		 );
	
	//Decoder
	wire	[4:0]	registerAddress;
	wire	[8:0] literal;
	decoder Decoder (
		 .operation(currentInstruction), 
		 .address(registerAddress),
		 .literal(literal),
		 .instruction(irOut),
		 .d(d),
		 .BIT(b)
		 );
		 
	reg	[7:0]	wIn;
	parameter	wIn_literal = 1'b0;
	parameter	wIn_databus = 1'b1;


	//W Register	
	always@(*)
	begin
		if(wSel == wIn_literal)
		begin
			wIn = literal[7:0];
		end
		else
		begin
			wIn = databus_out;
		end
	end

	
	Register8Bit W (
		 .out(databus_wOut), 
		 .in(wIn), 
		 .rst(rst), 
		 .en(wEn), 
		 .clk(clk)
		 );

	reg [7:0] Ain;
	
	always @(databus_wOut or b or ASel or literal)
	begin
		if(ASel == 2'd0)
			Ain = databus_wOut;
		else if(ASel ==2'd1)
			Ain = {5'd0,b};
		else
			Ain = literal[7:0];
			
	end
	
	//ALU
	ALU alu (
		 .out(databus_ALUOut),
		 .Z(ZIn),
		 .DC(DCIn),
		 .Cout(CIn),
		 .test(testIn),
		 .A(Ain), 
		 .B(databus_out), 
		 .command(ALUInst),
		 .Cin(COut)
		 );

	//TRISA
	wire	[7:0]	trisAOut;
	Register8Bit trisA (
		 .out(trisAOut), 
		 .in(databus_wOut), 
		 .rst(rst), 
		 .en(trisAEn), 
		 .clk(clk)
		 );
		 
	//TRISB
	wire	[7:0]	trisBOut;
	Register8Bit trisB (
		 .out(trisBOut), 
		 .in(databus_wOut), 
		 .rst(rst), 
		 .en(trisBEn), 
		 .clk(clk)
		 );
		 
	//TRISC
	wire	[7:0]	trisCOut;
	Register8Bit trisC (
		 .out(trisCOut), 
		 .in(databus_wOut), 
		 .rst(rst), 
		 .en(trisCEn), 
		 .clk(clk)
		 );

	//RegisterFile
	wire	[3:0]	portAOut;
	wire	[7:0] portBOut, portCOut;		 
	parameter rfSel_Databus = 2'd0;
	parameter rfSel_Stack = 2'd1;
	parameter rfSel_literal = 2'd2;
	reg	[7:0]	rf_DataIn;
	reg	[2:0]	PCHIn;
	
	RegisterFile registerFile (
		 .out(databus_RegisterFileOut), 
		 .statusOut(statusOut),
		 .portAOut(portAOut), 
		 .portBOut(portBOut), 
		 .portCOut(portCOut), 
		 .PCHOut(PCHOut), 
		 .PCOut(PCOut),
		 .dataIn(rf_DataIn),
		 .statusIn(statusIn),
		 .PCHIn(PCHIn),
		 .portAIn(portAIn),
		 .portBIn(portBIn),
		 .portCIn(portCIn),		 
		 .StatusEn(statusEn), 
		 .addressIn(registerAddress), 
		 .write(rfEn), 
		 .PCInc(PCInc), 
		 .clk(clk), 
		 .rst(rst)
		 );
	
	always@(*)
	begin
		case(rfSel)
			rfSel_Databus:{PCHIn,rf_DataIn} = {3'b0,databus_out};
			rfSel_Stack:{PCHIn,rf_DataIn} = stack_out;
			rfSel_literal:{PCHIn,rf_DataIn} = {PA1Out, PA0Out, literal};
			default:{PCHIn,rf_DataIn} = {3'b0,databus_out};
		endcase
	end
	
	always@(trisEn or registerAddress[2:0])
	begin
		trisAEn = 1'b0;
		trisBEn = 1'b0;
		trisCEn = 1'b0;
		if(trisEn)
		begin
			case(registerAddress[2:0])
			 3'd5 : trisAEn = 1'b1;
			 3'd6 : trisBEn = 1'b1;
			 3'd7 : trisCEn = 1'b1;
			 default:
			 begin
				trisAEn = 1'b0;
				trisBEn = 1'b0;
				trisCEn = 1'b0;			 
			 end
			endcase
		end
	end
		 
	integer index;
	always@(*)
	begin
		
		for(index = 0 ; index < 4 ; index = index + 1)
		begin
			if(trisAOut[index] == 1'b1)
			begin
				RA[index] = 1'bz;
			end
			else
			begin
				RA[index] = portAOut[index];
			end
		end
	end
	
	always@(*)
	begin
		for(index = 0 ; index < 8 ; index = index + 1)
		begin
			if(trisBOut[index] == 1'b1)
			begin
				RB[index] = 1'bz;
			end
			else
			begin
				RB[index] = portBOut[index];
			end
		end
	end

	always@(*)
	begin
		for(index = 0 ; index < 8 ; index = index + 1)
		begin
			if(trisCOut[index] == 1'b1)
			begin
				RC[index] = 1'bz;
			end
			else
			begin
				RC[index] = portCOut[index];
			end
		end
	end
endmodule
