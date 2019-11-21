module Fetch(
    input wire [15:0] result, 
    input wire clk, rst, pc_w,
    output wire [15:0] inst,
    output reg [15:0] pc = 16'b0000_0000_0000_0000
);
    reg [15:0] inst_mem[255:0];

    assign inst = inst_mem[pc];
    
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            pc = 16'b0;
            //$display("tick");
        end else begin
	        pc <= pc_w ? result : pc +  16'b0000_0000_0000_0001;
            //$display("result : %d, pc : %d", result, pc);
	        //$display("tick");
        end
    end
endmodule
