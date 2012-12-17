`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:30:20 09/14/2012 
// Design Name: 
// Module Name:    Register8Bit 
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
module Register8Bit(out, in,rst, en, clk);
output	reg [7:0] out;
input		[7:0] in;
input rst;
input en;
input clk;

reg [7:0] nextValue;

always@(posedge clk)
begin
	out <= nextValue;
end

always@(rst or en or in or out)
begin
	if(rst)
	begin
		nextValue = 8'd1;
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