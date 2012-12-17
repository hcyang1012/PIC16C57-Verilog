module DoorLock(out, motorControl, columnSel, scanData, inAVR, clk, rst);
//CPU Out
output [7:0] out;

//KeyPad
output [2:0] columnSel;
input [3:0] scanData;
input [7:0] inAVR;

//Motor
output [3:0] motorControl;

input clk, rst;


wire [3:0] keyPadData;
wire [7:0] RB;

wire [3:0] RAIn;

//input motorEn;
wire motorEn;

assign RAIn = !rst ? keyPadData : 4'hz;
assign motorEn = out[7];
assign RB = !rst ? inAVR : 8'hz;

PIC16C57 pic16C57(
	.RA(RAIn),
	.RB(RB),
	.RC(out),
	.clk(clk),
	.rst(rst)
	);
	
KeyPadModule keypad(
	.keypadData(keyPadData),
	.columnSel(columnSel),
	.scanData(scanData),
	.rst(rst),
	.clk(clk)
	);
MotorModule motor(.motorControl(motorControl), .en(motorEn), .clk(clk), .rst(rst));

endmodule