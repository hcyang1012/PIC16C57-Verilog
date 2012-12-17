module Register4Bit(out, in, en, clk, rst);
output reg [3:0] out;
input [3:0] in;
input en, clk, rst;

always@(posedge clk)
begin
	if(rst) out <= 4'd0;
	else
	begin
		if(en) out <= in;
	end
end

endmodule
