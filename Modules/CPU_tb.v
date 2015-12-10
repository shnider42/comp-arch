//CPU test bench

`timescale 1 ns/100 ps

module cpu_tb;
	reg rst;
	
	wire   [31:0] PCvalue; //address passed into PC(memory)
	wire    [31:0] inst;       //instructions passed into the CPU
	//Real Memory
	wire   [31:0] aluRes;       //address passed into real memory from ALU
	wire   [31:0]  readData1;    //read data(2) from registers into memory
	wire           memRead_en;    //enable pin from control unit to read from memory
	wire           memWrite_en;   //enable pin from control unit to write to memory
	wire    [31:0] memOut;        //output from memory passed into mux
	wire           clk;
	
	
	clock clock1(clk);
	CPU cpu1(clk, inst, memOut, PCvalue, aluRes, readData1, memRead_en, memWrite_en, rst);
	memory mem1(PCvalue, inst, aluRes, readData1, memRead_en, memWrite_en, memOut);

	initial begin
		rst = 1'b1;
		#10;
		rst = 1'b0;
		
		#2000; 
	end
	
endmodule