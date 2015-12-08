`timescale 1 ns /100 ps

module aluCtrl_tb;

wire [3:0] aluCS;
reg clk;
reg [5:0] functCode;
reg [1:0] ALUop;

aluCtrl testALUCTRL(ALUop, functCode, aluCS, clk);

initial begin
  clk = 0;
end

always begin
  #10 clk = ~clk;
end

initial begin
  #20 ALUop = 0;
  #20 ALUop = 2'b01;
  #20 ALUop = 2'b10;
  functCode = 6'b000000;
  #20 ALUop = 2'b10;
  functCode = 6'b000100;
  #20 ALUop = 2'b10;
  functCode = 6'b001010;
  #20 ALUop = 2'b10;
  functCode = 6'b000010;
  #20 ALUop = 2'b10;
  functCode = 6'b000101;
  $finish;
end
endmodule