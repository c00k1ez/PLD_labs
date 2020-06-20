module stopwatch (
input CLK_27,
input [1:0] KEY,
output reg [6:0] HEX0,
output reg [6:0] HEX1,
output reg [6:0] HEX2,
output reg [6:0] HEX3
);

	reg [6:0] hundredth_of_second;
	reg [6:0] tenth_of_second;
	reg [6:0] unit_seconds;
	reg [6:0] dec_seconds;
	
	wire tenth_of_second_counted;
	wire unit_of_second_counted;
	wire dec_of_second_counted;
	wire dec_full;
	
	wire hundredth_of_second_passed;
	wire tenth_of_second_passed;
	wire unit_of_second_passed;
	wire dec_of_second_passed;
	
	
	initial begin
		hundredth_of_second <= 0;
		tenth_of_second <= 0;
		unit_seconds <= 0;
		dec_seconds <= 0; 
	end
	
	Device_running_ctrl ctrl_module (.CLK(CLK_27), 
					 .START_STOP(KEY[0]), 
					 .device_running(device_running));
	Hundredth_of_second_cnt hundredth_module (.CLK(CLK_27),
						  .RESET(KEY[1]), 
						  .device_running(device_running),
						  .hundredth_of_second_passed(hundredth_of_second_passed));
	
	assign tenth_of_second_counted = (hundredth_of_second == 7'd9);
	assign unit_of_second_counted = (tenth_of_second == 7'd9);
	assign dec_of_second_counted = (unit_seconds == 7'd9);
	assign dec_full = (dec_seconds == 7'd9);
	
	assign tenth_of_second_passed = hundredth_of_second_passed & tenth_of_second_counted;
	assign unit_of_second_passed = tenth_of_second_passed & unit_of_second_counted;
	assign dec_of_second_passed = unit_of_second_passed & dec_of_second_counted;
	
	always@(posedge CLK_27 or negedge KEY[1]) begin 
		if (!KEY[1]) begin
			hundredth_of_second <= 0;
		end
		else begin
			if (tenth_of_second_passed) hundredth_of_second <= 0;
			else if (hundredth_of_second_passed) hundredth_of_second <= hundredth_of_second + 1;
				  else hundredth_of_second <= hundredth_of_second;
				  
			case (hundredth_of_second)
				7'b0000000: HEX3 = 7'b1000000;
				7'b0000001: HEX3 = 7'b1111001;
				7'b0000010: HEX3 = 7'b0100100;
				7'b0000011: HEX3 = 7'b0110000;
				7'b0000100: HEX3 = 7'b0011001;
				7'b0000101: HEX3 = 7'b0010010;
				7'b0000110: HEX3 = 7'b0000010;
				7'b0000111: HEX3 = 7'b1111000;
				7'b0001000: HEX3 = 7'b0000000;
				7'b0001001: HEX3 = 7'b0010000;
				default: HEX3 = 7'b0000000;
			endcase
		end
	end
	
	always@(posedge CLK_27 or negedge KEY[1]) begin 
		if (!KEY[1]) begin
			tenth_of_second <= 0;
		end
		else begin
			if (unit_of_second_passed) tenth_of_second <= 0;
			else if (tenth_of_second_passed) tenth_of_second <= tenth_of_second + 1;
				  else tenth_of_second <= tenth_of_second;
			case (tenth_of_second)
				7'b0000000: HEX2 = 7'b1000000;
				7'b0000001: HEX2 = 7'b1111001;
				7'b0000010: HEX2 = 7'b0100100;
				7'b0000011: HEX2 = 7'b0110000;
				7'b0000100: HEX2 = 7'b0011001;
				7'b0000101: HEX2 = 7'b0010010;
				7'b0000110: HEX2 = 7'b0000010;
				7'b0000111: HEX2 = 7'b1111000;
				7'b0001000: HEX2 = 7'b0000000;
				7'b0001001: HEX2 = 7'b0010000;
				default: HEX2 = 7'b0000000;
			endcase
		end
	end
	
	always@(posedge CLK_27 or negedge KEY[1]) begin 
		if (!KEY[1]) begin
			unit_seconds <= 0;
		end
		else begin
			if (dec_of_second_passed) unit_seconds <= 0;
			else if (unit_of_second_passed) unit_seconds <= unit_seconds + 1;
				  else unit_seconds <= unit_seconds;
			case (unit_seconds)
				7'b0000000: HEX1 = 7'b1000000;
				7'b0000001: HEX1 = 7'b1111001;
				7'b0000010: HEX1 = 7'b0100100;
				7'b0000011: HEX1 = 7'b0110000;
				7'b0000100: HEX1 = 7'b0011001;
				7'b0000101: HEX1 = 7'b0010010;
				7'b0000110: HEX1 = 7'b0000010;
				7'b0000111: HEX1 = 7'b1111000;
				7'b0001000: HEX1 = 7'b0000000;
				7'b0001001: HEX1 = 7'b0010000;
				default: HEX1 = 7'b0000000;
			endcase
		end
	end

	always@(posedge CLK_27 or negedge KEY[1]) begin 
		if (!KEY[1]) begin
			dec_seconds <= 0;
		end
		else begin
			if (dec_full) dec_seconds <= 0;
			else if (dec_of_second_passed) dec_seconds <= dec_seconds + 1;
				  else dec_seconds <= dec_seconds;
			case (dec_seconds)
				7'b0000000: HEX0 = 7'b1000000;
				7'b0000001: HEX0 = 7'b1111001;
				7'b0000010: HEX0 = 7'b0100100;
				7'b0000011: HEX0 = 7'b0110000;
				7'b0000100: HEX0 = 7'b0011001;
				7'b0000101: HEX0 = 7'b0010010;
				7'b0000110: HEX0 = 7'b0000010;
				7'b0000111: HEX0 = 7'b1111000;
				7'b0001000: HEX0 = 7'b0000000;
				7'b0001001: HEX0 = 7'b0010000;
				default: HEX0 = 7'b0000000;
			endcase
		end
	end
	
endmodule
