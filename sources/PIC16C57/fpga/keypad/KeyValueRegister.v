module KeyValueRegister(outputValue, inputValue, clk, rst);
output reg [3:0] outputValue;
input [3:0] inputValue;
input clk, rst;

parameter NOINPUT = 3'd0;
parameter NEWINPUT = 3'd1;
parameter SCAN1 = 3'd2;
parameter SCAN2 = 3'd3;
parameter SCAN3 = 3'd4;

wire [3:0] currentValueOut;
reg currentValueEn;

Register4Bit currentValue(
	.out(currentValueOut),
	.in(inputValue),
	.en(currentValueEn),
	.clk(clk),
	.rst(rst)
	);
	

reg [2:0] currentState, nextState;


always@(posedge clk)
begin
	currentState <= nextState;
end


always@(currentState or inputValue or rst or currentValueOut)
begin
	if(rst)
		nextState = NOINPUT;
	else
	begin
		case(currentState)
			NOINPUT:
				if(inputValue == 4'hF) nextState = NOINPUT;
				else nextState = NEWINPUT;
			NEWINPUT:
				nextState = SCAN1;
			SCAN1:
				if(inputValue == 4'hF) nextState = SCAN2;
				else nextState = NEWINPUT;
			SCAN2:
				if(inputValue == 4'hF) nextState = SCAN3;
				else nextState = NEWINPUT;
			SCAN3:
				if(inputValue == 4'hF) nextState = NOINPUT;
				else
				begin
					if(currentValueOut == inputValue) nextState = SCAN1;
					else nextState = NEWINPUT;
				end
		endcase	
	end
end

always@(currentState or inputValue or currentValueOut)
begin
	case(currentState)
		NEWINPUT: currentValueEn = 1'b0;
		SCAN3:
		begin
			if(inputValue == 4'hF)  currentValueEn = 1'b0;
			else
			begin
				if(inputValue == currentValueOut) currentValueEn = 1'b0;
				else currentValueEn = 1'b1;
			end
		end
		default:
		begin
			if(inputValue == 4'hF)  currentValueEn = 1'b0;
			else currentValueEn = 1'b1;
		end
	endcase
end 
always@(currentState or currentValueOut)
begin
	case(currentState)
		NOINPUT:
			outputValue = 4'hF;
		default:
			outputValue = currentValueOut;
	endcase
end



endmodule