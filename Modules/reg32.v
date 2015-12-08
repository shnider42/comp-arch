//problem 2
//32 bit register

module reg32(in, clk, reset, l_en, out);
	input in, clk, reset, l_en;
	output out;
	wire [31:0] in;
	wire clk, reset, l_en;
	reg [31:0] out;

	always @ (posedge clk, reset) //this makes it asynchronous
		begin
			if (reset)
				out = 0;
			else if(l_en) //when reset is not 1, clk=posedge, enable=1
				out = in;
		end

endmodule