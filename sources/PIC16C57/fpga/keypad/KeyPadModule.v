module KeyPadModule(keypadData, columnSel, scanData, rst, clk);
output  [3:0] keypadData;
output [2:0] columnSel;
input [3:0] scanData;
input clk, rst;

wire [3:0] keyData;

wire clock;

Clock100Hz clock100Hz(
	.out(clock),
	.clk(clk),
	.rst(rst)
	);

KeyPad keypad(
	.keyData(keyData),
	.columnSel(columnSel),
	.scanData(scanData),
	.clk(clock),
	.rst(rst)
	);


	
	
KeyValueRegister keyValueRegister(
	.outputValue(keypadData),
	.inputValue(keyData),
	.clk(clock),
	.rst(rst)
	);
	

endmodule