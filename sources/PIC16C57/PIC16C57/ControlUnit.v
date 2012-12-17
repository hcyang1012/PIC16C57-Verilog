`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:17:43 09/15/2012 
// Design Name: 
// Module Name:    ControlUnit 
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
module ControlUnit(irEn, wEn, rfEn, trisEn, statusEn, rfSel, wSel, ASel, PCInc, ALUInst, databusSelect, stackInstruction, currentInstruction, d, statusReg, clk, rst);
	output	reg	irEn, wEn, rfEn, trisEn, statusEn, wSel, PCInc;
	output	reg	[1:0]	ASel;
	output	reg	[7:0]	ALUInst;
	output	reg	[3:0]	databusSelect;
	output	reg	[1:0]	stackInstruction;
	output	reg	[1:0]	rfSel;
	input		[5:0]		currentInstruction;
	input 	[7:0] 	statusReg;
	input				d;
	input 			clk, rst;

	wire test = statusReg[7];
	
	//Stack Command
	parameter	PUSH	= 2'd0;
	parameter	POP	= 2'd1;
	parameter	S_NO	= 2'd2;


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
	parameter RLF = 8'd10;
	parameter RRF = 8'd11;
	parameter BsubA = 8'd12;	
	parameter swapB = 8'd13;	
	parameter AxorB = 8'd14;	
	parameter BCF = 8'd15;
	parameter BSF = 8'd16;
	parameter BTest = 8'd17;

	//PC Selection
	parameter incPC = 1'b0;
	parameter branchPC = 1'b1;
	
	//W Selection
	parameter	wIn_literal = 1'b0;
	parameter	wIn_databus = 1'b1;
	
	//Data Bus Selection
	parameter W					= 4'd0;
	parameter ALU				= 4'd1;
	parameter registerFile	= 4'd2;
	parameter status			= 4'd3;

	//Register File Selection
	parameter rfSel_Databus = 2'd0;
	parameter rfSel_Stack = 2'd1;
	parameter rfSel_literal = 2'd2;
	
	reg	[7:0]	nextState, currentState;
	
	//Decoder Result
	parameter DECODE_ADDWF = 6'd0;
	parameter DECODE_OTHERS = 6'd1;
	parameter DECODE_ANDWF = 6'd2;
	parameter DECODE_CLRF = 6'd3;
	parameter DECODE_CLRW = 6'd4;
	parameter DECODE_DECF = 6'd5;
	parameter DECODE_DECFSZ = 6'd6;
	parameter DECODE_COMF = 6'd7;
	parameter DECODE_INCF = 6'd8;
	parameter DECODE_INCFSZ = 6'd9;
	parameter DECODE_IORWF = 6'd10;
	parameter DECODE_MOVF = 6'd11;
	parameter DECODE_MOVWF = 6'd12;
	parameter DECODE_RLF = 6'd13;
	parameter DECODE_RRF = 6'd14;
	parameter DECODE_SUBWF = 6'd15;
	parameter DECODE_SWAPF = 6'd16;
	parameter DECODE_XORWF = 6'd17;
	parameter DECODE_BCF = 6'd18;
	parameter DECODE_BSF = 6'd19;
	parameter DECODE_BTFSC = 6'd20;
	parameter DECODE_BTFSS = 6'd21;
	parameter DECODE_ANDLW = 6'd22;
	parameter DECODE_CALL = 6'd23;
	parameter DECODE_RETLW = 6'd24;
	parameter DECODE_GOTO = 6'd25;
	parameter DECODE_IORLW = 6'd26;
	parameter DECODE_XORLW = 6'd27;
	parameter DECODE_MOVLW = 6'd28;
	parameter DECODE_TRIS = 6'd29;
	parameter DECODE_OPTION = 6'd30;
	
	//State machine

	//States
	parameter IDLE			= 8'd0;
	parameter Q1			= 8'd1;
	
	//States : ADDWF
	parameter ADDWF_Q2	= 8'd2;
	parameter ADDWF_Q3	= 8'd3;
	parameter ADDWF_Q4	= 8'd4;
	
	//States : OTHERS
	parameter OTHERS_Q2	= 8'd5;
	parameter OTHERS_Q3	= 8'd6;
	parameter OTHERS_Q4	= 8'd7;

	//States : ANDWF
	parameter ANDWF_Q2	= 8'd8;
	parameter ANDWF_Q3	= 8'd9;
	parameter ANDWF_Q4	= 8'd10;
	
	//States : CLRF
	parameter CLRF_Q2	= 8'd11;
	parameter CLRF_Q3	= 8'd12;
	parameter CLRF_Q4	= 8'd13;
	
	//States : CLRW
	parameter CLRW_Q2	= 8'd14;
	parameter CLRW_Q3	= 8'd15;
	parameter CLRW_Q4	= 8'd16;
	
	//States : DECF
	parameter DECF_Q2	= 8'd17;
	parameter DECF_Q3	= 8'd18;
	parameter DECF_Q4	= 8'd19;
	
	//States : DECFSZ
	parameter DECFSZ_Q2	= 8'd20;
	parameter DECFSZ_Q3	= 8'd21;
	parameter DECFSZ_Q4	= 8'd22;
	parameter DECFSZ_Q5	= 8'd23;

	//States : COMF
	parameter COMF_Q2	= 8'd24;
	parameter COMF_Q3	= 8'd25;
	parameter COMF_Q4	= 8'd26;

	//States : INCF
	parameter INCF_Q2	= 8'd27;
	parameter INCF_Q3	= 8'd28;
	parameter INCF_Q4	= 8'd29;

	//States : INCFSZ
	parameter INCFSZ_Q2	= 8'd30;
	parameter INCFSZ_Q3	= 8'd31;
	parameter INCFSZ_Q4	= 8'd32;
	parameter INCFSZ_Q5	= 8'd33;
	
	//States : IORWF
	parameter IORWF_Q2	= 8'd34;
	parameter IORWF_Q3	= 8'd35;
	parameter IORWF_Q4	= 8'd36;	

	//States : MOVF
	parameter MOVF_Q2	= 8'd37;
	parameter MOVF_Q3	= 8'd38;
	parameter MOVF_Q4	= 8'd39;

	//States : MOVWF
	parameter MOVWF_Q2	= 8'd40;
	parameter MOVWF_Q3	= 8'd41;
	parameter MOVWF_Q4	= 8'd42;
	
	//States : RLF
	parameter RLF_Q2	= 8'd43;
	parameter RLF_Q3	= 8'd44;
	parameter RLF_Q4	= 8'd45;	

	//States : RRF
	parameter RRF_Q2	= 8'd46;
	parameter RRF_Q3	= 8'd47;
	parameter RRF_Q4	= 8'd48;	
	
	//States : SUBWF
	parameter SUBWF_Q2	= 8'd49;
	parameter SUBWF_Q3	= 8'd50;
	parameter SUBWF_Q4	= 8'd51;	
	
	//States : SWAPF
	parameter SWAPF_Q2	= 8'd52;
	parameter SWAPF_Q3	= 8'd53;
	parameter SWAPF_Q4	= 8'd54;
	
	//States : XORWF
	parameter XORWF_Q2	= 8'd55;
	parameter XORWF_Q3	= 8'd56;
	parameter XORWF_Q4	= 8'd57;
	
	//States : BCF
	parameter BCF_Q2	= 8'd58;
	parameter BCF_Q3	= 8'd59;
	parameter BCF_Q4	= 8'd60;

	//States : BSF
	parameter BSF_Q2	= 8'd61;
	parameter BSF_Q3	= 8'd62;
	parameter BSF_Q4	= 8'd63;

	//States : BTFSC
	parameter BTFSC_Q2	= 8'd64;
	parameter BTFSC_Q3	= 8'd65;
	parameter BTFSC_Q4	= 8'd66;
	parameter BTFSC_Q5	= 8'd67;

	//States : BTFSS
	parameter BTFSS_Q2	= 8'd68;
	parameter BTFSS_Q3	= 8'd69;
	parameter BTFSS_Q4	= 8'd70;
	parameter BTFSS_Q5	= 8'd71;

	//States : ANDLW
	parameter ANDLW_Q2	= 8'd72;
	parameter ANDLW_Q3	= 8'd73;
	parameter ANDLW_Q4	= 8'd74;

	//States : CALL
	parameter CALL_Q2	= 8'd75;
	parameter CALL_Q3	= 8'd76;
	parameter CALL_Q4	= 8'd77;
	parameter CALL_Q5	= 8'd78;
	parameter CALL_Q6	= 8'd79;
	parameter CALL_Q7	= 8'd80;
	parameter CALL_Q8	= 8'd81;

	//States : RETLW
	parameter RETLW_Q2	= 8'd82;
	parameter RETLW_Q3	= 8'd83;
	parameter RETLW_Q4	= 8'd84;
	parameter RETLW_Q5	= 8'd85;
	parameter RETLW_Q6	= 8'd86;
	parameter RETLW_Q7	= 8'd87;
	parameter RETLW_Q8	= 8'd88;

	//States : GOTO
	parameter GOTO_Q2	= 8'd89;
	parameter GOTO_Q3	= 8'd90;
	parameter GOTO_Q4	= 8'd91;
	parameter GOTO_Q5	= 8'd92;
	parameter GOTO_Q6	= 8'd93;
	parameter GOTO_Q7	= 8'd94;
	parameter GOTO_Q8	= 8'd95;
	
	//States : IORLW
	parameter IORLW_Q2	= 8'd96;
	parameter IORLW_Q3	= 8'd97;
	parameter IORLW_Q4	= 8'd98;
	
	//States : XORLW
	parameter XORLW_Q2	= 8'd99;
	parameter XORLW_Q3	= 8'd100;
	parameter XORLW_Q4	= 8'd101;

	//States : MOVLW
	parameter MOVLW_Q2	= 8'd102;
	parameter MOVLW_Q3	= 8'd103;
	parameter MOVLW_Q4	= 8'd104;
	
	//States : TRIS
	parameter TRIS_Q2	= 8'd105;
	parameter TRIS_Q3	= 8'd106;
	parameter TRIS_Q4	= 8'd107;
	
	always@(posedge clk)
	begin
		currentState <= nextState;
	end

	//output
	always@(currentState or d or statusReg[2] or test)
	begin
		irEn					= 1'b0;
		wEn					= 1'b0;
		rfEn					= 1'b0;
		statusEn				= 1'b0;
		ASel					= 1'b0;
		ALUInst				= AplusB;
		wSel					= wIn_literal;
		databusSelect		= W;
		stackInstruction 	= S_NO;
		rfSel 				= rfSel_Databus;
		PCInc 				= 1'd0;
		trisEn				= 1'd0;
		case(currentState)
			IDLE:
			begin
				irEn = 1'b1;
			end

			Q1:
			begin
				irEn = 1'b1;
				PCInc = 1'd1;
			end
			
			ADDWF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			ADDWF_Q3:
			begin
				ALUInst = AplusB;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			ADDWF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end
			//
			ANDWF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			ANDWF_Q3:
			begin
				ALUInst = AandB;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			ANDWF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end
			
			//
			CLRF_Q2:
			begin
			end
			
			CLRF_Q3:
			begin
				ALUInst = AxorA;
				databusSelect = ALU;
			end

			CLRF_Q4:
			begin
				rfEn = 1'b1;
				irEn = 1'b1;
			end
			
			//
			CLRW_Q2:
			begin
			end
			
			CLRW_Q3:
			begin
				ALUInst = AxorA;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			CLRW_Q4:
			begin
				wSel = wIn_databus;
				wEn = 1'b1;
				irEn = 1'b1;
			end
			
			//
			DECF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			DECF_Q3:
			begin
				ALUInst = Bsub1;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			DECF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end

			//DECFSZ
			DECFSZ_Q2:
			begin
				databusSelect = registerFile;
			end
			
			DECFSZ_Q3:
			begin
				ALUInst = Bsub1;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			DECFSZ_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				if(statusReg[2] == 1'b1)
					irEn = 1'b0;
				else
				begin
					PCInc = 1'd1;				
				end
			end

			DECFSZ_Q5:
			begin
				PCInc = 1'd1;				
			end

			//
			COMF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			COMF_Q3:
			begin
				ALUInst = Bcomp;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			COMF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end

			//
			INCF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			INCF_Q3:
			begin
				ALUInst = Bplus1;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			INCF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end

			//INCFSZ
			INCFSZ_Q2:
			begin
				databusSelect = registerFile;
			end
			
			INCFSZ_Q3:
			begin
				ALUInst = Bplus1;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			INCFSZ_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				if(statusReg[2] == 1'b1)
					irEn = 1'b0;
				else
				begin
					PCInc = 1'd1;				
				end
			end

			INCFSZ_Q5:
			begin
				PCInc = 1'd1;				
			end

			//
			IORWF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			IORWF_Q3:
			begin
				ALUInst = AorB;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			IORWF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end

			MOVF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			MOVF_Q3:
			begin
				ALUInst = Bout;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			MOVF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end

			MOVWF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			MOVWF_Q3:
			begin
				ALUInst = Aout;
				databusSelect = ALU;
			end

			MOVWF_Q4:
			begin
				rfEn = 1'b1;
				irEn = 1'b1;
			end

			//
			RLF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			RLF_Q3:
			begin
				ALUInst = RLF;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			RLF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end

			//
			RRF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			RRF_Q3:
			begin
				ALUInst = RRF;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			RRF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end
			
			SUBWF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			SUBWF_Q3:
			begin
				ALUInst = BsubA;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			SUBWF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end			
			
			SWAPF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			SWAPF_Q3:
			begin
				ALUInst = swapB;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			SWAPF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end		
			
			XORWF_Q2:
			begin
				databusSelect = registerFile;
			end
			
			XORWF_Q3:
			begin
				ALUInst = AxorB;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			XORWF_Q4:
			begin
				if(d == 1'b1)
				begin
					rfEn = 1'b1;
				end
				else
				begin
					wSel = wIn_databus;
					wEn = 1'b1;
				end
				irEn = 1'b1;
			end	

			BCF_Q2:
			begin
				databusSelect = registerFile;			
			end
			
			BCF_Q3:
			begin
				ALUInst = BCF;
				databusSelect = ALU;
				ASel = 1'b1;
			end

			BCF_Q4:
			begin
				rfEn = 1'b1;		
				irEn = 1'b1;
			end

			BSF_Q2:
			begin
				databusSelect = registerFile;			
			end
			
			BSF_Q3:
			begin
				ALUInst = BSF;
				databusSelect = ALU;
				ASel = 1'b1;
			end

			BSF_Q4:
			begin
				rfEn = 1'b1;		
				irEn = 1'b1;
			end
			
			// NOP
			OTHERS_Q2:
			begin
				//NO operation
			end			

			OTHERS_Q3:
			begin
				//NO operation
			end

			OTHERS_Q4:
			begin
				//NO operation
				irEn = 1'b1;
			end

			//BTFSC
			BTFSC_Q2:
			begin
				databusSelect = registerFile;
			end
			
			BTFSC_Q3:
			begin
				ALUInst = BTest;
				databusSelect = ALU;
				ASel = 1'b1;
				statusEn = 1'b1;
			end

			BTFSC_Q4:
			begin
				if(test == 1'b0)
					irEn = 1'b1;	//NoSkip
				else
				begin
					PCInc = 1'd1;		//Skip		
				end
			end

			BTFSC_Q5:
			begin
			end

			//BTFSS
			BTFSS_Q2:
			begin
				databusSelect = registerFile;
			end
			
			BTFSS_Q3:
			begin
				ALUInst = BTest;
				ASel = 1'b1;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			BTFSS_Q4:
			begin
				if(test == 1'b1)	//No Skip
					irEn = 1'b1;
				else		//Skip
				begin
					PCInc = 1'd1;				
				end
			end

			BTFSS_Q5:
			begin
			end
			
			ANDLW_Q2:
			begin
				databusSelect = W;
			end
			
			ANDLW_Q3:
			begin
				ASel = 2'd2;
				ALUInst = AandB;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			ANDLW_Q4:
			begin
				wSel = wIn_databus;
				wEn = 1'b1;
				irEn = 1'b1;
			end			

			CALL_Q2:
			begin
				stackInstruction = PUSH;				
			end
			
			CALL_Q3:
			begin
			end

			CALL_Q4:
			begin

			end

			CALL_Q5:
			begin
				
			end
			
			CALL_Q6:
			begin
				rfSel = rfSel_literal;
				rfEn				= 1'b1;
			end

			CALL_Q7:
			begin

			end

			CALL_Q8:
			begin
				irEn = 1'b1;
			end

			RETLW_Q2:
			begin
				wSel = wIn_literal;
				wEn = 1'b1;
			end
			
			RETLW_Q3:
			begin
			end

			RETLW_Q4:
			begin

			end

			RETLW_Q5:
			begin
				
			end
			
			RETLW_Q6:
			begin
				stackInstruction = POP;
				rfSel = rfSel_Stack;
				rfEn				= 1'b1;
			end

			RETLW_Q7:
			begin

			end

			RETLW_Q8:
			begin
				irEn = 1'b1;
			end

			GOTO_Q2:
			begin

			end
			
			GOTO_Q3:
			begin
			end

			GOTO_Q4:
			begin

			end

			GOTO_Q5:
			begin
				
			end
			
			GOTO_Q6:
			begin
				rfSel = rfSel_literal;
				rfEn				= 1'b1;
			end

			GOTO_Q7:
			begin

			end

			GOTO_Q8:
			begin
				irEn = 1'b1;
			end
			
			
			IORLW_Q2:
			begin
				databusSelect = W;
			end
			
			IORLW_Q3:
			begin
				ASel = 2'd2;
				ALUInst = AorB;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			IORLW_Q4:
			begin
				wSel = wIn_databus;
				wEn = 1'b1;
				irEn = 1'b1;
			end			
			
			XORLW_Q2:
			begin
				databusSelect = W;
			end
			
			XORLW_Q3:
			begin
				ASel = 2'd2;
				ALUInst = AxorB;
				databusSelect = ALU;
				statusEn = 1'b1;
			end

			XORLW_Q4:
			begin
				wSel = wIn_databus;
				wEn = 1'b1;
				irEn = 1'b1;
			end			
			
			MOVLW_Q2:
			begin
				databusSelect = W;
			end
			
			MOVLW_Q3:
			begin
				ASel = 2'd2;
				ALUInst = Aout;
				databusSelect = ALU;
			end

			MOVLW_Q4:
			begin
				wSel = wIn_databus;
				wEn = 1'b1;
				irEn = 1'b1;
			end

			TRIS_Q2:
			begin
			end
			
			TRIS_Q3:
			begin
				trisEn = 1'b1;
			end

			TRIS_Q4:
			begin
				irEn = 1'b1;
			end
			
			default:
			begin
				irEn				= 1'b0;
				wEn				= 1'b0;
				rfEn				= 1'b0;
				ALUInst			= AplusB;
				PCInc				= 1'b0;
				databusSelect	= W;
			end		
		endcase
	end
	
	//next State
	always@(currentState or currentInstruction or rst or statusReg[2] or test)
	begin
		if(rst)
		begin
			nextState = IDLE;
		end
		else
			begin
			case(currentState)
				IDLE:
				begin
					nextState = Q1;
				end

				Q1:
				begin
					case(currentInstruction)
						DECODE_ADDWF: nextState = ADDWF_Q2;
						DECODE_ANDWF: nextState = ANDWF_Q2;
						DECODE_CLRF: nextState = CLRF_Q2;
						DECODE_CLRW: nextState = CLRW_Q2;
						DECODE_DECF: nextState = DECF_Q2;
						DECODE_DECFSZ: nextState = DECFSZ_Q2;
						DECODE_COMF: nextState = COMF_Q2;
						DECODE_INCF: nextState = INCF_Q2;
						DECODE_INCFSZ: nextState = INCFSZ_Q2;
						DECODE_IORWF: nextState = IORWF_Q2;
						DECODE_MOVF: nextState = MOVF_Q2;
						DECODE_MOVWF: nextState = MOVWF_Q2;
						DECODE_RLF: nextState = RLF_Q2;
						DECODE_RRF: nextState = RRF_Q2;
						DECODE_SUBWF: nextState = SUBWF_Q2;
						DECODE_SWAPF: nextState = SWAPF_Q2;
						DECODE_XORWF: nextState = XORWF_Q2;
						DECODE_BCF: nextState = BCF_Q2;
						DECODE_BSF: nextState = BSF_Q2;
						DECODE_BTFSC: nextState = BTFSC_Q2;
						DECODE_BTFSS: nextState = BTFSS_Q2;
						DECODE_ANDLW: nextState = ANDLW_Q2;
						DECODE_CALL: nextState = CALL_Q2;
						DECODE_RETLW: nextState = RETLW_Q2;
						DECODE_GOTO: nextState = GOTO_Q2;
						DECODE_IORLW: nextState = IORLW_Q2;
						DECODE_XORLW: nextState = XORLW_Q2;
						DECODE_MOVLW: nextState = MOVLW_Q2;
						DECODE_TRIS: nextState = TRIS_Q2;
						default: nextState = OTHERS_Q2;
					endcase
				end
				
				ADDWF_Q2:
				begin
					nextState = ADDWF_Q3;
				end
				
				ADDWF_Q3:
				begin
					nextState = ADDWF_Q4;
				end

				ADDWF_Q4:
				begin
					nextState = Q1;
				end
				
				ANDWF_Q2:
				begin
					nextState = ANDWF_Q3;
				end
				
				ANDWF_Q3:
				begin
					nextState = ANDWF_Q4;
				end

				ANDWF_Q4:
				begin
					nextState = Q1;
				end
				
				//
				CLRF_Q2:
				begin
					nextState = CLRF_Q3;
				end
				
				CLRF_Q3:
				begin
					nextState = CLRF_Q4;
				end

				CLRF_Q4:
				begin
					nextState = Q1;
				end
				
				//
				CLRW_Q2:
				begin
					nextState = CLRW_Q3;
				end
				
				CLRW_Q3:
				begin
					nextState = CLRW_Q4;
				end

				CLRW_Q4:
				begin
					nextState = Q1;
				end
				
				DECF_Q2:
				begin
					nextState = DECF_Q3;
				end
				
				DECF_Q3:
				begin
					nextState = DECF_Q4;
				end

				DECF_Q4:
				begin
					nextState = Q1;
				end
				
				DECFSZ_Q2:
				begin
					nextState = DECFSZ_Q3;
				end
				
				DECFSZ_Q3:
				begin
					nextState = DECFSZ_Q4;
				end

				DECFSZ_Q4:
				begin
				if(statusReg[2] == 1'b1)
						nextState = DECFSZ_Q5;
				else
					nextState = Q1;
				end

				DECFSZ_Q5:
				begin
					nextState = OTHERS_Q2;
				end
				
				INCF_Q2:
				begin
					nextState = INCF_Q3;
				end
				
				INCF_Q3:
				begin
					nextState = INCF_Q4;
				end

				INCF_Q4:
				begin
					nextState = Q1;
				end

				INCFSZ_Q2:
				begin
					nextState = INCFSZ_Q3;
				end
				
				INCFSZ_Q3:
				begin
					nextState = INCFSZ_Q4;
				end

				INCFSZ_Q4:
				begin
				if(statusReg[2] == 1'b1)
						nextState = INCFSZ_Q5;
				else
					nextState = Q1;
				end

				INCFSZ_Q5:
				begin
					nextState = OTHERS_Q2;
				end
				
				OTHERS_Q2:
				begin
					nextState = OTHERS_Q3;
				end			

				OTHERS_Q3:
				begin
					nextState = OTHERS_Q4;
				end

				COMF_Q2:
				begin
					nextState = COMF_Q3;
				end
				
				COMF_Q3:
				begin
					nextState = COMF_Q4;
				end

				COMF_Q4:
				begin
					nextState = Q1;
				end

				IORWF_Q2:
				begin
					nextState = IORWF_Q3;
				end
				
				IORWF_Q3:
				begin
					nextState = IORWF_Q4;
				end

				IORWF_Q4:
				begin
					nextState = Q1;
				end

				MOVF_Q2:
				begin
					nextState = MOVF_Q3;
				end
				
				MOVF_Q3:
				begin
					nextState = MOVF_Q4;
				end

				MOVF_Q4:
				begin
					nextState = Q1;
				end

				MOVWF_Q2:
				begin
					nextState = MOVWF_Q3;
				end
				
				MOVWF_Q3:
				begin
					nextState = MOVWF_Q4;
				end

				MOVWF_Q4:
				begin
					nextState = Q1;
				end

				RLF_Q2:
				begin
					nextState = RLF_Q3;
				end
				
				RLF_Q3:
				begin
					nextState = RLF_Q4;
				end

				RLF_Q4:
				begin
					nextState = Q1;
				end

				RRF_Q2:
				begin
					nextState = RRF_Q3;
				end
				
				RRF_Q3:
				begin
					nextState = RRF_Q4;
				end

				RRF_Q4:
				begin
					nextState = Q1;
				end
				
				SUBWF_Q2:
				begin
					nextState = SUBWF_Q3;
				end
				
				SUBWF_Q3:
				begin
					nextState = SUBWF_Q4;
				end

				SUBWF_Q4:
				begin
					nextState = Q1;
				end
				
				SWAPF_Q2:
				begin
					nextState = SWAPF_Q3;
				end
				
				SWAPF_Q3:
				begin
					nextState = SWAPF_Q4;
				end

				SWAPF_Q4:
				begin
					nextState = Q1;
				end
				
				XORWF_Q2:
				begin
					nextState = XORWF_Q3;
				end
				
				XORWF_Q3:
				begin
					nextState = XORWF_Q4;
				end

				XORWF_Q4:
				begin
					nextState = Q1;
				end
				
				BCF_Q2:
				begin
					nextState = BCF_Q3;
				end
				
				BCF_Q3:
				begin
					nextState = BCF_Q4;
				end

				BCF_Q4:
				begin
					nextState = Q1;
				end

				BSF_Q2:
				begin
					nextState = BSF_Q3;
				end
				
				BSF_Q3:
				begin
					nextState = BSF_Q4;
				end

				BSF_Q4:
				begin
					nextState = Q1;
				end

				BTFSC_Q2:
				begin
					nextState = BTFSC_Q3;
				end
				
				BTFSC_Q3:
				begin
					nextState = BTFSC_Q4;
				end

				BTFSC_Q4:
				begin
				if(test == 1'b1)		//Skip
						nextState = BTFSC_Q5;
				else		//No Skip
					nextState = Q1;
				end

				BTFSC_Q5:
				begin
					nextState = OTHERS_Q2;
				end

				BTFSS_Q2:
				begin
					nextState = BTFSS_Q3;
				end
				
				BTFSS_Q3:
				begin
					nextState = BTFSS_Q4;
				end

				BTFSS_Q4:
				begin
				if(test == 1'b0)	//Skip
						nextState = BTFSS_Q5;
				else		//No Skip
					nextState = Q1;
				end

				BTFSS_Q5:
				begin
					nextState = OTHERS_Q2;
				end

				ANDLW_Q2:
				begin
					nextState = ANDLW_Q3;
				end
				
				ANDLW_Q3:
				begin
					nextState = ANDLW_Q4;
				end

				ANDLW_Q4:
				begin
					nextState = Q1;
				end

				CALL_Q2:
				begin
					nextState = CALL_Q3;
				end
				
				CALL_Q3:
				begin
					nextState = CALL_Q4;
				end

				CALL_Q4:
				begin
					nextState = CALL_Q5;
				end

				CALL_Q5:
				begin
					nextState = CALL_Q6;
				end
				
				CALL_Q6:
				begin
					nextState = CALL_Q7;
				end

				CALL_Q7:
				begin
					nextState = CALL_Q8;
				end

				CALL_Q8:
				begin
					nextState = Q1;
				end

				RETLW_Q2:
				begin
					nextState = RETLW_Q3;
				end
				
				RETLW_Q3:
				begin
					nextState = RETLW_Q4;
				end

				RETLW_Q4:
				begin
					nextState = RETLW_Q5;
				end

				RETLW_Q5:
				begin
					nextState = RETLW_Q6;
				end
				
				RETLW_Q6:
				begin
					nextState = RETLW_Q7;
				end

				RETLW_Q7:
				begin
					nextState = RETLW_Q8;
				end

				RETLW_Q8:
				begin
					nextState = Q1;
				end

				GOTO_Q2:
				begin
					nextState = GOTO_Q3;
				end
				
				GOTO_Q3:
				begin
					nextState = GOTO_Q4;
				end

				GOTO_Q4:
				begin
					nextState = GOTO_Q5;
				end

				GOTO_Q5:
				begin
					nextState = GOTO_Q6;
				end
				
				GOTO_Q6:
				begin
					nextState = GOTO_Q7;
				end

				GOTO_Q7:
				begin
					nextState = GOTO_Q8;
				end

				GOTO_Q8:
				begin
					nextState = Q1;
				end
				
				IORLW_Q2:
				begin
					nextState = IORLW_Q3;
				end
				
				IORLW_Q3:
				begin
					nextState = IORLW_Q4;
				end

				IORLW_Q4:
				begin
					nextState = Q1;
				end
				
				XORLW_Q2:
				begin
					nextState = XORLW_Q3;
				end
				
				XORLW_Q3:
				begin
					nextState = XORLW_Q4;
				end

				XORLW_Q4:
				begin
					nextState = Q1;
				end
				
				MOVLW_Q2:
				begin
					nextState = MOVLW_Q3;
				end
				
				MOVLW_Q3:
				begin
					nextState = MOVLW_Q4;
				end

				MOVLW_Q4:
				begin
					nextState = Q1;
				end

				TRIS_Q2:
				begin
					nextState = TRIS_Q3;
				end
				
				TRIS_Q3:
				begin
					nextState = TRIS_Q4;
				end

				TRIS_Q4:
				begin
					nextState = Q1;
				end
				
				OTHERS_Q4:
				begin
					nextState = Q1;
				end				
				
				default:
				begin
					nextState = IDLE;
				end		
			endcase
		end	

		end
endmodule
