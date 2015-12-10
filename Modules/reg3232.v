//problem 3
//32 32 bit registers

module reg3232(input[4:0] readreg1, readreg2, write_reg,
			   input [31:0] write_data,
			   input reg_write, clk,
			   output reg[31:0] read_data1, read_data2);

	reg[31:0] regfile[31:0];

	/*set behavior*/
	always@(readreg1 or readreg2) begin
		read_data1 <= regfile[readreg1];
		read_data2 <= regfile[readreg2];
	end

	/* set clock behavior*/
	always@(posedge clk) begin
		if(reg_write)
		regfile[write_reg] <= write_data;

	end
endmodule

/*module reg32(read0, read1, write, w_addr, w_en, w_addr, w_en, clk, readData0, readData1);
	input read0, read1, write; // addresses
	input w_addr; //actual data
	input w_en, clk; //write enable and clock
	output readData0, readData1;
	
	wire [4:0] read0, read1, write;
	wire [31:0] w_addr;
	wire w_en, clk;
	reg [31:0] readData0, readData1;

	//creating 32x32 array of registers
	reg [31:0] regs [0:31];
	
	//at input data change
	always@ (read0 or read1)
	begin
		readData0 = regs[read0]; //take data from address read0 within registers and make output
		readData1 = regs[read1];
	end
	
	// if enable is high at positive clock edge
	always@ (posedge clk)
	begin
		if(w_en)
			regs[write] = writeData; //store write data into write address
	end

endmodule*/






