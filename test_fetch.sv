`include "fetch.sv"

module TestFetch();
	wire [15:0] result = 16'b0000_0000_0000_0000;
	wire [15:0] pc;
	reg clk = 0;
	reg rst = 1;
	reg pc_w = 0;

	// always #100 clk = ~clk;

	reg [15:0] inst;

	Fetch fetch(.*); 

	initial begin
		for (int i=0; i<100; i++) begin
			fetch.inst_mem[i] = i;
		end
		#1;
		for(int i=0;i<100;i++) begin
			$display("pc: %d", fetch.pc);
			$display("clk: %d", fetch.clk);
			clk = 1;
			#1;
			clk = 0;
			#1;
		end		
	end
endmodule
