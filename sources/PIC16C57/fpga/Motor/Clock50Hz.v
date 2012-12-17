module Clock50Hz(out, clk, rst);
output reg out;
input clk, rst;

reg [27:0] count;

always@(posedge clk)
begin
	if(rst) count <= 28'd0;
	else
	begin
		if(count > 28'd1000000) count <= 28'd0;
		else count <= count + 1;
	end
end

always@(count)
begin
	if(count <= 28'd500000) out = 1'b1;
	else out = 1'b0;
end

endmodule