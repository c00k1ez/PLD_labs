module Counter_8bit(
input clk,
input en,
input rst,
output reg [7:0] counter);

	initial counter = 7'b0;
	always @(posedge clk or posedge rst) begin
		if (rst) counter = 0;
		else begin
			if (en) counter = counter + 1;
			else counter = counter;
		end
	end
	
endmodule