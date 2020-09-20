module RS_trig(
	input nR,
	input nS,
	output Q,
	output nQ);
		assign Q = ~(nS & nQ);
		assign nQ = ~(nR & Q);

endmodule