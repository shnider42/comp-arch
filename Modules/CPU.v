//CPU module

//inputs from instruction memory
wire inst[31:0];

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
wire [5:0] opCode;
ctrlUnit ctrlUnit1(regDest_en, jump_en, branch_en, memRead_en, memToReg_en, 
				   memWrite_en, aluSrc_en, regWrite_en, aluOp, opCode);

//registers
wire [4:0] writeReg; // which register to write to(output from regDestMux)
wire [31:0] writeBack; //write back data from memory module
wire regWrite_en, clk; //write enable and clock
wire [31:0] readData0, readData1;
reg3232 regs_1(inst[25:21], inst[20:16], writeBack, writeReg, regWrite_en,  
			   clk, readData0, readData1);

//aluCtrl
wire [3:0] aluOpSig;
aluCtrl aluCtrl1(aluOp, opCode, aluOpSig);

//alu
wire [3:0] op;
wire [31:0] data0;
wire [31:0] data1;
wire [31:0] aluRes;
wire zero;
alu alu1(op, data0, data1, aluRes, zero);

//pcValue (PCaddr adder)
wire [2:0] four;
wire [31:0] PCvalue;
wire [31:0] PCadd4;
assign four = 4'b1000;
adder #(32) pcValue(PCvalue, four, PCadd4);

//branchAdder
wire[31:0] inst15_11_32_sl;
adder #(32) branchAdder(PCadd4, inst15_11_32_sl, add_branch);

//muxes
// RegDest mux
mux21 #(32) regDestMux(inst[20:16], inst[15:11], regDest_en, writeReg);

// aluSrc mux
mux21 #(32) aluSrcMux(readData1, inst15_11_32, aluSrc_en, aluIn2);

// branch_en mux
mux21 #(32) branchMux(pcAdd4, add_branch, branchSel, jumpMuxIn1);

// jump_en mux
mux21 #(32) jumpMux(pcAdd4, jumpMuxIn1, jump_en, pc_input);

// memToReg mux?







initial begin
  clk = 0;
end

always begin
  #10 clk = ~clk;
end