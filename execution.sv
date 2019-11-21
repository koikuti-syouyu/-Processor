`include "alu.sv"

module Execution(
	input wire pc_w, mem_w, is_eq, is_ldi, is_ld_st, is_jump,
	input wire [1:0] alith,
	input wire [2:0] rd_addr,
	input wire [5:0] disp6,
	input wire [8:0] imm9,
	input wire [15:0] rd, rs, source1, source2,
	output wire pc_w_out, mem_w_out,
	output wire [2:0] result_w,
	output wire [15:0] result, rd_out
);

	wire comp_rsl;
	wire [15:0] alu_out;

	Alu alu(.*);

	assign comp_rsl = is_jump ? 1 : (is_eq ? (rd == rs) : (rd > rs));
	assign pc_w_out = pc_w * comp_rsl;
	assign result = is_ldi ? imm9 : (is_ld_st ? rs + disp6 : alu_out);
	assign rd_out = rd;
	assign result_w = rd_addr;
	assign mem_w_out = mem_w;

	/*function pc(input in);
	begin
		if(in == 1'bx) begin
			pc = 1'b0;
		end else begin
			pc = in;
		end
	end
	endfunction*/

endmodule
