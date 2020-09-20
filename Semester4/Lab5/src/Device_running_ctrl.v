module Device_running_ctrl(
input CLK,
input START_STOP,
output reg device_running
);

	initial begin
		device_running <= 1'b0;
	end

	always@(posedge CLK) begin
		if (!START_STOP) device_running <= ~device_running;
		else device_running <= device_running;
	end

endmodule