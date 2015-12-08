//problem 6

module aluCtrl( input aluOp [1:0],
				input opCode [5:0],
                output reg aluOpSig [3:0]);
	
	always@(aluOp or opCode)
	begin
	
	assign code = {aluOp, opCode};
	
		begin
			case(code)
			begin
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
				
			end
			
		end

endmodule