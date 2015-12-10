//problem 3
//32 32 bit registers

module reg3232(input[4:0] readreg1, readreg2, write_reg,
			   input [31:0] write_data,
			   input reg_write, clk,
			   output reg[31:0] read_data1, read_data2);

	reg[31:0] regfile[31:0];
	
	initial begin
		regfile[0] = 0;
	end

	/*set behavior*/
	always@(readreg1 or readreg2 or regfile) begin
		read_data1 <= regfile[readreg1];
		read_data2 <= regfile[readreg2];
	end

	/* set clock behavior*/
	always@(posedge clk) begin
		if(reg_write)
		regfile[write_reg] <= write_data;
	end
endmodule







