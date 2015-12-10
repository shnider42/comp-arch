//PC module

module(PC_input, PCvalue);
	input [31:0] PC_input;
	output [31:0] PCvalue;
	
	wire PC_input;
	reg PCvalue;

	assign PCvalue = PC_input;
	
endmodule