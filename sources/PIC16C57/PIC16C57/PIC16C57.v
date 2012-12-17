`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:45:20 09/15/2012 
// Design Name: 
// Module Name:    PIC16C57 
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
module PIC16C57(RA, RB, RC, clk, rst);
	inout	[3:0] RA;
	inout	[7:0] RB, RC;
	input		clk, rst;


	wire			irEn, wEn, rfEn, trisEn, statusEn;
	wire	[7:0]		ALUInst;
	wire [3:0]	databusSelect;
	wire	[5:0]		currentInstruction;	
	wire 			d;
	wire 			wSel;
	wire	[1:0]	rfSel;
	wire	[1:0]	stackInstruction;
	wire [7:0] statusOut;
	wire 			PCInc;
	wire	[1:0]	aSel;
	
	ControlUnit CU (
		 .irEn(irEn), 
		 .wEn(wEn), 
		 .rfEn(rfEn), 
		 .rfSel(rfSel),
		 .wSel(wSel),
		 .statusEn(statusEn),
		 .trisEn(trisEn),
		 .ALUInst(ALUInst), 
		 .databusSelect(databusSelect),
		 .stackInstruction(stackInstruction),
		 .currentInstruction(currentInstruction),
		 .statusReg(statusOut),
		 .ASel(aSel),
		 .d(d),
		 .PCInc(PCInc),
		 .clk(clk), 
		 .rst(rst)
		 );
	
	Datapath DP (
		 .RA(RA),
		 .RB(RB),
		 .RC(RC),
		 .currentInstruction(currentInstruction),
		 .d(d),
		 .PCInc(PCInc),
		 .irEn(irEn), 
		 .wEn(wEn), 
		 .rfEn(rfEn), 
		 .statusEn(statusEn),
		 .trisEn(trisEn),
		 .wSel(wSel),
		 .rfSel(rfSel),
		 .ALUInst(ALUInst), 
		 .portAIn(RA),
		 .portBIn(RB),
		 .portCIn(RC),
		 .databusSelect(databusSelect),
		 .stackInstruction(stackInstruction),	
		 .statusOut(statusOut),
		 .ASel(aSel),
		 .clk(clk), 
		 .rst(rst)
		 );
endmodule
