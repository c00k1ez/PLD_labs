module Shift_reg_dir_4bit(
input clk,
input en,
input ISb,
input rst,
input dir,
output reg OSb,
output reg [3:0] shift_rg);

	initial shift_rg = 4'b0;
	always @(posedge clk) begin
		if (rst) begin
			shift_rg = 4'b0;
			OSb = 1'b0;
		end else begin
			if (en) begin
				if (dir) begin
					shift_rg = {ISb, shift_rg[3:1]};
					OSb = shift_rg[0];
				end else begin 
					shift_rg = {shift_rg[2:0], ISb};
					OSb = shift_rg[3];
				end
			end else begin
				OSb = 1'b0;
				shift_rg = shift_rg;
			end
		end
	end
endmodule