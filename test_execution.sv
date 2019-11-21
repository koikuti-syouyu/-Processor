`include "execution.sv"

module TestExecution();
    reg pc_w, mem_w, is_eq, is_ldi, is_ld_st, is_jump;
    reg [1:0] alith;
    reg [2:0] rd_addr;
    reg [5:0] disp6;
    reg [8:0] imm9;
    reg [15:0] rd, rs, source1, source2;
	wire pc_w_out, mem_w_out;
	wire [2:0] rd_addr_out;
	wire [15:0] result;
    

    Execution execution(.*);

    initial begin
        //$display("pc_w_out : %d, mem_w_out : %d, rd_addr_out : %d, result : %d", execution.pc_w_out, execution.mem_w_out, rd_addr_out, execution.result);
        //ADD $1(10) $2(20) 3
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b00;
        rd_addr = 3'b001;
        disp6 = 6'b00_0011; imm9 = 9'b0_1000_0011;
        rd = 16'd10; rs = 16'd20; source1 = 16'd10; source2 = 16'd20;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b001 && result == 16'd30) begin
            $display("ADD_OK");
        end else begin
            $error("ADD_NG");
        end
        //SUB $2(20) $1(10) 3
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b01;
        rd_addr = 3'b010;
        disp6 = 6'b00_0011; imm9 = 9'b0_0100_0011;
        rd = 16'd20; rs = 16'd10; source1 = 16'd20; source2 = 16'd10;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b010 && result == 16'd10) begin
            $display("SUB_OK");
        end else begin
            $error("SUB_NG");
        end
        //AND $1(b1100) $2(b1000) 3
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b10;
        rd_addr = 3'b001;
        disp6 = 6'b00_0011; imm9 = 9'b0_1000_0011;
        rd = 4'b1100; rs = 4'b1000; source1 = 16'd12; source2 = 16'd8;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b001 && result == 16'd8) begin
            $display("AND_OK");
        end else begin
            $error("AND_NG");
        end
        //OR $1(b1000) $2(b0001)
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b11;
        rd_addr = 3'b001;
        disp6 = 6'b00_0011; imm9 = 9'b0_1000_0011;
        rd = 4'b1000; rs = 4'b0001; source1 = 16'd8; source2 = 16'd1;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b001 && result == 16'd9) begin
            $display("OR_OK");
        end else begin
            $error("OR_NG");
        end
        //ADDI $1(10) 3
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b00;
        rd_addr = 3'b001;
        disp6 = 6'b00_0011; imm9 = 9'b0_0000_0011;
        rd = 16'd10; rs = 16'd0; source1 = 16'd10; source2 = 16'd3;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b001 && result == 16'd13) begin
            $display("ADDI_OK");
        end else begin
            $error("ADDI_NG");
        end
        //SUBI $1(10) 3
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b01;
        rd_addr = 3'b001;
        disp6 = 6'b00_0011; imm9 = 9'b0_0000_0011;
        rd = 16'd10; rs = 16'd0; source1 = 16'd10; source2 = 16'd3;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b001 && result == 16'd7) begin
            $display("SUBI_OK");
        end else begin
            $error("SUBI_NG");
        end
        //INCR $1(10) (3)
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b00;
        rd_addr = 3'b001;
        disp6 = 6'b00_0011; imm9 = 9'b0_0000_0011;
        rd = 16'd10; rs = 16'd0; source1 = 16'd10; source2 = 16'd1;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b001 && result == 16'd11) begin
            $display("INCR_OK");
        end else begin
            $error("INCR_NG");
        end
        //DECR $1(10) (3)
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b01;
        rd_addr = 3'b001;
        disp6 = 6'b00_0011; imm9 = 9'b0_0000_0011;
        rd = 16'd10; rs = 16'd0; source1 = 16'd10; source2 = 16'd1;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b001 && result == 16'd9) begin
            $display("DECR_OK");
        end else begin
            $error("DECR_NG");
        end
        //LDI $1(10) 3
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b1; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b00;
        rd_addr = 3'b001;
        disp6 = 6'b00_0011; imm9 = 9'b0_0000_0011;
        rd = 16'd10; rs = 16'd0; source1 = 16'd10; source2 = 16'd3;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b001 && result == 16'd3) begin
            $display("LDI_OK");
        end else begin
            $error("LDI_NG");
        end
        //LD $1(10) $2(20) 3
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b1; is_jump = 1'b0;
        alith = 2'b00;
        rd_addr = 3'b001;
        disp6 = 6'b00_0011; imm9 = 9'b0_1000_0011;
        rd = 16'd10; rs = 16'd20; source1 = 16'd10; source2 = 16'd3;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b001 && result == 16'd23) begin
            $display("LD_OK");
        end else begin
            $error("LD_NG");
        end
        //ST $1(10) $2(20) 3
        pc_w = 1'b0; mem_w = 1'b1; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b1; is_jump = 1'b0;
        alith = 2'b00;
        rd_addr = 3'b000;
        disp6 = 6'b00_0011; imm9 = 9'b0_1000_0011;
        rd = 16'd10; rs = 16'd20; source1 = 16'd10; source2 = 16'd3;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b1 && rd_addr_out == 3'b000 && result == 16'd23) begin
            $display("ST_OK");
        end else begin
            $error("ST_NG");
        end
        //BEQ $1(10) $2(10) 3
        pc_w = 1'b1; mem_w = 1'b0; is_eq = 1'b1; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b00;
        rd_addr = 3'b000;
        disp6 = 6'b00_0011; imm9 = 9'b0_1000_0011;
        rd = 16'd10; rs = 16'd10; source1 = 16'd0; source2 = 16'd3;
        #1;
        if(execution.pc_w_out == 1'b1 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b000 && result == 16'd3) begin
            $display("BEQ_OK");
        end else begin
            $error("BEQ_NG");
        end
        //BGT $1(20) $2(10) 3
        pc_w = 1'b1; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b00;
        rd_addr = 3'b000;
        disp6 = 6'b00_0011; imm9 = 9'b0_1000_0011;
        rd = 16'd20; rs = 16'd10; source1 = 16'd0; source2 = 16'd3;
        #1;
        if(execution.pc_w_out == 1'b1 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b000 && result == 16'd3) begin
            $display("BGT_OK");
        end else begin
            $error("BGT_NG");
        end
        //JUMP 3
        pc_w = 1'b1; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b1;
        alith = 2'b00;
        rd_addr = 3'b000;
        disp6 = 6'b00_0011; imm9 = 9'b0_0000_0011;
        rd = 16'd0; rs = 16'd0; source1 = 16'd0; source2 = 16'd3;
        #1;
        if(execution.pc_w_out == 1'b1 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b000 && result == 16'd3) begin
            $display("JUMP_OK");
        end else begin
            $error("JUMP_NG");
        end
        //NOP
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b00;
        rd_addr = 3'b000;
        disp6 = 6'b00_0000; imm9 = 9'b0_0000_0000;
        rd = 16'd0; rs = 16'd0; source1 = 16'd0; source2 = 16'dx;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b000 && result === 16'dx) begin
            $display("NOP_OK");
        end else begin
            $error("NOP_NG");
        end
        //HALT
        pc_w = 1'b0; mem_w = 1'b0; is_eq = 1'b0; is_ldi = 1'b0; is_ld_st = 1'b0; is_jump = 1'b0;
        alith = 2'b00;
        rd_addr = 3'b000;
        disp6 = 6'b00_0000; imm9 = 9'b0_0000_0000;
        rd = 16'd0; rs = 16'd0; source1 = 16'd0; source2 = 16'dx;
        #1;
        if(execution.pc_w_out == 1'b0 && execution.mem_w_out == 1'b0 && rd_addr_out == 3'b000 && result === 16'dx) begin
            $display("HALT_OK");
        end else begin
            $error("HALT_NG");
        end
    end
endmodule