//CPU module
module CPU (clk, inst, memOut, PC_addr_in, aluRes, readData1, memRead_en, memWrite_en);
	// Interface to memory
	//PC
	output   [4*8:1] PC_addr_in; //address passed into PC(memory)
	input    [31:0]  inst;       //instructions passed into the CPU
	//Real Memory
	output   [4*8:1] aluRes;       //address passed into real memory from ALU
	output   [31:0]  readData1;    //read data(2) from registers into memory
	output           memRead_en;    //enable pin from control unit to read from memory
	output           memWrite_en;   //enable pin from control unit to write to memory
	input    [31:0]  memOut;        //output from memory passed into mux

	//Program Counter
	//wire [31:0] PC_addr_in;  // input to PC (address)
	//wire [31:0] PCvalue;
	//PC PC1(PC_addr_in, PCvalue);
	assign PC_addr_in = PC_addr_in + 4;
	
	//ctrlUnit
	wire regDest_en;
	wire jump_en;
	wire branch_en;
	wire memRead_en;
	wire memToReg_en;
	wire memWrite_en;
	wire aluSrc_en;
	wire regWrite_en;
	wire [1:0] aluOp;
	ctrlUnit ctrlUnit1(regDest_en, jump_en, branch_en, memRead_en, memToReg_en, 
					   memWrite_en, aluSrc_en, regWrite_en, aluOp, inst[31:26]);

	//registers
	wire [4:0] writeReg; // which register to write to(output from regDestMux)
	wire [31:0] wb_data; //write back data from memory module
	wire regWrite_en, clk; //write enable and clock
	wire [31:0] readData0, readData1;
	reg3232 regs_1(inst[25:21], inst[20:16], wb_data, writeReg, regWrite_en,
				   clk, readData0, readData1);

	//sign extend
	wire inst15_0_32;
	signExtend SE1(inst[15:0], inst15_0_32);
				   
	//aluCtrl
	wire [3:0] aluCtrlCode;
	aluCtrl aluCtrl1(aluOp, inst[5:0], aluCtrlCode);

	//alu
	wire [3:0] aluCtrlCode;
	wire [31:0] readData0;
	wire [31:0] aluIn2;
	wire [31:0] aluRes;
	wire zero;
	alu alu1(aluCtrlCode, readData0, aluIn2, aluRes, zero);

	//Shift lefts
	//jump shift left
	shiftLeft SLjump(inst[25:0], pcAdd4);
	//branch shift left
	shiftLeft SLbranch(inst15_0_32, inst15_0_32_sl);

	//branch and ALU_zero AND
	wire ALU_zero, branch_en;
	wire branch_sel;
	//andMod and1(ALU_zero, branch, branch_sel);
	assign branch_sel = ALU_zero & branch;
	
	/*
	//pcValue (PCaddr adder)
	wire [2:0] four;
	wire [31:0] PCvalue;
	wire [31:0] PCadd4;
	assign four = 4'b1000;
	adder #(32) pcValueAdder(PCvalue, four, PCadd4);
	*/
	
	//branchAdder
	wire[31:0] inst15_0_32_sl;
	adder #(32) branchAdder(pcAdd4, inst15_0_32_sl, add_branch);

	//muxes
	// regDest mux
	mux21 #(32) regDestMux(inst[20:16], inst[15:11], regDest_en, writeReg);

	// aluSrc mux
	mux21 #(32) aluSrcMux(readData1, inst15_0_32, aluSrc_en, aluIn2);

	// branch mux
	mux21 #(32) branchMux(pcAdd4, add_branch, branchSel, jumpMuxIn0);

	// jump mux
	mux21 #(32) jumpMux(pcAdd4, jumpMuxIn0, jump_en, PC_addr_in);

	// memToReg mux
	mux21 #(32) memToRegMux(memOut, aluRes, memToReg_en, wb_data);


endmodule


/* make a separate module for the clock
initial begin
  clk = 0;
end

always begin
  #5 clk = ~clk;
end */
