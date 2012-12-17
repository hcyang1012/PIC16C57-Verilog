module Motor(motorControl, en, clkEn, clk, rst);
output reg [3:0] motorControl;
input en, clkEn, clk, rst;

reg [2:0] currentState, nextState;

parameter IDLE = 3'd0;
parameter STATE1 = 3'd1;
parameter STATE2 = 3'd2;
parameter STATE3 = 3'd3;
parameter STATE4 = 3'd4;

always@(posedge clk)
begin
	currentState <= nextState;	
end

always@(currentState or rst or en or clkEn)
begin
	if(rst) nextState = IDLE;
	else
	begin
		if(en)
		begin
			if(clkEn)
			begin
				case(currentState)
					IDLE: nextState = STATE1;
					STATE1: nextState = STATE2;
					STATE2: nextState = STATE3;
					STATE3: nextState = STATE4;
					STATE4: nextState = STATE1;
					default: nextState = IDLE;
				endcase
			end
			else
			begin
				case(currentState)
					IDLE: nextState = IDLE;
					STATE1: nextState = STATE1;
					STATE2: nextState = STATE2;
					STATE3: nextState = STATE3;
					STATE4: nextState = STATE4;
					default: nextState = IDLE;
				endcase	
			end
		end
		else
		begin
			case(currentState)
				IDLE: nextState = IDLE;
				STATE1: nextState = STATE1;
				STATE2: nextState = STATE2;
				STATE3: nextState = STATE3;
				STATE4: nextState = STATE4;
				default: nextState = IDLE;
			endcase		
		end
	end
end

always@(currentState)
begin
case(currentState)
	IDLE: motorControl = 4'b0000;
	STATE1: motorControl = 4'b1000;
	STATE2: motorControl = 4'b0100;
	STATE3: motorControl = 4'b0010;
	STATE4: motorControl = 4'b0001;
	default: motorControl = 4'b0000;
endcase	
end

endmodule