`timescale 1ns / 1ps

`include "params.vh"

module alu_tb;

	reg 	[`ALU_OP_WIDTH-1:0] 	operator_i;
	reg 	[31:0] 					operand_a_i;
	reg 	[31:0] 					operand_b_i;
	wire	[31:0]		 			result_o;
	wire								comparison_result_o;
	integer         				LOG_FILE;
	
	miriscv_alu ALU(
		.operator_i(operator_i),
		.operand_a_i(operand_a_i),
		.operand_b_i(operand_b_i),
		.result_o(result_o),
		.comparison_result_o(comparison_result_o)
	);
	
		
	initial begin
		
		LOG_FILE = $fopen("tests.log");
		
		// test ALU_ADD
		$display("TEST ALU_ADD\n", "----------------------------------------");
		alu_test_task(`ALU_ADD, 1, 2, 3, 0, 0); #20;
		alu_test_task(`ALU_ADD, 1, 10, 11, 0, 1); #20;
		alu_test_task(`ALU_ADD, 0, 0, 0, 0, 2); #20;
		alu_test_task(`ALU_ADD, 0, `MAX_INT, `MAX_INT, 0, 3); #20;
		alu_test_task(`ALU_ADD, 1, `MAX_INT, 0, 0, 4); #20;
		alu_test_task(`ALU_ADD, `MAX_INT, `MAX_INT, `MAX_INT-1, 0, 5); #20;
		
		// test ALU_SUB
		$display("TEST ALU_SUB\n", "----------------------------------------");
		alu_test_task(`ALU_SUB, 1, 2, `MAX_INT, 0, 6); #20;
		alu_test_task(`ALU_SUB, 10, 7, 3, 0, 7); #20;
		alu_test_task(`ALU_SUB, 0, 0, 0, 0, 8); #20;
		alu_test_task(`ALU_SUB, `MAX_INT, 0, `MAX_INT, 0, 9); #20;
		alu_test_task(`ALU_SUB, `MAX_INT, `MAX_INT-1, 1, 0, 10); #20;
		alu_test_task(`ALU_SUB, `MAX_INT, `MAX_INT, 0, 0, 11); #20;
		alu_test_task(`ALU_SUB, 0, `MAX_INT, 1, 0, 12); #20;
		
		$display("TEST ALU_XOR\n", "----------------------------------------");
		alu_test_task(`ALU_XOR, 1, `MAX_INT, `MAX_INT-1, 0, 13); #20;
		alu_test_task(`ALU_XOR, `MAX_INT, `MAX_INT-1, 1, 0, 14); #20;
		alu_test_task(`ALU_XOR, `MAX_INT, `MAX_INT, 0, 0, 15); #20;
		alu_test_task(`ALU_XOR, 0, `MAX_INT, `MAX_INT, 0, 16); #20;
		
		$display("TEST ALU_OR\n", "----------------------------------------");
		alu_test_task(`ALU_OR, 1, `MAX_INT, `MAX_INT, 0, 17); #20;
		alu_test_task(`ALU_OR, `MAX_INT, `MAX_INT-1, `MAX_INT, 0, 18); #20;
		alu_test_task(`ALU_OR, 0, `MAX_INT, `MAX_INT, 0, 19); #20;
		alu_test_task(`ALU_OR, 1, 2, 3, 0, 20); #20;
		
		$display("TEST ALU_AND\n", "----------------------------------------");
		alu_test_task(`ALU_AND, 1, `MAX_INT, 1, 0, 21); #20;
		alu_test_task(`ALU_AND, `MAX_INT, `MAX_INT-1, `MAX_INT-1, 0, 22); #20;
		alu_test_task(`ALU_AND, 0, `MAX_INT, 0, 0, 23); #20;
		alu_test_task(`ALU_AND, 1, 2, 0, 0, 24); #20;
		alu_test_task(`ALU_AND, 3, 2, 2, 0, 25); #20;
		
		$display("TEST ALU_SRA\n", "----------------------------------------");
		alu_test_task(`ALU_SRA, 1, `MAX_INT, 0, 0, 26); #20;
		alu_test_task(`ALU_SRA, `MAX_INT, `MAX_INT-1, 0, 0, 27); #20;
		alu_test_task(`ALU_SRA, 0, `MAX_INT, 0, 0, 28); #20;
		alu_test_task(`ALU_SRA, 1, 2, 0, 0, 29); #20;
		alu_test_task(`ALU_SRA, 10, 2, 2, 0, 30); #20;
		alu_test_task(`ALU_SRA, `MAX_INT, `MAX_INT, 0, 0, 31); #20;
		alu_test_task(`ALU_SRA, 100, 3, 12, 0, 32); #20;
		
		$display("TEST ALU_SRL\n", "----------------------------------------");
		alu_test_task(`ALU_SRL, 1, `MAX_INT, 0, 0, 33); #20;
		alu_test_task(`ALU_SRL, `MAX_INT, `MAX_INT-1, 0, 0, 34); #20;
		alu_test_task(`ALU_SRL, 0, `MAX_INT, 0, 0, 35); #20;
		alu_test_task(`ALU_SRL, 1, 2, 0, 0, 36); #20;
		alu_test_task(`ALU_SRL, 10, 2, 2, 0, 37); #20;
		alu_test_task(`ALU_SRL, `MAX_INT, `MAX_INT, 0, 0, 38); #20;
		alu_test_task(`ALU_SRL, 100, 3, 12, 0, 39); #20;
		
		$display("TEST ALU_SLL\n", "----------------------------------------");
		alu_test_task(`ALU_SLL, 1, `MAX_INT, 0, 0, 40); #20;
		alu_test_task(`ALU_SLL, `MAX_INT, `MAX_INT-1, 0, 0, 41); #20;
		alu_test_task(`ALU_SLL, 0, `MAX_INT, 0, 0, 42); #20;
		alu_test_task(`ALU_SLL, 1, 2, 4, 0, 43); #20;
		alu_test_task(`ALU_SLL, 10, 2, 40, 0, 44); #20;
		alu_test_task(`ALU_SLL, `MAX_INT, `MAX_INT, 0, 0, 45); #20;
		alu_test_task(`ALU_SLL, 100, 3, 800, 0, 46); #20;
		
		$display("TEST ALU_LTS\n", "----------------------------------------");
		alu_test_task(`ALU_LTS, 1, `MAX_INT, 1, 1, 47); #20;
		alu_test_task(`ALU_LTS,`MAX_INT, 1, 0, 0, 48); #20;
		alu_test_task(`ALU_LTS, -1, 1, 0, 0, 49); #20;
		
		$display("TEST ALU_LTU\n", "----------------------------------------");
		alu_test_task(`ALU_LTU, 1, `MAX_INT, 1, 1, 50); #20;
		alu_test_task(`ALU_LTU,`MAX_INT, 1, 0, 0, 51); #20;
		alu_test_task(`ALU_LTU, -1, 1, 0, 0, 52); #20;
		
		$display("TEST ALU_GES\n", "----------------------------------------");
		alu_test_task(`ALU_GEU, 1, `MAX_INT, 0, 0, 53); #20;
		alu_test_task(`ALU_GEU,`MAX_INT, 1, 1, 1, 54); #20;
		alu_test_task(`ALU_GEU, -1, 1, 1, 1, 55); #20;
		alu_test_task(`ALU_GEU, `MAX_INT, `MAX_INT, 1, 1, 56); #20;
		
		$display("TEST ALU_GEU\n", "----------------------------------------");
		alu_test_task(`ALU_GEU, 1, `MAX_INT, 0, 0, 57); #20;
		alu_test_task(`ALU_GEU,`MAX_INT, 1, 1, 1, 58); #20;
		alu_test_task(`ALU_GEU, -1, 1, 1, 1, 59); #20;
		alu_test_task(`ALU_GEU, `MAX_INT, `MAX_INT, 1, 1, 60); #20;
		
		$display("TEST ALU_EQ\n", "----------------------------------------");
		alu_test_task(`ALU_EQ, 1, `MAX_INT, 0, 0, 61); #20;
		alu_test_task(`ALU_EQ, -1, 1, 0, 0, 62); #20;
		alu_test_task(`ALU_EQ, -1, `MAX_INT, 1, 1, 63); #20;
		alu_test_task(`ALU_EQ, `MAX_INT, `MAX_INT, 1, 1, 64); #20;
		
		$display("TEST ALU_NE\n", "----------------------------------------");
		alu_test_task(`ALU_NE, 1, `MAX_INT, 1, 1, 65); #20;
		alu_test_task(`ALU_NE, -1, 1, 1, 1, 66); #20;
		alu_test_task(`ALU_NE, -1, `MAX_INT, 0, 0, 67); #20;
		alu_test_task(`ALU_NE, `MAX_INT, `MAX_INT, 0, 0, 68); #20;
		
		$fclose(LOG_FILE);
	end
	
	task alu_test_task;
		input integer operator;
		input integer operand_a;
		input integer operand_b;
		input integer expected_result_o;
		input integer expected_comparison_result_o;
		input integer test_number;
		
		begin
			operator_i = operator;
			operand_a_i = operand_a;
			operand_b_i = operand_b;
			#10;
			if((expected_result_o == result_o) && (expected_comparison_result_o == comparison_result_o)) begin
				$display("TEST\t%d\tPASSED!", test_number);
				$fdisplay(LOG_FILE, "TEST\t%d\tPASSED!", test_number);
			end
			else begin
				$error("TEST\t%d\tFAILED!", test_number,
						 "\n----------------------------------------\n",
						 "expected result_o:\t%d ", expected_result_o,
						 "\ncurrent result_o:\t%d ", result_o,
						 "\nexpected comparison_result_o:\t%d ", expected_comparison_result_o,
						 "\ncurrent comparison_result_o:\t%d ", comparison_result_o,
						 "\n----------------------------------------\n" 
				);
				$fdisplay(LOG_FILE, "TEST\t%d\tFAILED!", test_number,
							 "\n----------------------------------------\n",
							 "expected result_o:\t%d ", expected_result_o,
							 "\ncurrent result_o:\t%d ", result_o,
							 "\nexpected comparison_result_o:\t%d ", expected_comparison_result_o,
							 "\ncurrent comparison_result_o:\t%d ", comparison_result_o,
							 "\n----------------------------------------\n" 
				);
			end
		end
	endtask
	
endmodule