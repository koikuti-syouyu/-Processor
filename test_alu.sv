`include "alu.sv"

module TestAlu();
	reg [2:0] alith;
	reg [15:0] source1, source2;
	reg [15:0] alu_out;

	Alu alu(.*);

	initial begin
		//alith : 00
		alith = 2'b00;
		source1 = 15'd1;
		source2 = 15'd2;
		#1;
		if(alu.alu_out == 2'd3) begin
			$display("ADD_OK");
		end else begin
			$error("ADD_NG");
		end
		//alith : 01
		alith = 2'b01;
		source1 = 15'd5;
		source2 = 15'd2;
		#1;
		if(alu.alu_out == 2'd3) begin
			$display("SUB_OK");
		end else begin
			$error("SUB_NG");
		end
		//alith : 10
		alith = 2'b10;
		source1 = 4'b1100;
		source2 = 4'b1000;
		#1;
		if(alu.alu_out == 4'd8) begin
			$display("AND_OK");
		end else begin
			$error("AND_NG");
		end
		//alith : 11
		alith = 2'b11;
		source1 = 4'b1000;
		source2 = 4'b0001;
		#1;
		if(alu.alu_out == 4'd9) begin
			$display("OR_OK");
		end else begin
			$error("OR_NG");
		end
	end
endmodule
