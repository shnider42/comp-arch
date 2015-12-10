//sign extend

module signExtend(inst16, inst32);
	input [15:0] inst16;
	output [31:0] inst32;
	
	wire inst16;
	reg inst32;
	
	
	assign inst32 = {{16{inst16[15]}}, inst16};

	
endmodule