module adder (in0, in1, out);
	parameter width = 32;
	input wire [width-1:0] in0;
	input wire [width-1:0] in1;
	output wire [width-1:0] out;
	
	assign out = in0 + in1;
	
endmodule