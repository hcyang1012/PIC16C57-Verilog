module MotorModule(motorControl, en, clk, rst);
output [3:0] motorControl;
input en, clk, rst;

wire clock;

Clock50Hz clock50Hz(
	.out(clock),
	.clk(clk),
	.rst(rst)
	);
	
Motor motor(
	.motorControl(motorControl),
	.clkEn(clock),
	.en(en),
	.clk(clk),
	.rst(rst)
	);	

endmodule