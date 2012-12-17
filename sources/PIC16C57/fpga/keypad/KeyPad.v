module KeyPad(keyData, columnSel, scanData, rst, clk);
output reg [3:0] keyData;
output reg [2:0] columnSel;
input [3:0] scanData;
input clk, rst;

parameter IDLE = 3'd0;
parameter COL0 = 2'd1;
parameter COL1 = 2'd2;
parameter COL2 = 2'd3;

reg [1:0] currentState, nextState;

always@(posedge clk)
begin
	currentState <= nextState;
end

always@(currentState or rst or scanData)
begin
	if(rst)
	begin
		nextState = IDLE;
	end
	else
	begin
		case(currentState)
			IDLE:nextState = COL0;
			COL0:nextState = COL1;
			COL1:nextState = COL2;
			COL2:nextState = COL0;
			default:nextState = IDLE;
		endcase
	end
end

always@(currentState or scanData)
begin
	case(currentState)
		IDLE:
		begin
			columnSel = 3'b001;
			keyData = 4'hF;
		end
		COL0:
		begin
			columnSel = 3'b001;
			case(scanData)
				4'b0001: keyData = 4'd1;
				4'b0010: keyData = 4'd4;
				4'b0100: keyData = 4'd7;
				4'b1000: keyData = 4'd10;
				default: keyData = 4'hF;
			endcase
		end
		COL1:
		begin
			columnSel = 3'b010;
			case(scanData)
				4'b0001: keyData = 4'd2;
				4'b0010: keyData = 4'd5;
				4'b0100: keyData = 4'd8;
				4'b1000: keyData = 4'd0;
				default: keyData = 4'hF;
			endcase
		end		
		COL2:
		begin
			columnSel = 3'b100;
			case(scanData)
				4'b0001: keyData = 4'd3;
				4'b0010: keyData = 4'd6;
				4'b0100: keyData = 4'd9;
				4'b1000: keyData = 4'd11;
				default: keyData = 4'hF;
			endcase
		end		
		default:
		begin
			columnSel = 3'b001;
			keyData = 4'hF;
		end
	endcase
end

endmodule