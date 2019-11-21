`include "fetch.sv"
`include "decode.sv"
`include "execution.sv"
`include "wb.sv"

module Cpu(
    input wire clk, rst
);

    wire [15:0] result, inst_if_id, pc_if_id, source1_id_ex, source2_id_ex, mem, rd_id_ex, rs_id_ex, rd_ex_wb;
    wire [8:0] imm9_id_ex;
    wire [5:0] disp6_id_ex;
    wire [2:0] rd_addr_id_ex, result_w_ex_id;
    wire [1:0] alith_id_ex;
    wire pc_w_ex_if, pc_w_id_ex, is_eq_id_ex, is_ldi_id_ex, is_ld_st_id_ex, is_jump_id_ex, mem_w_ex_wb, mem_w_id_ex;

    Fetch fetch(.result(result), .clk(clk), .rst(rst), .pc_w(pc_w_ex_if), .inst(inst_if_id), .pc(pc_if_id));

    Decode decode(.inst(inst_if_id), .result(result), .mem_in(mem), .pc(pc_if_id), .result_w(result_w_ex_id), .clk(clk), .rst(rst), .is_eq(is_eq_id_ex), .mem_w(mem_w_id_ex), .pc_w(pc_w_id_ex),
                    .is_ldi(is_ldi_id_ex), .is_ld_st(is_ld_st_id_ex), .is_jump(is_jump_id_ex), .alith(alith_id_ex),
                    .rd_addr(rd_addr_id_ex), .disp6_out(disp6_id_ex), .imm9_out(imm9_id_ex), .rd_out(rd_id_ex), .rs_out(rs_id_ex), .source1(source1_id_ex), .source2(source2_id_ex));

    Execution execution(.pc_w(pc_w_id_ex), .mem_w(mem_w_id_ex), .is_eq(is_eq_id_ex), .is_ldi(is_ldi_id_ex), .is_ld_st(is_ld_st_id_ex), .is_jump(is_jump_id_ex),
                    .alith(alith_id_ex), .rd_addr(rd_addr_id_ex), .disp6(disp6_id_ex), .imm9(imm9_id_ex), .rd(rd_id_ex), .rs(rs_id_ex), .source1(source1_id_ex),
                    .source2(source2_id_ex), .pc_w_out(pc_w_ex_if), .mem_w_out(mem_w_ex_wb), .result_w(result_w_ex_id), .result(result), .rd_out(rd_ex_wb));

    Wb wb(.mem_w(mem_w_ex_wb), .result(result), .rd(rd_ex_wb), .mem_out(mem));

endmodule