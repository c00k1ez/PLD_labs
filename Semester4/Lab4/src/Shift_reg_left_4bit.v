module Shift_reg_left_4bit(
input clk,
input en,
input ISL,
input rst,
output reg OSL,
output reg [3:0] shift_rg);

	initial shift_rg = 4'b0;
	always @(posedge clk) begin
		if (rst) begin
			shift_rg = 4'b0;
			OSL = 1'b0;
		end else begin
			if (en) begin
				shift_rg = {shift_rg[2:0], ISL};
				OSL = shift_rg[3];
			end else begin
				OSL = 1'b0;
				shift_rg = shift_rg;
			end
		end
	end
endmodule