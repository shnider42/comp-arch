//testbench for number 2

`timescale 1 ns/100 ps

module tb_reg3232;
	reg [4:0] read0, read1, write;
	reg [31:0] w_addr;
	reg w_en, clk;
	wire [31:0] readData0, readData1;

	reg3232 testRegs(read0, read1, write, w_en, clk, readData0, readData1);

	initial
	begin
		read0 = 5'b00000;
		read1 = 5'b00000;
		write = 5'b00000;
		readData0 = 32'b00000000000000000000000000000000;
		readData1 = 32'b00000000000000000000000000000000;
		w_addr = 32'b00000000000000000000000000000000;
		w_en = 0;
		clk = 0;
	end

	always begin
	#10 clk = ~clk;
	end

	initial
	begin
		#20 read0 = 5'b00100;
		#20 read1 = 5'b00011;
		#20 write = 5'b01000;
		#20 readData0 = 32'b00000000000000000000000000000111;
		#20 readData0 = 32'b00000000000000000000000000000111;
		#50 w_en = 1;
		#20 read0 = 5'b00100;
		#20 read1 = 5'b00011;
		#20 write = 5'b01000;
		#20 readData0 = 32'b00000000000000000000000000000111;
		#20 readData0 = 32'b00000000000000000000000000000111;
		$finish; 
	end

endmodule