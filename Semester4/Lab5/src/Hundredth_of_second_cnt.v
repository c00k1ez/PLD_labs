module Hundredth_of_second_cnt(
input CLK,
input RESET,
input device_running,
output hundredth_of_second_passed
);
	
	reg [16:0] pulse_counter;
	assign hundredth_of_second_passed = (pulse_counter == 7'd269999);
	always @(posedge CLK or negedge RESET) begin
		if (!RESET) pulse_counter <= 0;
		else begin 
			if (device_running | hundredth_of_second_passed) begin
				if (hundredth_of_second_passed) pulse_counter <= 0;
				else pulse_counter <= pulse_counter + 1;
			end else pulse_counter <= pulse_counter;
		end
	end

endmodule