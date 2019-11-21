`include "regfile.sv"

module TestRegFile ();
    reg [15:0] result;
    reg [2:0] result_w, rd_addr, rs_addr;
    reg clk = 0, rst = 1;
    reg [15:0] rd_out, rs_out;

    RegFile regfile(.*);

    initial begin
        for(int i=0;i<7;i++) begin
            regfile.reg_file[i] = i;
        end
        #1;

        result = 16'd3;
        result_w = 3'b001; rd_addr = 3'b001; rs_addr = 3'b011;
        clk = 1;
        #1;
        clk = 0;
        #1;
        if(regfile.rd_out == 16'd3 && regfile.rs_out == 16'd3 && regfile.reg_file[regfile.result_w] == 16'd3) begin
            $display("OK");
        end else begin
            $error("NG");
        end

    end

endmodule