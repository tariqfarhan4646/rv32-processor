module Bsel (
    input [31:0] reg_data2,
    input [31:0] imm_data,
    input Bsel,
    output [31:0] operandB
);
    
    assign operandB= (Bsel==0)? reg_data2: imm_data;
    
endmodule