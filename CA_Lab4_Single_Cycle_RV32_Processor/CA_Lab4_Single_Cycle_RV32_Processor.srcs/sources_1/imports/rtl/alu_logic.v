module alu_logic (
    input [31:0] op1,
    input [31:0] op2,
    input [3:0] alu_control,
    output reg [31:0]result
);
    always @(*) begin
        case (alu_control)
               4'b0000: result = op1 & op2;                          // AND
                4'b0001: result = op1 | op2;                          // OR
                4'b0010: result = op1 + op2;                          // ADD
                4'b0011: result = op1 ^ op2;                          // XOR
                4'b0110: result = op1 - op2;                          // SUB
                4'b0111: result = ($signed(op1) < $signed(op2)) ? 1 : 0; // SLT
                4'b1000: result = op1 << op2[4:0];                    // SLL
                4'b1001: result = op1 >> op2[4:0];                    // SRL
                4'b1010: result = $signed(op1) >>> op2[4:0];          // SRA
                4'b1011: result = (op1 < op2) ? 1 : 0;                // SLTU
                4'b1100: result=op1; //Select operand1=opA
                4'b1101: result=op2; //Select operand2=opB
                default: result = 32'b0;
        endcase
        
    end
    
endmodule