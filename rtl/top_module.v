module top_module (
    input clk,
    input reset
);

    // Program Counter
    wire [31:0] pc, next_pc;

    // Fetched Instruction
    wire [31:0] inst;

    // Immediate from imm_gen
    wire [31:0] imm;

    // Register File I/O
    wire [31:0] data1, data2;
    wire [4:0] rs1 = inst[19:15];
    wire [4:0] rs2 = inst[24:20];
    wire [4:0] rd  = inst[11:7];

    // Control signal detection
    wire [6:0] opcode = inst[6:0];
    wire [2:0] funct3 = inst[14:12];

    // Branch comparator outputs
    wire Eq, Lt;

    // ALU inputs and result
    wire [31:0] operandA, operandB;
    wire [31:0] alu_result;

    // Placeholder Data Memory
    wire [31:0] dataR;
    wire [31:0] dataW;

    // PC increment
    wire [31:0] pc_plus_4 = pc + 4;

    //Control Unit
    wire PCSel;
    wire [2:0] ImmSel;
    wire BrUn;
    wire Asel;
    wire Bsel;
    wire [3:0] alu_control;
    wire memRW;
    wire RegWEn;
    wire [1:0] WBSel;

//Module Instantiations
    program_counter pc_reg (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    Branch_comp bc (
        .A(data1),
        .B(data2),
        .BrUn(1'b0),
        .Eq(Eq),
        .Lt(Lt)
    );

    control_unit cu(
        .control_in({inst[30], inst[14:12], inst[6:2], Eq, Lt}),
        .PCSel(PCSel)
        .ImmSel(ImmSel),
        .BrUn(BrUn),
        .Asel(Asel),
        .Bsel(Bsel),
        .alu_control(alu_control),
        .memRW(memRW),
        .RegWEn(RegWEn),
        .WBSel(WBSel)
    );

    inst_mem imem (
        .addr(pc),
        .dataR(inst)
    );

    imm_gen immgen (
        .inst(inst),
        .ImmSel(ImmSel),
        .imm_out(imm)
    );

    reg_file rf (
        .clk(clk),
        .RegWEn(RegWEn),
        .rs1(rs1),
        .rs2(rs2),
        .rsW(rd),
        .dataW(dataW),
        .data1(data1),
        .data2(data2)
    );

    mux2to1 operandA_mux (
        .in0(data1),
        .in1(pc),
        .sel(Asel),
        .out(operandA)
    );

    mux2to1 operandB_mux (
        .in0(data2),
        .in1(imm),
        .sel(Bsel),
        .out(operandB)
    );

    alu_logic alu (
        .op1(operandA),
        .op2(operandB),
        .alu_control(alu_control),
        .result(alu_result)
    );

    wire [31:0] jump_target = alu_result & 32'hFFFFFFFE;

    mux2to1 pcsel_mux (
        .in0(pc_plus_4),
        .in1(jump_target),
        .sel(PCSel),
        .out(next_pc)
    );

    data_mem dm (
        .clk(clk),
        .addr(alu_result),
        .dataW(data2),
        .memRW(memRW),
        .dataR(dataR)
    );

    mux3to1 wbsel_mux (
        .in0(dataR),
        .in1(alu_result),
        .in2(pc_plus_4),
        .sel(WBSel),
        .out(dataW)
    );

endmodule
