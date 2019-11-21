`include "decode.sv"

module TestDecode();
    reg [15:0] inst, result;
    reg [15:0] pc;
	reg [2:0] result_w;
	reg clk = 0, rst = 1;
    reg is_eq, mem_w, pc_w, is_ldi, is_ld_st, is_jump;
    reg [1:0] alith;
    reg [2:0] rd_addr;
	reg [5:0] disp6_out;
	reg [8:0] imm9_out;
    reg [15:0] rd_out, rs_out, source1, source2;

    Decode decode(.*);
    assign pc = 16'h0000;

    initial begin
	for(int i=0;i<8;i++)begin
		decode.regfile.reg_file[i] = i * 10;
	end
	//$display("op: %b", decode.op);
	//$display("is_eq: %b, alith: %b, mem_w: %b, pc_w: %b", decode.is_eq, decode.alith, decode.mem_w, decode.pc_w);
	//$display("rd_addr: %d, RD: %d, RS: %d", decode.rd_addr, decode.rd_out, decode.rs_out);
	//$display("source1: %d, source2: %d", decode.source1, decode.source2);
	//#1;

	// ADD $1 $2 3 
	inst = 16'b0001_001_010_000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b0001 && decode.is_eq == 1'b0 && decode.alith == 2'b00 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b001 && decode.rd_out == 4'd10 && decode.rs_out == 5'd20 && decode.source1 == 4'd10 && decode.source2 == 5'd20 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_1000_0011) begin
		$display("ADD_OK");
	end else begin
		$error("ADD_NG");
	end
	//SUB $1 $2 3
	inst = 16'b0010_001_010_000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b0010 && decode.is_eq == 1'b0 && decode.alith == 2'b01 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b001 && decode.rd_out == 4'd10 && decode.rs_out == 5'd20 && decode.source1 == 4'd10 && decode.source2 == 5'd20 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_1000_0011) begin
		$display("SUB_OK");
	end else begin
		$error("SUB_NG");
	end
	//AND $1 $2 3
	inst = 16'b0011_001_010_000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b0011 && decode.is_eq == 1'b0 && decode.alith == 2'b10 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b001 && decode.rd_out == 4'd10 && decode.rs_out == 5'd20 && decode.source1 == 4'd10 && decode.source2 == 5'd20 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_1000_0011) begin
		$display("AND_OK");
	end else begin
		$error("AND_NG");
	end
	//OR $1 $2 3
	inst = 16'b0100_001_010_000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b0100 && decode.is_eq == 1'b0 && decode.alith == 2'b11 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b001 && decode.rd_out == 4'd10 && decode.rs_out == 5'd20 && decode.source1 == 4'd10 && decode.source2 == 5'd20 &
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_1000_0011) begin
		$display("OR_OK");
	end else begin
		$error("OR_NG");
	end
	//ADDI $1 3
	inst = 16'b0101_001_000000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b0101 && decode.is_eq == 1'b0 && decode.alith == 2'b00 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b001 && decode.rd_out == 4'd10 && decode.rs_out == 1'd0 && decode.source1 == 4'd10 && decode.source2 == 2'd3 && 
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_0000_0011) begin
		$display("ADDI_OK");
	end else begin
		$error("ADDI_NG");
	end
	//SUBI $1 3
	inst = 16'b0110_001_000000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b0110 && decode.is_eq == 1'b0 && decode.alith == 2'b01 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b001 && decode.rd_out == 4'd10 && decode.rs_out == 1'd0 && decode.source1 == 4'd10 && decode.source2 == 2'd3 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_0000_0011) begin
		$display("SUBI_OK");
	end else begin
		$error("SUBI_NG");
	end
	//INCR $1 (3)
	inst = 16'b0111_001_000000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b0111 && decode.is_eq == 1'b0 && decode.alith == 2'b00 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b001 && decode.rd_out == 4'd10 && decode.rs_out == 1'd0 && decode.source1 == 4'd10 && decode.source2 == 1'd1 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_0000_0011) begin
		$display("INCR_OK");
	end else begin
		$error("INCR_NG");
	end
	//DECR $1 (3)
	inst = 16'b1000_001_000000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b1000 && decode.is_eq == 1'b0 && decode.alith == 2'b01 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b001 && decode.rd_out == 4'd10 && decode.rs_out == 1'd0 && decode.source1 == 4'd10 && decode.source2 == 1'd1 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_0000_0011) begin
		$display("DECR_OK");
	end else begin
		$error("DECR_NG");
	end
	//LDI $1 3
	inst = 16'b1001_001_000000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b1001 && decode.is_eq == 1'b0 && decode.alith == 2'b00 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b1 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b001 && decode.rd_out == 4'd10 && decode.rs_out == 1'd0 && decode.source1 == 4'd10 && decode.source2 == 2'd3 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_0000_0011) begin
		$display("LDI_OK");
	end else begin
		$error("LDI_NG");
	end
	//LD $1 $2 3
	inst = 16'b1010_001_010_000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b1010 && decode.is_eq == 1'b0 && decode.alith == 2'b00 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b1 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b001 && decode.rd_out == 4'd10 && decode.rs_out == 5'd20 && decode.source1 == 4'd10 && decode.source2 == 2'd3 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_1000_0011) begin
		$display("LD_OK");
	end else begin
		$error("LD_NG");
	end
	//ST $1 $2 3
	inst = 16'b1011_001_010_000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b1011 && decode.is_eq == 1'b0 && decode.alith == 2'b00 && decode.mem_w == 1'b1 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b1 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b000 && decode.rd_out == 4'd10 && decode.rs_out == 5'd20 && decode.source1 == 4'd10 && decode.source2 == 2'd3 &
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_1000_0011) begin
		$display("ST_OK");
	end else begin
		$error("ST_NG");
	end
	//BEQ $1 $2 3
	inst = 16'b1100_001_010_000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b1100 && decode.is_eq == 1'b1 && decode.alith == 2'b00 && decode.mem_w == 1'b0 && decode.pc_w == 1'b1 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b000 && decode.rd_out == 4'd10 && decode.rs_out == 5'd20 && decode.source1 == 1'd0 && decode.source2 == 2'd3 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_1000_0011) begin
		$display("BEQ_OK");
	end else begin
		$error("BEQ_NG");
	end
	//BGT $1 $2 3
	inst = 16'b1101_001_010_000011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b1101 && decode.is_eq == 1'b0 && decode.alith == 2'b00 && decode.mem_w == 1'b0 && decode.pc_w == 1'b1 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b000 && decode.rd_out == 4'd10 && decode.rs_out == 5'd20 && decode.source1 == 1'd0 && decode.source2 == 2'd3 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_1000_0011) begin
		$display("BGT_OK");
	end else begin
		$error("BGT_NG");
	end
	//JUMP 3
	inst = 16'b1110_0000_0000_0011;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b1110 && decode.is_eq == 1'b0 && decode.alith == 2'b00 && decode.mem_w == 1'b0 && decode.pc_w == 1'b1 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b1 &&
	    decode.rd_addr == 3'b000 && decode.rd_out == 1'd0 && decode.rs_out == 1'd0 && decode.source1 == 1'd0 && decode.source2 == 2'd3 &&
		decode.disp6_out == 6'b00_0011 && decode.imm9_out == 9'b0_0000_0011) begin
		$display("JUMP_OK");
	end else begin
		$error("JUMP_NG");
	end
	//NOP 
	inst = 16'b0000_0000_0000_0000;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b0000 && decode.is_eq == 1'b0 && decode.alith == 2'b00 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b000 && decode.rd_out == 1'd0 && decode.rs_out == 1'd0 && decode.source1 == 1'd0 && decode.source2 === 1'd0 &&
		decode.disp6_out == 6'b00_0000 && decode.imm9_out == 9'b0_0000_0000) begin
		$display("NOP_OK");
	end else begin
		$error("NOP_NG");
	end
	//HALT
	inst = 16'b1111_0000_0000_0000;
	clk = 1;
	#1;
	clk = 0;
	#1;
	if (decode.op == 4'b1111 && decode.is_eq == 1'b0 && decode.alith == 2'b00 && decode.mem_w == 1'b0 && decode.pc_w == 1'b0 && decode.is_ldi == 1'b0 && decode.is_ld_st == 1'b0 && is_jump == 1'b0 &&
	    decode.rd_addr == 3'b000 && decode.rd_out == 1'd0 && decode.rs_out == 1'd0 && decode.source1 == 1'd0 && decode.source2 === 1'd0 &&
		decode.disp6_out == 6'b00_0000 && decode.imm9_out == 9'b0_0000_0000) begin
		$display("HALT_OK");
	end else begin
		$error("HALT_NG");
	end
	end
endmodule
