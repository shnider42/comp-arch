//testbench for number 2

`timescale 1 ns/100 ps

module tb_reg32;
	reg [31:0] in;
	reg clk, reset, l_en;
	wire [31:0] out;

	reg32 testReg(clk, reset, l_en, in, out);

	initial
	begin
		in = 32'b00000000000000000000000000000000;
		reset = 0;
		l_en = 0;
		clk = 0;
	end
	
	always begin
	#10 clk = ~clk;
	end

	initial
	begin
		#20 in = 2;
		#20 in = 4;
		l_en = 1;
		#20 in = 2;
		#20 in = 4;
		reset = 1;
		#20 in = 2;
		#20 in = 4;
		#20 in = 2;
		#20 in = 4;
		reset = 0;
		l_en = 0;
		#20 in = 2;
		#20 in = 4;
		#20 in = 2;
		#20 in = 4;
		$finish;
	end
	
endmodule