//PC module

module PC(PC_addr_in, PCvalue, rst, clk);
	input wire [31:0] PC_addr_in;
	input rst, clk;
	output reg [31:0] PCvalue;
	
	//wire PC_addr_in;
	wire rst;
	wire clk;
	
	always @(posedge clk) begin
		if (rst == 1) begin
			PCvalue <= 32'h00003000;
		end else begin
			PCvalue <= PC_addr_in;
		end
	end
	
	
endmodule