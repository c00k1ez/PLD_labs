module D_latch(
input d,
input en,
output reg q);

	always @(en, d) begin
		if (en) q = d; // запись
		else q = q; // хранение
	end

endmodule
