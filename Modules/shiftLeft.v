// Shift Left module
module shiftLeft(shiftLeft_in, shiftLeft_out);
	parameter width = 32;
	input [width-1:0] shiftLeft_in;
	output [width-1:0] shiftLeft_out;
	
	wire shiftLeft_in;
	wire shiftLeft_out;

	assign shiftLeft_out = {shiftLeft_in, 0, 0};

endmodule;
