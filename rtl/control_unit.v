module control_unit (
    input  [10:0] control_in, // inst[30], inst[14:12], inst[6:2], BrEq, BrLt
    output reg PCSel,
    output reg [2:0] ImmSel, //ID control signal
    output reg BrUn, //EX Control signal
    output reg Asel, //EX Control signal
    output reg Bsel, //EX Control signal
    output reg [3:0] alu_control, //EX Control signal
    output reg memRW, //MEM control signal
    output reg RegWEn, //ID control signal
    output reg [1:0] WBSel //WB control signal
);
    // Declare internal wires
    wire inst_30 = control_in[10];
    wire [2:0] funct3 = control_in[9:7];
    wire [4:0] inst6_2 = control_in[6:2];
    wire BrEq = control_in[1];
    wire BrLt = control_in[0];

    // Instruction decoding
    wire isItype  = (inst6_2 == 5'b00100);
    wire isRtype  = (inst6_2 == 5'b01100);
    wire isJAL    = (inst6_2 == 5'b11011);
    wire isJALR   = (inst6_2 == 5'b11001);
    wire isBranch = (inst6_2 == 5'b11000);
    wire isUtype  = (inst6_2 == 5'b01101) || (inst6_2 == 5'b00101); // LUI or AUIPC
    wire isLUI    = (inst6_2 == 5'b01101);
    wire isAuipc  = (inst6_2 == 5'b00101);
    wire isStype  = (inst6_2 == 5'b01000);

    wire isBEQ = isBranch && (funct3 == 3'b000);
    wire isBNE = isBranch && (funct3 == 3'b001);
    wire isBLT = isBranch && (funct3 == 3'b100);
    wire isBGE = isBranch && (funct3 == 3'b101);

    always @(*) begin
        // Memory and branch
        memRW  = isStype;
        BrUn   = control_in[8]; // could be inst[13] if used

        // Control signals
        Bsel   = isItype | isJALR | isJAL | isBranch | isUtype |isStype;
        Asel   = isJAL | isBranch | isUtype ;
        RegWEn = isItype | isRtype | isJAL | isJALR | isUtype;

        // PCSel logic
        PCSel = (isJAL || isJALR) ||
                (isBEQ && BrEq) ||
                (isBNE && ~BrEq) ||
                (isBLT && BrLt) ||
                (isBGE && ~BrLt);

        // ImmSel logic
        if (isJAL)       ImmSel = 3'b001; // J-type
        else if (isBranch) ImmSel = 3'b010; // B-type
        else if (isUtype)  ImmSel = 3'b011; // U-type
        else               ImmSel = 3'b000; // I-type


        // WBSel logic
        if (isJAL || isJALR)     WBSel = 2'b10;
        else if (isStype)        WBSel = 2'b00;
        else                     WBSel = 2'b01;

        // ALU control logic
      case (1'b1)
        isRtype: begin
            case ({inst_30, funct3})
                4'b0000: alu_control = 4'b0010; // ADD
                4'b1000: alu_control = 4'b0110; // SUB
                4'b0001: alu_control = 4'b1000; // SLL
                4'b0010: alu_control = 4'b0111; // SLT
                4'b0011: alu_control = 4'b1011; // SLTU
                4'b0100: alu_control = 4'b0011; // XOR
                4'b0101: alu_control = 4'b1001; // SRL
                4'b1101: alu_control = 4'b1010; // SRA
                4'b0110: alu_control = 4'b0001; // OR
                4'b0111: alu_control = 4'b0000; // AND
                default: alu_control = 4'b0010; //default, ADD
            endcase
        end
        isItype: begin
            case (funct3)
                3'b000: alu_control = 4'b0010; // ADDI
                3'b010: alu_control = 4'b0111; // SLTI
                3'b011: alu_control = 4'b1011; // SLTIU
                3'b100: alu_control = 4'b0011; // XORI
                3'b110: alu_control = 4'b0001; // ORI
                3'b111: alu_control = 4'b0000; // ANDI
                3'b001: alu_control = 4'b1000; // SLLI
                3'b101: alu_control = inst_30 ? 4'b1010 : 4'b1001; // SRAI/SRLI
                default: alu_control = 4'b0010;
            endcase
        end
        (isJAL | isJALR | isAuipc): alu_control = 4'b0010; //ADD
        isLUI: alu_control = 4'b1101;                      //Result=op2
        isStype: alu_control = 4'b0010;                     //ADD
        default: alu_control = 4'b0010;                     //ADD
    endcase
    end


endmodule
