`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:37:50 09/14/2012 
// Design Name: 
// Module Name:    Register11Bit 
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
module Register11Bit(out, in,rst, en, clk);
output	reg [10:0] out;
input		[10:0] in;
input rst;
input en;
input clk;

reg [10:0] nextValue;

always@(posedge clk)
begin
	out <= nextValue;
end

always@(rst or en or in or out)
begin
	if(rst)
	begin
		nextValue = 11'd0;
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