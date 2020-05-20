module D_trigger_register(
input [7:0] d,
input clk,
input rst,
input en,
output reg [7:0] q);

	initial q = 7'b0;
	always @(posedge clk or posedge rst) begin
		if (rst) q = 7'b0;
		else begin
			if (en) q = d;
			else q = q;
		end
	end
	
endmodule