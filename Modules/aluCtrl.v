//problem 6

module aluCtrl( input wire [1:0] aluOp ,
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