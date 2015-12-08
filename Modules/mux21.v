// problem 1
// 2 to 1 multiplexor

module mux21 (in, sel, out);
	input [1:0] in;
	input sel;
	output out;
	reg out;
	
	always@ (*)
	begin
		if (sel)
		begin
			out = in[0];
		end
		else if (~sel)
		begin
			out = in[1];
		end
	end
	
endmodule