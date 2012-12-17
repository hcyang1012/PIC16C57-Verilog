module Clock100Hz(out, clk, rst);
output reg out;
input clk, rst;

reg [15:0] count;

always@(posedge clk)
begin
	if(rst) count <= 16'd0;
	else
	begin
		if(count > 16'd5000) count <= 16'd0;
		else count <= count + 1;
	end
end

always@(count)
begin
	if(count <= 16'd2500) out = 1'b1;
	else out = 1'b0;
end

endmodule