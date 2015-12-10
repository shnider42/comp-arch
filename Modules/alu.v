//problem 4

module alu( input wire [3:0] op, 
            input wire [31:0] data0, 
            input wire [31:0] data1, 
            output reg[31:0] aluRes, 
            output reg zero);
  
  always @ ( * )
  begin
    case (op)
      4'b0000 : //and
      begin
        aluRes = data0 & data1;
      end
      
      4'b0001 : //or
      begin
        aluRes = data0 | data1;
      end
      
      4'b0010: //add
      begin 
        aluRes = data0 + data1;
      end
      
      4'b0110: //subtract
      begin
        aluRes = data0 - data1;
      end
      
      4'b0111: //slt
      begin
           if (data0 < data1)
               aluRes = 1;
           else
               aluRes = 0;
      end
      
      4'b1100: //nor
      begin 
        aluRes = ~(data0  | data1);
      end
      
      default: 
      begin
        aluRes = data0 + data1;
      end
    endcase
    
    if (aluRes) begin
        zero = 0;
	end else if(~aluRes) begin
        zero = 1;
    end

  end //end always
endmodule