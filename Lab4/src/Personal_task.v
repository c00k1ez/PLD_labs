module Personal_task(
input[9:0] SW,
input[1:0] KEY,
input CLK,

output reg[6:0] HEX0,
output reg[6:0] HEX1,
output[9:0] LEDR);

	reg[9:0] shift_reg;
	reg[6:0] cnt;
	reg[3:0] cnt_zero;
	reg[3:0] cnt_ones;
	reg tens;
	reg[6:0] units; 
	
	initial begin
		cnt = 7'b0000000;
		shift_reg <= 10'b0000000000;
		cnt_ones = 4'b0000;
		cnt_zero = 4'b1010;
		tens = 1'b0;
		units = 7'b0000000;
	end
	
	always@(posedge CLK) begin
		if (!KEY[1]) begin // проверяем нажатие кнопки для сброса
			cnt = 7'b0000000;
			shift_reg <= 10'b0000000000;
			cnt_ones = 4'b0000;
			cnt_zero = 4'b1010;
			tens = 1'b0;
			units = 7'b0000000;
		end else begin
			if (!KEY[0]) begin // проверяем кнопку действия
			
				shift_reg <= SW;
				// считаем кол-во единиц и нулей в двоичном представлении введенного числа
				cnt_ones = shift_reg[0] + shift_reg[1] + shift_reg[2] + shift_reg[3] + shift_reg[4] + shift_reg[5] + shift_reg[6] + shift_reg[7] + shift_reg[8] + shift_reg[9];
				cnt_zero = 10 - cnt_ones;
				// инкриментим счетчик
				if (cnt_ones > cnt_zero) begin 
					cnt = cnt + 1'b1;
				end
			end
		end
		// переводим в двоично-десятичную систему 
		tens = cnt > 9 ? 1 : 0;
		units = cnt - ({7{tens}} & 7'b0001010);
	end
	
	// выводим единицы
	always@(units) begin
		case (units)
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
	
	// выводим нули
	always@(tens) HEX1 = tens < 1 ? 7'b1000000 : 7'b1111001;
	// выводим введенное число на диоды
	assign LEDR = shift_reg;


endmodule