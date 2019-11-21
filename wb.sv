module Wb(
    input wire mem_w,
    input wire [15:0] result, rd,
    output wire [15:0] mem_out
);

    reg [15:0] data_mem[255:0];

    wire [15:0] data;

    assign mem_out = data_mem[result];

    assign data = mem_w ? result : 1'bx;
    always @(data) begin
        if(data != 1'bx) begin
            data_mem[result] = rd;
            $display("do");
        end
    end

endmodule