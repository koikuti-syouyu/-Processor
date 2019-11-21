module Alu(
	input wire [1:0] alith,
	input wire [15:0] source1, source2,
	output reg [15:0] alu_out = 16'b0
);

	always @(source1, source2, alith) begin
		if(alith == 2'b00) begin
			alu_out = source1 + source2;
		end else if(alith == 2'b01) begin
			alu_out = source1 - source2;
		end else if(alith == 2'b10) begin
			alu_out = source1 & source2;
		end else if(alith == 2'b11) begin
			alu_out = source1 | source2;
		end
		//$display("ex");
	end

endmodule