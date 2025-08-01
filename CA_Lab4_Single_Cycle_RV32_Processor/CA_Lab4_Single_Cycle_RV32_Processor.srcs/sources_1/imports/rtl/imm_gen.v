module imm_gen (
    input [31:0] inst,            // 32-bit instruction
    input [2:0] ImmSel,           // 000 = I-type, 001 = J-type, 010 = B-type, 011 = U-type, 100 = S-type
    output reg [31:0] imm_out     // sign-extended immediate
);
    always @(*) begin
        case (ImmSel)
            3'b000: begin // I-type: inst[31:20]
                imm_out = {{20{inst[31]}}, inst[31:20]};
            end
            3'b001: begin // J-type (JAL): [20|10:1|11|19:12] << 1
                imm_out = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
            end
            3'b010: begin // B-type: [12|10:5|4:1|11] << 1
                imm_out = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            end
            3'b011: begin // U-type (LUI/AUIPC): inst[31:12] << 12
                imm_out = {inst[31:12], 12'b0};
            end
            3'b100: begin // S-type: [11:5|4:0] = inst[31:25] & inst[11:7]
                imm_out = {{20{inst[31]}}, inst[31:25], inst[11:7]};
            end
            default: begin
                imm_out = 32'b0; // default case
            end
        endcase
    end
endmodule
