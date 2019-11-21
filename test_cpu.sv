`timescale 1ps/1ps
`include "cpu.sv"

module TestCpu();
    reg clk = 0, rst = 1;

    Cpu cpu(.*);

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0, TestCpu);
        for(int i=0;i<255;i++) begin
            cpu.wb.data_mem[i] = 16'b0;
            cpu.fetch.inst_mem[i] = 16'b0;
        end
        cpu.fetch.inst_mem[0] = 16'b1001_001_000000001;
        cpu.fetch.inst_mem[1] = 16'b1110_010_000000100;
        cpu.fetch.inst_mem[2] = 16'b1001_011_000000011;
        cpu.fetch.inst_mem[3] = 16'b1001_100_000000100;
        cpu.fetch.inst_mem[4] = 16'b1001_101_000000101;
        cpu.fetch.inst_mem[5] = 16'b1001_110_000000110;
        cpu.fetch.inst_mem[6] = 16'b1001_111_000000111;
        //cpu.fetch.inst_mem[7] = 16'b1010_001_010_000001;
        rst = 0;
        #1;
        rst = 1;
        #1;
        for(int j=0;j<8;j++) begin
            cpu.decode.regfile.reg_file[j] = j * 10;
        end
        #10;
        clk = 1;
        #10;
        clk = 0;
        #10;
        clk = 1;
        #10;
        clk = 0;
        #10;
        clk = 1;
        #10;
        clk = 0;
        #10;
        clk = 1;
        #10;
        clk = 0;
        #10;
        clk = 1;
        #10;
        clk = 0;
        #10;
        clk = 1;
        #10;
        clk = 0;
        #10;
        clk = 1;
        #10;
        clk = 0;
        #10;
        clk = 1;
        #10;
        clk = 0;
        #10;
        for(int j=0;j<8;j++) begin
            $display("reg%d : %d", j, cpu.decode.regfile.reg_file[j]);
        end
        //$display("reg1 : %d", cpu.decode.regfile.reg_file[1]);
        //$display("wb mem_out : %d", cpu.fetch.pc_w);
    end

endmodule