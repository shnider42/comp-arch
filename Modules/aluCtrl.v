//problem 6

module aluCtrl(	input[1:0] aluOp, 
					input[5:0] opCode, 
					output reg[3:0] aluOpSig 
				);
				
// These codes and outputs are taken from figure 4.13, P&H.
always @ (aluOp or opCode) 
begin
    if (aluOp == 2'b00)     
		aluOpSig = 4'b0010;      // lw, sw, addi -> add
    else if (aluOp == 2'b01)    
		aluOpSig = 4'b0110;      // branch equal -> sub
    else if (aluOp == 2'b10 && opCode[3:0] == 4'b0000)
		aluOpSig = 4'b0010;      // Rtype -> add
    else if (aluOp[1] == 1 && opCode[3:0] == 4'b0010)
		aluOpSig = 4'b0110;       // Rtype -> sub
    else if (aluOp == 2'b10 && opCode[3:0] == 4'b0100)
		aluOpSig = 4'b0000;      // Rtype -> AND
    else if (aluOp == 2'b10 && opCode[3:0] == 4'b0101)
		aluOpSig = 4'b0001;      // Rtype -> OR
    else if (aluOp[1] == 1 && opCode[3:0] == 4'b1010)
		aluOpSig = 4'b0111;      // Rtype -> set on less than
end

endmodule

/*module aluCtrl( input wire [1:0] aluOp ,
				input wire [5:0] opCode ,
                output reg [3:0] aluOpSig);
	
	wire code;
	assign code = {aluOp, opCode};
	
	always@(aluOp or opCode)
		begin
		case(code)
			8'b00xxxxxx: //
			begin
				assign aluOpSig = 4'b0010;
			end
			
			8'bx1xxxxxx: //
			begin
				assign aluOpSig = 4'b0110;
			end
			
			8'b1xxx0000: //
			begin
				assign aluOpSig = 4'b0010;
			end
			
			8'b1xxx0010: //
			begin
				assign aluOpSig = 4'b0110;
			end
			
			8'b1xxx0100: //
			begin
				assign aluOpSig = 4'b0000;
			end
			
			8'b1xxx0101: //
			begin
				assign aluOpSig = 4'b0001;
			end
			
			8'b1xxx1010: //
			begin
				assign aluOpSig = 4'b0111;
			end
		endcase
		
	end
endmodule
*/