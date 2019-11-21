`include "wb.sv"

module TestWb();
    reg mem_w;
    reg [15:0] result, rd;
    wire [15:0] mem_out;

    Wb wb(.*);

    initial begin
        for(int i=0;i<100;i++) begin
            wb.data_mem[i] = i;
        end
        #1;
        //LD $1(10) $2(20) 3
        mem_w = 1'b0;
        result = 16'd23;
        rd = 16'd10;
        #1;
        if(wb.mem_out == 16'd23 && wb.data_mem[wb.result] == 16'd23) begin
            $display("LD_OK");
        end else begin
            $error("LD_NG");
        end
        $display("mem_out : %d, data_mem[%d] : %d", wb.mem_out, wb.result, wb.data_mem[wb.result]);
        //ST $1(10) $2(20) 3
        mem_w = 1'b1;
        result = 16'd23;
        rd = 16'd10;
        #1;
        if(wb.mem_out == 16'd10 && wb.data_mem[wb.result] == 16'd10) begin
            $display("ST_OK");
        end else begin
            $error("ST_NG");
        end
        $display("mem_out : %d, data_mem[%d] : %d", wb.mem_out, wb.result, wb.data_mem[wb.result]);
        #1;
        //ADD $1(10) $2(20) 3
        mem_w = 1'b0;
        result = 16'd30;
        rd = 16'd10;
        #1;
        if(wb.mem_out == 16'd30 && wb.data_mem[wb.result] == 16'd30) begin
            $display("ADD_OK");
        end else begin
            $error("ADD_NG");
        end
        $display("mem_out : %d, data_mem[%d] : %d", wb.mem_out, wb.result, wb.data_mem[wb.result]);
    end

endmodule