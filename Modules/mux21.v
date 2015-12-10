// problem 1
// 2 to 1 multiplexor

module mux21 (in0, in1, sel, out);
	parameter width = 32;
	input wire [width-1:0]in0;
	input wire [width-1:0]in1;
	input sel;
	output reg [width-1:0]out;
	
	always@ (*)
	begin
		if (sel)
		begin
			out = in0;
		end
		else if (~sel)
		begin
			out = in1;
		end
	end
	
endmodule