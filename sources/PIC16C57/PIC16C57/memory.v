`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:38:52 09/14/2012 
// Design Name: 
// Module Name:    moemory 
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
module memory(data,address, rst);
	output 		[11:0]	data;
	input			[10:0]	address;
	input						rst;
	reg	[11:0]	memoryArray[2047:0];
	
	assign data = memoryArray[address];
	
	integer index;
	always@(rst)
	begin
		if(rst)
		begin
			for(index = 0 ; index < 2048 ; index = index + 1)
			begin
				memoryArray[index] = 12'b0001_1101_0000;
			end
/*			memoryArray[0] = 12'b0001_1101_0000;	// ADDWF		d = 0
			memoryArray[1] = 12'b0010_1111_0000;	// DECFSZ	d = 1
			memoryArray[2] = 12'b0001_1101_0000;	// ADDWF		d = 0
			memoryArray[3] = 12'b0001_1111_0000;	// ADDWF		d = 1
			memoryArray[4] = 12'b0000_1111_0000;	// DECF		d = 1
			memoryArray[5] = 12'b0001_1111_0000;	// ADDWF		d = 1
			memoryArray[6] = 12'b0001_0101_0000;	// ANDWF 	d = 0
			memoryArray[7] = 12'b0001_0111_0000;	// ANDWF 	d = 1
			memoryArray[8] = 12'b0001_1111_0000;	// ADDWF		d = 1
			memoryArray[9] = 12'b0000_0111_0000;	// CLRF
			memoryArray[10] = 12'b0010_0111_0000;	// COMF		d = 1
			memoryArray[11] = 12'b0011_1111_0000;	// INCFSZ	d = 1
			memoryArray[12] = 12'b0001_0111_0000;	// ANDWF 	d = 1
			memoryArray[13] = 12'b0001_1111_0000;	// ADDWF		d = 1
			memoryArray[14] = 12'b0001_1101_0000;	// ADDWF		d = 0
			memoryArray[15] = 12'b0001_0011_0000;	// IORWF		d = 1
			memoryArray[16] = 12'b0010_0001_0000;	// MOVF		d = 0
			memoryArray[17] = 12'b0000_0011_0000;	// MOVWF
			memoryArray[18] = 12'b0000_0111_0000;	// CLRF
			memoryArray[19] = 12'b0000_1111_0000;	// DECF		d = 1		
			memoryArray[20] = 12'b0000_1111_0000;	// DECF		d = 1
			memoryArray[21] = 12'b0011_0111_0000;	// RLF		d = 1
			memoryArray[22] = 12'b0011_0111_0000;	// RLF		d = 1
			memoryArray[23] = 12'b0011_0011_0000;	// RRF		d = 1
			memoryArray[24] = 12'b0011_0011_0000;	// RRF		d = 1
			memoryArray[25] = 12'b0011_0011_0000;	// RRF		d = 1
			memoryArray[26] = 12'b0000_1011_0000;	// SUBWF		d = 1
			memoryArray[27] = 12'b0011_1011_0000;	// SWAPF		d = 1
			memoryArray[28] = 12'b0001_1011_0000;	// XORWF		d = 1
			memoryArray[29] = 12'b0100_1111_0000;	// BCF		
			memoryArray[30] = 12'b0101_1111_0000;	// BSF		
			memoryArray[31] = 12'b0100_1111_0000;	// BCF
			memoryArray[32] = 12'b0110_1111_0000;	// BTFSC
			memoryArray[33] = 12'b0011_0011_0000;	// RRF		d = 1(SKIP)
			memoryArray[34] = 12'b0101_1111_0000;	// BSF
			memoryArray[35] = 12'b0110_1111_0000;	// BTFSC
			
			memoryArray[36] = 12'b0101_1111_0000;	// BSF
			memoryArray[37] = 12'b0111_1111_0000;	// BTFSS
			memoryArray[38] = 12'b0011_0011_0000;	// RRF		d = 1(SKIP)
			memoryArray[39] = 12'b0100_1111_0000;	// BCF
			memoryArray[40] = 12'b0111_1111_0000;	// BTFSS		
			memoryArray[41] = 12'b0100_1111_0000;	// BCF
			memoryArray[42] = 12'b1110_1111_1111;	// ANDLW
			memoryArray[43] = 12'b1110_0000_0000;	// ANDLW
			memoryArray[44] = 12'b1001_0011_0000;	// CALL 48
			
			memoryArray[45] = 12'b0101_1111_0000;	// BSF
			memoryArray[46] = 12'b1010_0011_1000;	// GOTO 56
			
			// skip
			memoryArray[47] = 12'b0011_0011_0000;	// RRF		d = 1(SKIP)
			memoryArray[48] = 12'b0100_1111_0000;	// BCF
			memoryArray[49] = 12'b1101_1111_1111;	// IORLW
			memoryArray[50] = 12'b1111_1111_1111;	// XORLW
			memoryArray[51] = 12'b1100_1010_1010;	// MOVLW
			memoryArray[52] = 12'b0000_0000_0101;	// TRISA
			memoryArray[53] = 12'b0000_0000_0110;	// TRISB
			memoryArray[54] = 12'b0000_0000_0111;	// TRISC
			memoryArray[55] = 12'b0000_0100_0000;	// CLRW
			memoryArray[56] = 12'b0000_0000_0000;	// NOP
			memoryArray[57] = 12'b0010_1011_0000;	// INCF
			memoryArray[58] = 12'b1000_0110_0011;	// RETLW
			
			
			// clear
			memoryArray[56] = 12'b1100_0001_0000;	// MOVLW
			memoryArray[57] = 12'b0000_0010_0100;	// MOVWF
			memoryArray[58] = 12'b0000_0110_0000;	// CLRF
			memoryArray[59] = 12'b0010_1010_0100;	// INCF
			memoryArray[60] = 12'b0110_1000_0100;	// BTFSC
			memoryArray[61] = 12'b1010_0011_1010;	// GOTO 58
			memoryArray[62] = 12'b1010_0000_0000;	// GOTO 0*/

/*			//Sample Program
			memoryArray[0]=12'ha01;   //[0000] GOTO
			memoryArray[1]=12'h064;   //[0001] CLRF
			memoryArray[2]=12'h06b;   //[0002] CLRF
			memoryArray[3]=12'h06c;   //[0003] CLRF
			memoryArray[4]=12'h06c;   //[0004] CLRF
			memoryArray[5]=12'hc02;   //[0005] MOVLW
			memoryArray[6]=12'h028;   //[0006] MOVWF
			memoryArray[7]=12'h20c;   //[0007] MOVF
			memoryArray[8]=12'h088;   //[0008] SUBWF
			memoryArray[9]=12'h703;   //[0009] BTFSS
			memoryArray[10]=12'ha0f;   //[000a] GOTO
			memoryArray[11]=12'h20c;   //[000b] MOVF
			memoryArray[12]=12'h1eb;   //[000c] ADDWF
			memoryArray[13]=12'h2ac;   //[000d] INCF
			memoryArray[14]=12'ha05;   //[000e] GOTO
			memoryArray[15]=12'ha0f;   //[000f] GOTO
			memoryArray[16]=12'hc00;   //[0010] MOVLW
			memoryArray[17]=12'h029;   //[0011] MOVWF
			memoryArray[18]=12'h003;   //[0012] SLEEP
*/
/*
			//Sort
			memoryArray[0]=12'ha01;   //[0000] GOTO
			memoryArray[1]=12'h064;   //[0001] CLRF
			memoryArray[2]=12'hc05;   //[0002] MOVLW
			memoryArray[3]=12'h02b;   //[0003] MOVWF
			memoryArray[4]=12'hc04;   //[0004] MOVLW
			memoryArray[5]=12'h02c;   //[0005] MOVWF
			memoryArray[6]=12'hc02;   //[0006] MOVLW
			memoryArray[7]=12'h02d;   //[0007] MOVWF
			memoryArray[8]=12'hc07;   //[0008] MOVLW
			memoryArray[9]=12'h02e;   //[0009] MOVWF
			memoryArray[10]=12'hc03;   //[000a] MOVLW
			memoryArray[11]=12'h02f;   //[000b] MOVWF
			memoryArray[12]=12'hc01;   //[000c] MOVLW
			memoryArray[13]=12'h030;   //[000d] MOVWF
			memoryArray[14]=12'hc08;   //[000e] MOVLW
			memoryArray[15]=12'h031;   //[000f] MOVWF
			memoryArray[16]=12'hc09;   //[0010] MOVLW
			memoryArray[17]=12'h032;   //[0011] MOVWF
			memoryArray[18]=12'h073;   //[0012] CLRF
			memoryArray[19]=12'hc06;   //[0013] MOVLW
			memoryArray[20]=12'h034;   //[0014] MOVWF
			memoryArray[21]=12'h075;   //[0015] CLRF
			memoryArray[22]=12'hc09;   //[0016] MOVLW
			memoryArray[23]=12'h028;   //[0017] MOVWF
			memoryArray[24]=12'h215;   //[0018] MOVF
			memoryArray[25]=12'h088;   //[0019] SUBWF
			memoryArray[26]=12'h703;   //[001a] BTFSS
			memoryArray[27]=12'ha4b;   //[001b] GOTO
			memoryArray[28]=12'hc01;   //[001c] MOVLW
			memoryArray[29]=12'h1d5;   //[001d] ADDWF
			memoryArray[30]=12'h036;   //[001e] MOVWF
			memoryArray[31]=12'hc09;   //[001f] MOVLW
			memoryArray[32]=12'h028;   //[0020] MOVWF
			memoryArray[33]=12'h216;   //[0021] MOVF
			memoryArray[34]=12'h088;   //[0022] SUBWF
			memoryArray[35]=12'h703;   //[0023] BTFSS
			memoryArray[36]=12'ha49;   //[0024] GOTO
			memoryArray[37]=12'hc0b;   //[0025] MOVLW
			memoryArray[38]=12'h1d5;   //[0026] ADDWF
			memoryArray[39]=12'h024;   //[0027] MOVWF
			memoryArray[40]=12'h200;   //[0028] MOVF
			memoryArray[41]=12'h038;   //[0029] MOVWF
			memoryArray[42]=12'hc0b;   //[002a] MOVLW
			memoryArray[43]=12'h1d6;   //[002b] ADDWF
			memoryArray[44]=12'h024;   //[002c] MOVWF
			memoryArray[45]=12'h200;   //[002d] MOVF
			memoryArray[46]=12'h098;   //[002e] SUBWF
			memoryArray[47]=12'h603;   //[002f] BTFSC
			memoryArray[48]=12'ha47;   //[0030] GOTO
			memoryArray[49]=12'hc0b;   //[0031] MOVLW
			memoryArray[50]=12'h1d5;   //[0032] ADDWF
			memoryArray[51]=12'h024;   //[0033] MOVWF
			memoryArray[52]=12'h200;   //[0034] MOVF
			memoryArray[53]=12'h037;   //[0035] MOVWF
			memoryArray[54]=12'hc0b;   //[0036] MOVLW
			memoryArray[55]=12'h1d5;   //[0037] ADDWF
			memoryArray[56]=12'h038;   //[0038] MOVWF
			memoryArray[57]=12'hc0b;   //[0039] MOVLW
			memoryArray[58]=12'h1d6;   //[003a] ADDWF
			memoryArray[59]=12'h024;   //[003b] MOVWF
			memoryArray[60]=12'h200;   //[003c] MOVF
			memoryArray[61]=12'h039;   //[003d] MOVWF
			memoryArray[62]=12'h218;   //[003e] MOVF
			memoryArray[63]=12'h024;   //[003f] MOVWF
			memoryArray[64]=12'h219;   //[0040] MOVF
			memoryArray[65]=12'h020;   //[0041] MOVWF
			memoryArray[66]=12'hc0b;   //[0042] MOVLW
			memoryArray[67]=12'h1d6;   //[0043] ADDWF
			memoryArray[68]=12'h024;   //[0044] MOVWF
			memoryArray[69]=12'h217;   //[0045] MOVF
			memoryArray[70]=12'h020;   //[0046] MOVWF
			memoryArray[71]=12'h2b6;   //[0047] INCF
			memoryArray[72]=12'ha1f;   //[0048] GOTO
			memoryArray[73]=12'h2b5;   //[0049] INCF
			memoryArray[74]=12'ha16;   //[004a] GOTO
			memoryArray[75]=12'ha4b;   //[004b] GOTO
			memoryArray[76]=12'hc00;   //[004c] MOVLW
			memoryArray[77]=12'h029;   //[004d] MOVWF
			memoryArray[78]=12'h003;   //[004e] SLEEP
*/
			// I/O Port test
/*			memoryArray[0]=12'ha29;   //[0000] GOTO
			memoryArray[1]=12'ha02;   //[0001] GOTO
			memoryArray[2]=12'h068;   //[0002] CLRF
			memoryArray[3]=12'h069;   //[0003] CLRF
			memoryArray[4]=12'h20d;   //[0004] MOVF
			memoryArray[5]=12'h403;   //[0005] BCF
			memoryArray[6]=12'h60e;   //[0006] BTFSC
			memoryArray[7]=12'h1e8;   //[0007] ADDWF
			memoryArray[8]=12'h328;   //[0008] RRF
			memoryArray[9]=12'h329;   //[0009] RRF
			memoryArray[10]=12'h62e;   //[000a] BTFSC
			memoryArray[11]=12'h1e8;   //[000b] ADDWF
			memoryArray[12]=12'h328;   //[000c] RRF
			memoryArray[13]=12'h329;   //[000d] RRF
			memoryArray[14]=12'h64e;   //[000e] BTFSC
			memoryArray[15]=12'h1e8;   //[000f] ADDWF
			memoryArray[16]=12'h328;   //[0010] RRF
			memoryArray[17]=12'h329;   //[0011] RRF
			memoryArray[18]=12'h66e;   //[0012] BTFSC
			memoryArray[19]=12'h1e8;   //[0013] ADDWF
			memoryArray[20]=12'h328;   //[0014] RRF
			memoryArray[21]=12'h329;   //[0015] RRF
			memoryArray[22]=12'h68e;   //[0016] BTFSC
			memoryArray[23]=12'h1e8;   //[0017] ADDWF
			memoryArray[24]=12'h328;   //[0018] RRF
			memoryArray[25]=12'h329;   //[0019] RRF
			memoryArray[26]=12'h6ae;   //[001a] BTFSC
			memoryArray[27]=12'h1e8;   //[001b] ADDWF
			memoryArray[28]=12'h328;   //[001c] RRF
			memoryArray[29]=12'h329;   //[001d] RRF
			memoryArray[30]=12'h6ce;   //[001e] BTFSC
			memoryArray[31]=12'h1e8;   //[001f] ADDWF
			memoryArray[32]=12'h328;   //[0020] RRF
			memoryArray[33]=12'h329;   //[0021] RRF
			memoryArray[34]=12'h6ee;   //[0022] BTFSC
			memoryArray[35]=12'h1e8;   //[0023] ADDWF
			memoryArray[36]=12'h328;   //[0024] RRF
			memoryArray[37]=12'h329;   //[0025] RRF
			memoryArray[38]=12'h4a3;   //[0026] BCF
			memoryArray[39]=12'h4c3;   //[0027] BCF
			memoryArray[40]=12'ha42;   //[0028] GOTO
			memoryArray[41]=12'h064;   //[0029] CLRF
			memoryArray[42]=12'hcff;   //[002a] MOVLW
			memoryArray[43]=12'h005;   //[002b] TRIS
			memoryArray[44]=12'h006;   //[002c] TRIS
			memoryArray[45]=12'hc00;   //[002d] MOVLW
			memoryArray[46]=12'h007;   //[002e] TRIS
			memoryArray[47]=12'h205;   //[002f] MOVF
			memoryArray[48]=12'he0f;   //[0030] ANDLW
			memoryArray[49]=12'h02b;   //[0031] MOVWF
			memoryArray[50]=12'h206;   //[0032] MOVF
			memoryArray[51]=12'he0f;   //[0033] ANDLW
			memoryArray[52]=12'h02c;   //[0034] MOVWF
			memoryArray[53]=12'h20c;   //[0035] MOVF
			memoryArray[54]=12'h1cb;   //[0036] ADDWF
			memoryArray[55]=12'h027;   //[0037] MOVWF
			memoryArray[56]=12'hc0f;   //[0038] MOVLW
			memoryArray[57]=12'h006;   //[0039] TRIS
			memoryArray[58]=12'h206;   //[003a] MOVF
			memoryArray[59]=12'he0f;   //[003b] ANDLW
			memoryArray[60]=12'h02b;   //[003c] MOVWF
			memoryArray[61]=12'h20b;   //[003d] MOVF
			memoryArray[62]=12'h02d;   //[003e] MOVWF
			memoryArray[63]=12'h20b;   //[003f] MOVF
			memoryArray[64]=12'h02e;   //[0040] MOVWF
			memoryArray[65]=12'ha01;   //[0041] GOTO
			memoryArray[66]=12'h209;   //[0042] MOVF
			memoryArray[67]=12'h02c;   //[0043] MOVWF
			memoryArray[68]=12'h38c;   //[0044] SWAPF
			memoryArray[69]=12'h028;   //[0045] MOVWF
			memoryArray[70]=12'hcf0;   //[0046] MOVLW
			memoryArray[71]=12'h168;   //[0047] ANDWF
			memoryArray[72]=12'h208;   //[0048] MOVF
			memoryArray[73]=12'hef0;   //[0049] ANDLW
			memoryArray[74]=12'h026;   //[004a] MOVWF
			memoryArray[75]=12'ha4b;   //[004b] GOTO
			memoryArray[76]=12'hc00;   //[004c] MOVLW
			memoryArray[77]=12'h029;   //[004d] MOVWF
			memoryArray[78]=12'h003;   //[004e] SLEEP
*/
	//IOPort Test 2
	/*		memoryArray[0]=12'ha01;   //[0000] GOTO
			memoryArray[1]=12'h064;   //[0001] CLRF
			memoryArray[2]=12'hc00;   //[0002] MOVLW
			memoryArray[3]=12'h005;   //[0003] TRIS
			memoryArray[4]=12'h006;   //[0004] TRIS
			memoryArray[5]=12'h007;   //[0005] TRIS
			memoryArray[6]=12'hcff;   //[0006] MOVLW
			memoryArray[7]=12'h025;   //[0007] MOVWF
			memoryArray[8]=12'ha08;   //[0008] GOTO
			memoryArray[9]=12'hc00;   //[0009] MOVLW
			memoryArray[10]=12'h029;   //[000a] MOVWF
			memoryArray[11]=12'h003;   //[000b] SLEEP
	*/

	
	//IOTest3
/*				memoryArray[0]=12'ha01;   //[0000] GOTO
				memoryArray[1]=12'h064;   //[0001] CLRF
				memoryArray[2]=12'hc05;   //[0002] MOVLW
				memoryArray[3]=12'h02b;   //[0003] MOVWF
				memoryArray[4]=12'hc04;   //[0004] MOVLW
				memoryArray[5]=12'h02c;   //[0005] MOVWF
				memoryArray[6]=12'hc02;   //[0006] MOVLW
				memoryArray[7]=12'h02d;   //[0007] MOVWF
				memoryArray[8]=12'hc07;   //[0008] MOVLW
				memoryArray[9]=12'h02e;   //[0009] MOVWF
				memoryArray[10]=12'hc03;   //[000a] MOVLW
				memoryArray[11]=12'h02f;   //[000b] MOVWF
				memoryArray[12]=12'hc01;   //[000c] MOVLW
				memoryArray[13]=12'h030;   //[000d] MOVWF
				memoryArray[14]=12'hc08;   //[000e] MOVLW
				memoryArray[15]=12'h031;   //[000f] MOVWF
				memoryArray[16]=12'hc09;   //[0010] MOVLW
				memoryArray[17]=12'h032;   //[0011] MOVWF
				memoryArray[18]=12'h073;   //[0012] CLRF
				memoryArray[19]=12'hc06;   //[0013] MOVLW
				memoryArray[20]=12'h034;   //[0014] MOVWF
				memoryArray[21]=12'h075;   //[0015] CLRF
				memoryArray[22]=12'hc09;   //[0016] MOVLW
				memoryArray[23]=12'h028;   //[0017] MOVWF
				memoryArray[24]=12'h215;   //[0018] MOVF
				memoryArray[25]=12'h088;   //[0019] SUBWF
				memoryArray[26]=12'h703;   //[001a] BTFSS
				memoryArray[27]=12'ha4b;   //[001b] GOTO
				memoryArray[28]=12'hc01;   //[001c] MOVLW
				memoryArray[29]=12'h1d5;   //[001d] ADDWF
				memoryArray[30]=12'h036;   //[001e] MOVWF
				memoryArray[31]=12'hc09;   //[001f] MOVLW
				memoryArray[32]=12'h028;   //[0020] MOVWF
				memoryArray[33]=12'h216;   //[0021] MOVF
				memoryArray[34]=12'h088;   //[0022] SUBWF
				memoryArray[35]=12'h703;   //[0023] BTFSS
				memoryArray[36]=12'ha49;   //[0024] GOTO
				memoryArray[37]=12'hc0b;   //[0025] MOVLW
				memoryArray[38]=12'h1d5;   //[0026] ADDWF
				memoryArray[39]=12'h024;   //[0027] MOVWF
				memoryArray[40]=12'h200;   //[0028] MOVF
				memoryArray[41]=12'h038;   //[0029] MOVWF
				memoryArray[42]=12'hc0b;   //[002a] MOVLW
				memoryArray[43]=12'h1d6;   //[002b] ADDWF
				memoryArray[44]=12'h024;   //[002c] MOVWF
				memoryArray[45]=12'h200;   //[002d] MOVF
				memoryArray[46]=12'h098;   //[002e] SUBWF
				memoryArray[47]=12'h603;   //[002f] BTFSC
				memoryArray[48]=12'ha47;   //[0030] GOTO
				memoryArray[49]=12'hc0b;   //[0031] MOVLW
				memoryArray[50]=12'h1d5;   //[0032] ADDWF
				memoryArray[51]=12'h024;   //[0033] MOVWF
				memoryArray[52]=12'h200;   //[0034] MOVF
				memoryArray[53]=12'h037;   //[0035] MOVWF
				memoryArray[54]=12'hc0b;   //[0036] MOVLW
				memoryArray[55]=12'h1d5;   //[0037] ADDWF
				memoryArray[56]=12'h038;   //[0038] MOVWF
				memoryArray[57]=12'hc0b;   //[0039] MOVLW
				memoryArray[58]=12'h1d6;   //[003a] ADDWF
				memoryArray[59]=12'h024;   //[003b] MOVWF
				memoryArray[60]=12'h200;   //[003c] MOVF
				memoryArray[61]=12'h039;   //[003d] MOVWF
				memoryArray[62]=12'h218;   //[003e] MOVF
				memoryArray[63]=12'h024;   //[003f] MOVWF
				memoryArray[64]=12'h219;   //[0040] MOVF
				memoryArray[65]=12'h020;   //[0041] MOVWF
				memoryArray[66]=12'hc0b;   //[0042] MOVLW
				memoryArray[67]=12'h1d6;   //[0043] ADDWF
				memoryArray[68]=12'h024;   //[0044] MOVWF
				memoryArray[69]=12'h217;   //[0045] MOVF
				memoryArray[70]=12'h020;   //[0046] MOVWF
				memoryArray[71]=12'h2b6;   //[0047] INCF
				memoryArray[72]=12'ha1f;   //[0048] GOTO
				memoryArray[73]=12'h2b5;   //[0049] INCF
				memoryArray[74]=12'ha16;   //[004a] GOTO
				memoryArray[75]=12'hc00;   //[004b] MOVLW
				memoryArray[76]=12'h005;   //[004c] TRIS
				memoryArray[77]=12'h006;   //[004d] TRIS
				memoryArray[78]=12'h007;   //[004e] TRIS
				memoryArray[79]=12'h20b;   //[004f] MOVF
				memoryArray[80]=12'h027;   //[0050] MOVWF
				memoryArray[81]=12'ha51;   //[0051] GOTO
				memoryArray[82]=12'hc00;   //[0052] MOVLW
				memoryArray[83]=12'h029;   //[0053] MOVWF
				memoryArray[84]=12'h003;   //[0054] SLEEP*/
				
		//Term
/*
memoryArray[0]=12'ha01; //[0000]GOTO
memoryArray[1]=12'h064; //[0001]CLRF
memoryArray[2]=12'hc0f; //[0002]MOVLW
memoryArray[3]=12'h02d; //[0003]MOVWF
memoryArray[4]=12'hc0f; //[0004]MOVLW
memoryArray[5]=12'h02e; //[0005]MOVWF
memoryArray[6]=12'hcff; //[0006]MOVLW
memoryArray[7]=12'h005; //[0007]TRIS
memoryArray[8]=12'hc00; //[0008]MOVLW
memoryArray[9]=12'h006; //[0009]TRIS
memoryArray[10]=12'h007; //[000a]TRIS
memoryArray[11]=12'hcff; //[000b]MOVLW
memoryArray[12]=12'h02c; //[000c]MOVWF
memoryArray[13]=12'h20c; //[000d]MOVF
memoryArray[14]=12'h026; //[000e]MOVWF
memoryArray[15]=12'h205; //[000f]MOVF
memoryArray[16]=12'h02b; //[0010]MOVWF
memoryArray[17]=12'h20b; //[0011]MOVF
memoryArray[18]=12'h02d; //[0012]MOVWF
memoryArray[19]=12'h20d; //[0013]MOVF
memoryArray[20]=12'h08e; //[0014]SUBWF
memoryArray[21]=12'h643; //[0015]BTFSC
memoryArray[22]=12'ha4b; //[0016]GOTO
memoryArray[23]=12'h20d; //[0017]MOVF
memoryArray[24]=12'h02e; //[0018]MOVWF
memoryArray[25]=12'hc0f; //[0019]MOVLW
memoryArray[26]=12'h08d; //[001a]SUBWF
memoryArray[27]=12'h643; //[001b]BTFSC
memoryArray[28]=12'ha4b; //[001c]GOTO
memoryArray[29]=12'h20d; //[001d]MOVF
memoryArray[30]=12'h643; //[001e]BTFSC
memoryArray[31]=12'ha3c; //[001f]GOTO
memoryArray[32]=12'hf01; //[0020]XORLW
memoryArray[33]=12'h643; //[0021]BTFSC
memoryArray[34]=12'ha3d; //[0022]GOTO
memoryArray[35]=12'hf03; //[0023]XORLW
memoryArray[36]=12'h643; //[0024]BTFSC
memoryArray[37]=12'ha3e; //[0025]GOTO
memoryArray[38]=12'hf01; //[0026]XORLW
memoryArray[39]=12'h643; //[0027]BTFSC
memoryArray[40]=12'ha40; //[0028]GOTO
memoryArray[41]=12'hf07; //[0029]XORLW
memoryArray[42]=12'h643; //[002a]BTFSC
memoryArray[43]=12'ha41; //[002b]GOTO
memoryArray[44]=12'hf01; //[002c]XORLW
memoryArray[45]=12'h643; //[002d]BTFSC
memoryArray[46]=12'ha42; //[002e]GOTO
memoryArray[47]=12'hf03; //[002f]XORLW
memoryArray[48]=12'h643; //[0030]BTFSC
memoryArray[49]=12'ha43; //[0031]GOTO
memoryArray[50]=12'hf01; //[0032]XORLW
memoryArray[51]=12'h643; //[0033]BTFSC
memoryArray[52]=12'ha44; //[0034]GOTO
memoryArray[53]=12'hf0f; //[0035]XORLW
memoryArray[54]=12'h643; //[0036]BTFSC
memoryArray[55]=12'ha45; //[0037]GOTO
memoryArray[56]=12'hf01; //[0038]XORLW
memoryArray[57]=12'h643; //[0039]BTFSC
memoryArray[58]=12'ha46; //[003a]GOTO
memoryArray[59]=12'ha47; //[003b]GOTO
memoryArray[60]=12'ha47; //[003c]GOTO
memoryArray[61]=12'ha47; //[003d]GOTO
memoryArray[62]=12'h26c; //[003e]COMF
memoryArray[63]=12'ha47; //[003f]GOTO
memoryArray[64]=12'ha47; //[0040]GOTO
memoryArray[65]=12'ha47; //[0041]GOTO
memoryArray[66]=12'ha47; //[0042]GOTO
memoryArray[67]=12'ha47; //[0043]GOTO
memoryArray[68]=12'ha47; //[0044]GOTO
memoryArray[69]=12'ha47; //[0045]GOTO
memoryArray[70]=12'ha47; //[0046]GOTO
memoryArray[71]=12'h20c; //[0047]MOVF
memoryArray[72]=12'h026; //[0048]MOVWF
memoryArray[73]=12'h20d; //[0049]MOVF
memoryArray[74]=12'h027; //[004a]MOVWF
memoryArray[75]=12'ha0f; //[004b]GOTO
memoryArray[76]=12'hc00; //[004c]MOVLW
memoryArray[77]=12'h029; //[004d]MOVWF
memoryArray[78]=12'h003; //[004e]SLEEP
*/
/*
// passwd compare
memoryArray[0]=12'ha01; //[0000]GOTO
memoryArray[1]=12'h064; //[0001]CLRF
memoryArray[2]=12'hcff; //[0002]MOVLW
memoryArray[3]=12'h02d; //[0003]MOVWF
memoryArray[4]=12'hcff; //[0004]MOVLW
memoryArray[5]=12'h02e; //[0005]MOVWF
memoryArray[6]=12'h06f; //[0006]CLRF
memoryArray[7]=12'hc01; //[0007]MOVLW
memoryArray[8]=12'h030; //[0008]MOVWF
memoryArray[9]=12'hc02; //[0009]MOVLW
memoryArray[10]=12'h031; //[000a]MOVWF
memoryArray[11]=12'hc03; //[000b]MOVLW
memoryArray[12]=12'h032; //[000c]MOVWF
memoryArray[13]=12'h073; //[000d]CLRF
memoryArray[14]=12'h074; //[000e]CLRF
memoryArray[15]=12'h075; //[000f]CLRF
memoryArray[16]=12'h076; //[0010]CLRF
memoryArray[17]=12'hcff; //[0011]MOVLW
memoryArray[18]=12'h037; //[0012]MOVWF
memoryArray[19]=12'h078; //[0013]CLRF
memoryArray[20]=12'hcff; //[0014]MOVLW
memoryArray[21]=12'h005; //[0015]TRIS
memoryArray[22]=12'h006; //[0016]TRIS
memoryArray[23]=12'hc00; //[0017]MOVLW
memoryArray[24]=12'h007; //[0018]TRIS
memoryArray[25]=12'hcff; //[0019]MOVLW
memoryArray[26]=12'h02d; //[001a]MOVWF
memoryArray[27]=12'h205; //[001b]MOVF
memoryArray[28]=12'h02b; //[001c]MOVWF
memoryArray[29]=12'h206; //[001d]MOVF
memoryArray[30]=12'h02d; //[001e]MOVWF
memoryArray[31]=12'h217; //[001f]MOVF
memoryArray[32]=12'h08d; //[0020]SUBWF
memoryArray[33]=12'h643; //[0021]BTFSC
memoryArray[34]=12'ha50; //[0022]GOTO
memoryArray[35]=12'h20d; //[0023]MOVF
memoryArray[36]=12'h037; //[0024]MOVWF
memoryArray[37]=12'h20d; //[0025]MOVF
memoryArray[38]=12'hfff; //[0026]XORLW
memoryArray[39]=12'h643; //[0027]BTFSC
memoryArray[40]=12'ha2d; //[0028]GOTO
memoryArray[41]=12'hfd5; //[0029]XORLW
memoryArray[42]=12'h643; //[002a]BTFSC
memoryArray[43]=12'ha2e; //[002b]GOTO
memoryArray[44]=12'ha42; //[002c]GOTO
memoryArray[45]=12'ha50; //[002d]GOTO
memoryArray[46]=12'h213; //[002e]MOVF
memoryArray[47]=12'h08f; //[002f]SUBWF
memoryArray[48]=12'h743; //[0030]BTFSS
memoryArray[49]=12'ha40; //[0031]GOTO
memoryArray[50]=12'h214; //[0032]MOVF
memoryArray[51]=12'h090; //[0033]SUBWF
memoryArray[52]=12'h743; //[0034]BTFSS
memoryArray[53]=12'ha40; //[0035]GOTO
memoryArray[54]=12'h215; //[0036]MOVF
memoryArray[55]=12'h091; //[0037]SUBWF
memoryArray[56]=12'h743; //[0038]BTFSS
memoryArray[57]=12'ha40; //[0039]GOTO
memoryArray[58]=12'h216; //[003a]MOVF
memoryArray[59]=12'h092; //[003b]SUBWF
memoryArray[60]=12'h743; //[003c]BTFSS
memoryArray[61]=12'ha40; //[003d]GOTO
memoryArray[62]=12'hcff; //[003e]MOVLW
memoryArray[63]=12'h027; //[003f]MOVWF
memoryArray[64]=12'h078; //[0040]CLRF
memoryArray[65]=12'ha50; //[0041]GOTO
memoryArray[66]=12'hc30; //[0042]MOVLW
memoryArray[67]=12'h0ad; //[0043]SUBWF
memoryArray[68]=12'h20d; //[0044]MOVF
memoryArray[69]=12'h027; //[0045]MOVWF
memoryArray[70]=12'hc13; //[0046]MOVLW
memoryArray[71]=12'h1d8; //[0047]ADDWF
memoryArray[72]=12'h024; //[0048]MOVWF
memoryArray[73]=12'h20d; //[0049]MOVF
memoryArray[74]=12'h020; //[004a]MOVWF
memoryArray[75]=12'hc01; //[004b]MOVLW
memoryArray[76]=12'h1d8; //[004c]ADDWF
memoryArray[77]=12'he03; //[004d]ANDLW
memoryArray[78]=12'h038; //[004e]MOVWF
memoryArray[79]=12'ha50; //[004f]GOTO
memoryArray[80]=12'ha1b; //[0050]GOTO
memoryArray[81]=12'hc00; //[0051]MOVLW
memoryArray[82]=12'h029; //[0052]MOVWF
memoryArray[83]=12'h003; //[0053]SLEEP
*/

// test
memoryArray[0]=12'ha01; //[0000]GOTO
memoryArray[1]=12'h064; //[0001]CLRF
memoryArray[2]=12'hcff; //[0002]MOVLW
memoryArray[3]=12'h02d; //[0003]MOVWF
memoryArray[4]=12'hcff; //[0004]MOVLW
memoryArray[5]=12'h02e; //[0005]MOVWF
memoryArray[6]=12'h06f; //[0006]CLRF
memoryArray[7]=12'hc01; //[0007]MOVLW
memoryArray[8]=12'h030; //[0008]MOVWF
memoryArray[9]=12'hc02; //[0009]MOVLW
memoryArray[10]=12'h031; //[000a]MOVWF
memoryArray[11]=12'hc03; //[000b]MOVLW
memoryArray[12]=12'h032; //[000c]MOVWF
memoryArray[13]=12'h073; //[000d]CLRF
memoryArray[14]=12'h074; //[000e]CLRF
memoryArray[15]=12'h075; //[000f]CLRF
memoryArray[16]=12'h076; //[0010]CLRF
memoryArray[17]=12'h077; //[0011]CLRF
memoryArray[18]=12'h078; //[0012]CLRF
memoryArray[19]=12'h079; //[0013]CLRF
memoryArray[20]=12'h07a; //[0014]CLRF
memoryArray[21]=12'hcff; //[0015]MOVLW
memoryArray[22]=12'h03b; //[0016]MOVWF
memoryArray[23]=12'h07c; //[0017]CLRF
memoryArray[24]=12'h07d; //[0018]CLRF
memoryArray[25]=12'hcff; //[0019]MOVLW
memoryArray[26]=12'h005; //[001a]TRIS
memoryArray[27]=12'h006; //[001b]TRIS
memoryArray[28]=12'hc00; //[001c]MOVLW
memoryArray[29]=12'h007; //[001d]TRIS
memoryArray[30]=12'hcff; //[001e]MOVLW
memoryArray[31]=12'h02d; //[001f]MOVWF
memoryArray[32]=12'h205; //[0020]MOVF
memoryArray[33]=12'h02b; //[0021]MOVWF
memoryArray[34]=12'h206; //[0022]MOVF
memoryArray[35]=12'h02d; //[0023]MOVWF
memoryArray[36]=12'h20b; //[0024]MOVF
memoryArray[37]=12'h02c; //[0025]MOVWF
memoryArray[38]=12'h20c; //[0026]MOVF
memoryArray[39]=12'h08e; //[0027]SUBWF
memoryArray[40]=12'h643; //[0028]BTFSC
memoryArray[41]=12'ha4f; //[0029]GOTO
memoryArray[42]=12'h20c; //[002a]MOVF
memoryArray[43]=12'h02e; //[002b]MOVWF
memoryArray[44]=12'h20c; //[002c]MOVF
memoryArray[45]=12'hf0f; //[002d]XORLW
memoryArray[46]=12'h643; //[002e]BTFSC
memoryArray[47]=12'ha34; //[002f]GOTO
memoryArray[48]=12'hf05; //[0030]XORLW
memoryArray[49]=12'h643; //[0031]BTFSC
memoryArray[50]=12'ha35; //[0032]GOTO
memoryArray[51]=12'ha40; //[0033]GOTO
memoryArray[52]=12'ha4f; //[0034]GOTO
memoryArray[53]=12'h217; //[0035]MOVF
memoryArray[54]=12'h02f; //[0036]MOVWF
memoryArray[55]=12'h218; //[0037]MOVF
memoryArray[56]=12'h030; //[0038]MOVWF
memoryArray[57]=12'h219; //[0039]MOVF
memoryArray[58]=12'h031; //[003a]MOVWF
memoryArray[59]=12'h21a; //[003b]MOVF
memoryArray[60]=12'h032; //[003c]MOVWF
memoryArray[61]=12'h07d; //[003d]CLRF
memoryArray[62]=12'ha81; //[003e]GOTO
memoryArray[63]=12'ha4f; //[003f]GOTO
memoryArray[64]=12'hc17; //[0040]MOVLW
memoryArray[65]=12'h1dd; //[0041]ADDWF
memoryArray[66]=12'h024; //[0042]MOVWF
memoryArray[67]=12'h20c; //[0043]MOVF
memoryArray[68]=12'h020; //[0044]MOVWF
memoryArray[69]=12'hc17; //[0045]MOVLW
memoryArray[70]=12'h1dd; //[0046]ADDWF
memoryArray[71]=12'h024; //[0047]MOVWF
memoryArray[72]=12'h200; //[0048]MOVF
memoryArray[73]=12'h027; //[0049]MOVWF
memoryArray[74]=12'hc01; //[004a]MOVLW
memoryArray[75]=12'h1dd; //[004b]ADDWF
memoryArray[76]=12'he03; //[004c]ANDLW
memoryArray[77]=12'h03d; //[004d]MOVWF
memoryArray[78]=12'ha4f; //[004e]GOTO
memoryArray[79]=12'h21b; //[004f]MOVF
memoryArray[80]=12'h08d; //[0050]SUBWF
memoryArray[81]=12'h643; //[0051]BTFSC
memoryArray[82]=12'ha81; //[0052]GOTO
memoryArray[83]=12'h20d; //[0053]MOVF
memoryArray[84]=12'h03b; //[0054]MOVWF
memoryArray[85]=12'h20d; //[0055]MOVF
memoryArray[86]=12'hfff; //[0056]XORLW
memoryArray[87]=12'h643; //[0057]BTFSC
memoryArray[88]=12'ha5d; //[0058]GOTO
memoryArray[89]=12'hfd5; //[0059]XORLW
memoryArray[90]=12'h643; //[005a]BTFSC
memoryArray[91]=12'ha5e; //[005b]GOTO
memoryArray[92]=12'ha75; //[005c]GOTO
memoryArray[93]=12'ha81; //[005d]GOTO
memoryArray[94]=12'h213; //[005e]MOVF
memoryArray[95]=12'h08f; //[005f]SUBWF
memoryArray[96]=12'h743; //[0060]BTFSS
memoryArray[97]=12'ha71; //[0061]GOTO
memoryArray[98]=12'h214; //[0062]MOVF
memoryArray[99]=12'h090; //[0063]SUBWF
memoryArray[100]=12'h743; //[0064]BTFSS
memoryArray[101]=12'ha71; //[0065]GOTO
memoryArray[102]=12'h215; //[0066]MOVF
memoryArray[103]=12'h091; //[0067]SUBWF
memoryArray[104]=12'h743; //[0068]BTFSS
memoryArray[105]=12'ha71; //[0069]GOTO
memoryArray[106]=12'h216; //[006a]MOVF
memoryArray[107]=12'h092; //[006b]SUBWF
memoryArray[108]=12'h743; //[006c]BTFSS
memoryArray[109]=12'ha71; //[006d]GOTO
memoryArray[110]=12'hcff; //[006e]MOVLW
memoryArray[111]=12'h027; //[006f]MOVWF
memoryArray[112]=12'ha72; //[0070]GOTO
memoryArray[113]=12'h067; //[0071]CLRF
memoryArray[114]=12'h07c; //[0072]CLRF
memoryArray[115]=12'ha81; //[0073]GOTO
memoryArray[116]=12'ha81; //[0074]GOTO
memoryArray[117]=12'hc30; //[0075]MOVLW
memoryArray[118]=12'h0ad; //[0076]SUBWF
memoryArray[119]=12'hc13; //[0077]MOVLW
memoryArray[120]=12'h1dc; //[0078]ADDWF
memoryArray[121]=12'h024; //[0079]MOVWF
memoryArray[122]=12'h20d; //[007a]MOVF
memoryArray[123]=12'h020; //[007b]MOVWF
memoryArray[124]=12'hc01; //[007c]MOVLW
memoryArray[125]=12'h1dc; //[007d]ADDWF
memoryArray[126]=12'he03; //[007e]ANDLW
memoryArray[127]=12'h03c; //[007f]MOVWF
memoryArray[128]=12'ha81; //[0080]GOTO
memoryArray[129]=12'ha20; //[0081]GOTO
memoryArray[130]=12'hc00; //[0082]MOVLW
memoryArray[131]=12'h029; //[0083]MOVWF
memoryArray[132]=12'h003; //[0084]SLEEP

		end
	end

/*	always@(address or memoryArray[address]) // memoryArray[address] -> address
	begin
		data = memoryArray[address];
	end*/
endmodule
