//CPU module
module CPU (clk, inst, memOut, PCvalue, aluRes, readData1, memRead_en, memWrite_en, rst);

	// Interface to memory
	//PC
	output   [31:0] PCvalue; //address passed into PC(memory)
	input    [31:0]  inst;       //instructions passed into the CPU
	//Real Memory
	output   [31:0] aluRes;       //address passed into real memory from ALU
	output   [31:0]  readData1;    //read data(2) from registers into memory
	output           memRead_en;    //enable pin from control unit to read from memory
	output           memWrite_en;   //enable pin from control unit to write to memory
	input    [31:0]  memOut;        //output from memory passed into mux
	input            clk;
	input rst;
	wire rst;
	
	//clock
	wire clk;
	clock clk1(clk);

	//Program Counter
	wire [31:0] PC_addr_in;              // input to PC (address)
	wire [31:0] PCvalue;
	wire [31:0] pcAdd4;
	PC PC1(PC_addr_in, PCvalue, rst, clk);
	assign pcAdd4 = PCvalue + 4;
	
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
	//wire regWrite_en, clk; //write enable and clock
	wire [31:0] readData0, readData1;
	reg3232 regs_1(inst[25:21], inst[20:16], writeReg, wb_data, regWrite_en,
				   clk, readData0, readData1);

	//sign extend
	wire [31:0] inst15_0_32;
	signExtend SE1(inst[15:0], inst15_0_32);
				   
	//aluCtrl
	wire [3:0] aluCtrlCode;
	aluCtrl aluCtrl1(aluOp, inst[5:0], aluCtrlCode);

	//alu
	//wire [3:0] aluCtrlCode;
	//wire [31:0] readData0;
	wire [31:0] aluIn2;
	wire [31:0] aluRes;
	wire ALU_zero;
	alu alu1(aluCtrlCode, readData0, aluIn2, aluRes, ALU_zero);

	//Shift lefts
	//jump shift left
	wire[31:0] inst15_0_32_sl;
	wire[27:0] jumpShiftOut;
	shiftLeftJump #(26) jumpShiftLeft(inst[25:0], jumpShiftOut);
	//concatenate output of jump shift left to make jump address
	wire [31:0] jumpAddr;
	assign jumpAddr = {pcAdd4[31:28], jumpShiftOut};
	
	//branch shift left
	shiftLeftBranch #(32) branchJumpShiftLeft(inst15_0_32, inst15_0_32_sl);

	//branch and ALU_zero AND
	wire branch_sel;
	//andMod and1(ALU_zero, branch, branch_sel);
	assign branch_sel = ALU_zero & branch_en;
	
	//branchAdder
	wire [31:0] add_branch;
	adder #(32) branchAdder(pcAdd4, inst15_0_32_sl, add_branch);

	//muxes
	// regDest mux
	mux21 #(5) regDestMux(inst[15:11], inst[20:16], regDest_en, writeReg);

	// aluSrc mux
	mux21 #(32) aluSrcMux(inst15_0_32, readData1, aluSrc_en, aluIn2);

	// branch mux
	wire [31:0] jumpMuxIn0;
	mux21 #(32) branchMux(add_branch, pcAdd4, branch_sel, jumpMuxIn0);

	// jump mux
	mux21 #(32) jumpMux(jumpAddr,jumpMuxIn0,jump_en, PC_addr_in);

	// memToReg mux
	mux21 #(32) memToRegMux(memOut, aluRes, memToReg_en, wb_data);

endmodule
