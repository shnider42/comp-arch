module adder (in0, in1, out);
	parameter width = 32;
	input [width-1:0]in0;
	input [width-1:0]in1;
	output [31:0]out;
	reg out;
	
	always@ (*)
	begin
		assign out = in0 + in1;
	end
	
endmodule