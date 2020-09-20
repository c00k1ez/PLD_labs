`define ALU_OP_WIDTH 	6

`define ALU_ADD			6'b011000
`define ALU_SUB			6'b011001
`define ALU_XOR			6'b101111
`define ALU_OR				6'b101110
`define ALU_AND			6'b010101
`define ALU_SRA			6'b100100
`define ALU_SRL			6'b100101
`define ALU_SLL			6'b100111
`define ALU_LTS			6'b000000
`define ALU_LTU			6'b000001
`define ALU_GES			6'b001010
`define ALU_GEU			6'b001011
`define ALU_EQ				6'b001100
`define ALU_NE				6'b001101

`define WORD_SIZE			32
`define MAX_INT			(2 ** `WORD_SIZE - 1)