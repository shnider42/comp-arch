//testbench for number 1

`timescale 1 ns/100 ps

module tb_mux21;
	reg [1:0] in;
	reg sel;
	wire out;

	mux21 testMux(sel, in, out);

	initial
	begin
		in = 2'b00;
		sel = 0;
	end

	initial
	begin
		#10 sel = 1;
		in = 2'b01;
		#20 sel = 0;
		in = 2'b10;
		#10 sel = 1;
		in = 2'b00;
		#20 sel = 0;
		in = 2'b11;
		#20 sel = 0;
		$finish;
	end

endmodule