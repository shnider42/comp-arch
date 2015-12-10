//Branch and ALU_zero and

module andMod(ALU_zero, branch, branch_sel);
	input ALU_zero, branch;
	output branch_sel;
	
	wire ALU_zero, branch;
	wire branch_sel;
	
	assign branch_sel = ALU_zero & branch;
	
endmodule