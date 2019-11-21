module  RegFile(
    input  wire [15:0] result, mem_in,
    input wire [2:0] result_w, rd_addr, rs_addr,
    input wire clk, rst, is_ld,
    output reg [15:0] rd_out, rs_out
);

    reg [15:0] reg_file[7:0];

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            for(int i=0;i<8;i++) begin
                reg_file[i] = 16'b0;
                //$display("do");
            end
        end else begin
            reg_file[result_w] <= is_ld ? mem_in : result;
        end
    end

    assign rd_out = reg_file[rd_addr];
    assign rs_out = reg_file[rs_addr];
    
endmodule