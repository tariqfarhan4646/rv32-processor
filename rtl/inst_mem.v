module inst_mem (
    input [31:0] addr,
    output [31:0] dataR
);
    reg [31:0] memory [0:255];

    assign dataR = (addr[9:2] < 256) ? memory[addr[9:2]] : 32'h00000013;

    initial begin
 //Testing R type inst 
         memory[0] = 32'h00500093 ;//  ADDI x1, x0, 5   # x1 = 5
        memory[1] = 32'h00300113 ;// ADDI x2, x0, 3  # x2 = 3
        memory[2] = 32'h002081B3  ; //ADD x3, x1, x2  # x3 = x1 + x2 = 8
        memory[3] = 32'h40208233 ;// SUB x4, x1, x2 # x4 = x1 - x2 = 2
         memory[4] = 32'h0020F2B3  ;//AND x5, x1, x2   # x5 = x1 & x2

 
        // I-type tests
        memory[5] = 32'h00A00093; // ADDI x1, x0, 10
        memory[6] = 32'h0140A113; // SLTI x2, x1, 20
        memory[7] = 32'h00F0F193; // ANDI x3, x1, 15

          // S-type
        memory[8]  = 32'h06400093; // ADDI x1, x0, 100
        memory[9]  = 32'h0A500113; // ADDI x2, x0, 0xA5
        memory[10]=32'h00000013; //NOP
        memory[11] = 32'h0020A023; // SW x2, 0(x1)
        //B-Type
        memory[12] = 32'h00500093; // ADDI x1, x0, 5
        memory[13] = 32'h00500113; // ADDI x2, x0, 5
        memory[14] = 32'h00000013; // ADDI x0, x0, 0 ie. NOP Should not execute , program will branch

        memory[15] = 32'h00208463; // BEQ x1, x2, +8

        // label1:
        memory[16] = 32'h00000013; // ADDI x0, x0, 0 ie. NOP Should not execute , program will branch
        
        memory[17] = 32'h07B00193; // ADDI x3, x0, 123
        
        //For U type
        memory[18] = 32'h123450B7; // LUI x1, 0x12345
        memory[19] = 32'h00010117; // AUIPC x2, 0x10 (<<12 = 0x1000) PC+Imm=0x0010040
        
        // J-type
        memory[20] = 32'h008000EF; // JAL x1, +8 (jump to label2 at [19])
        memory[21] = 32'h00000013; // ADDI x0, x0, 0 ie. NOP Should not execute , program will jump

        // label2:
        memory[22] = 32'h00100113; // ADDI x2, x0, 1
             
       

        end
endmodule
