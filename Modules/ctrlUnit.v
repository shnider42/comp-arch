//problem 5

// inputs will be 6 bit opcode, outputs will be 9 control signals

module ctrlUnit(output reg regDest, jump, branch, memRead, memToReg, memWrite, aluSrc, regWrite,
                output reg[1:0] aluOp,
				input [5:0] opCode);

	always@(opCode)	
	begin
		{regDest, aluSrc, memToReg, regWrite, memRead, memWrite, branch, jump, aluOp}=10'b0000000000;
		
		case(opCode)
			6'b000000: //r-format
			begin
				regDest = 1;
				regWrite = 1;
				aluOp = 2'b10;
			end
			
			6'b100011: //lw
			begin
				aluSrc = 1;
				memToReg = 1;
				regWrite = 1;
				memRead = 1;
			end
			
			6'b101011: //sw
			begin
				aluSrc = 1;
				memWrite = 1;
			end
			
			6'b000100: //beq
			begin
				branch = 1;
				aluOp = 2'b01;
			end
			
			6'b001000: //addi
			begin
				regWrite = 1;
				aluSrc = 1;
			end
			
			6'b000010: //jump
			begin
				jump = 1;
			end
		end
	end
	
endmodule
	