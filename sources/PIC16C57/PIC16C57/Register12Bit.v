`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:57:09 09/15/2012 
// Design Name: 
// Module Name:    Register12Bit 
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
module Register12Bit(out, in,rst, en, clk);
output	reg [11:0] out;
input		[11:0] in;
input rst;
input en;
input clk;

reg [11:0] nextValue;

always@(posedge clk)
begin
	out <= nextValue;
end

always@(rst or en or in or out)
begin
	if(rst)
	begin
		nextValue = 12'd0;
	end
	else
	begin
		if(en)
		begin
			nextValue = in;
		end
		else
		begin
			nextValue = out;
		end
	end
end

endmodule