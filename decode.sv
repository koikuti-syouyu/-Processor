`include "regfile.sv"

module Decode(
    input wire [15:0] inst, result, mem_in,
    input wire [15:0] pc,
    input wire [2:0] result_w,
    input wire  clk, rst,
    output reg is_eq, mem_w, is_ldi, is_ld_st, is_jump,
    output reg pc_w = 1'b0,
    output reg [1:0] alith,
    output reg [2:0] rd_addr,
    output reg [5:0] disp6_out,
    output reg [8:0] imm9_out,
    output reg [15:0] rd_out, rs_out, source1, source2
);

    wire [3:0] op = inst[15:12];
    wire [2:0] rd = inst[11:9];
    wire [2:0] rs = inst[8:6];
    wire [5:0] disp6 = inst[5:0];
    wire [8:0] imm9 = inst[8:0];
    reg pc_or_rd = 1'b0, disp_or_imm = 1'b0, rs_or_1 = 1'b0, select_s1 = 1'b0, select_s2 = 1'b0, rd_addr_w = 1'b0;
    wire [15:0] rd_file_out, rs_file_out;

    always @(inst, result) begin
	    case(op)
	    	4'b0001: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'b0; rs_or_1 <= 1'b0; disp_or_imm <= 1'b0; select_s1 <= 1'b0; select_s2 <= 1'b0; rd_addr_w <= 1'b1; end		//ADD
	    	4'b0010: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b01; pc_or_rd <= 1'b0; rs_or_1 <= 1'b0; disp_or_imm <= 1'b0; select_s1 <= 1'b0; select_s2 <= 1'b0; rd_addr_w <= 1'b1; end		//SUB
	    	4'b0011: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b10; pc_or_rd <= 1'b0; rs_or_1 <= 1'b0; disp_or_imm <= 1'b0; select_s1 <= 1'b0; select_s2 <= 1'b0; rd_addr_w <= 1'b1; end		//AND
	    	4'b0100: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b11; pc_or_rd <= 1'b0; rs_or_1 <= 1'b0; disp_or_imm <= 1'b0; select_s1 <= 1'b0; select_s2 <= 1'b0; rd_addr_w <= 1'b1; end		//OR
	    	4'b0101: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'b0; rs_or_1 <= 1'bx; disp_or_imm <= 1'b1; select_s1 <= 1'b0; select_s2 <= 1'b1; rd_addr_w <= 1'b1; end		//ADDI
	    	4'b0110: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b01; pc_or_rd <= 1'b0; rs_or_1 <= 1'bx; disp_or_imm <= 1'b1; select_s1 <= 1'b0; select_s2 <= 1'b1; rd_addr_w <= 1'b1; end		//SUBI
	    	4'b0111: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'b0; rs_or_1 <= 1'b1; disp_or_imm <= 1'b0; select_s1 <= 1'b0; select_s2 <= 1'b0; rd_addr_w <= 1'b1; end		//INCR
	    	4'b1000: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b01; pc_or_rd <= 1'b0; rs_or_1 <= 1'b1; disp_or_imm <= 1'b0; select_s1 <= 1'b0; select_s2 <= 1'b0; rd_addr_w <= 1'b1; end		//DECR
	    	4'b1001: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b1; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'b0; rs_or_1 <= 1'bx; disp_or_imm <= 1'b1; select_s1 <= 1'b0; select_s2 <= 1'b1; rd_addr_w <= 1'b1; end		//LDI
	    	4'b1010: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b1; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'b0; rs_or_1 <= 1'bx; disp_or_imm <= 1'b0; select_s1 <= 1'b0; select_s2 <= 1'b1; rd_addr_w <= 1'b1; end		//LD
	    	4'b1011: begin is_eq <= 1'b0; mem_w <= 1'b1; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b1; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'b0; rs_or_1 <= 1'bx; disp_or_imm <= 1'b0; select_s1 <= 1'b0; select_s2 <= 1'b1; rd_addr_w <= 1'b0; end		//ST
	    	4'b1100: begin is_eq <= 1'b1; mem_w <= 1'b0; pc_w <= 1'b1; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'b1; rs_or_1 <= 1'bx; disp_or_imm <= 1'b0; select_s1 <= 1'b0; select_s2 <= 1'b1; rd_addr_w <= 1'b0; end		//BEQ
	    	4'b1101: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b1; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'b1; rs_or_1 <= 1'bx; disp_or_imm <= 1'b0; select_s1 <= 1'b0; select_s2 <= 1'b1; rd_addr_w <= 1'b0; end		//BGT
	    	4'b1110: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b1; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b1; alith <= 2'b00; pc_or_rd <= 1'b1; rs_or_1 <= 1'bx; disp_or_imm <= 1'b1; select_s1 <= 1'b0; select_s2 <= 1'b1; rd_addr_w <= 1'b0; end		//JUMP
	    	4'b0000: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'bx; rs_or_1 <= 1'b0; disp_or_imm <= 1'b0; select_s1 <= 1'b1; select_s2 <= 1'b0; rd_addr_w <= 1'b0; end		//NOP
	    	4'b1111: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'bx; rs_or_1 <= 1'b0; disp_or_imm <= 1'b0; select_s1 <= 1'b1; select_s2 <= 1'b0; rd_addr_w <= 1'b0; end		//HALT
	    	default: begin is_eq <= 1'b0; mem_w <= 1'b0; pc_w <= 1'b0; is_ldi <= 1'b0; is_ld_st <= 1'b0; is_jump <= 1'b0; alith <= 2'b00; pc_or_rd <= 1'bx; rs_or_1 <= 1'bx; disp_or_imm <= 1'b0; select_s1 <= 1'b1; select_s2 <= 1'b0; rd_addr_w <= 1'b0; end
	    endcase

    end

    RegFile regfile(.result(result), .mem_in(mem_in), .result_w(result_w), .rd_addr(rd), .rs_addr(rs), .clk(clk), .rst(rst), .is_ld(is_ld_st), .rd_out(rd_file_out), .rs_out(rs_file_out));
    
    assign rd_addr = rd_addr_w ? rd : 3'b000;
    assign rd_out = rd_file_out;
    assign rs_out = rs_file_out;
    assign disp6_out = disp6;
    assign imm9_out = imm9;
    assign source1 = select_s1 ? 16'h0000 : (pc_or_rd ? pc : rd_file_out);
    assign source2 = select_s2 ? (disp_or_imm ? imm9 : disp6) : (rs_or_1 ? 16'h0001 : rs_file_out);   
    
		
endmodule
