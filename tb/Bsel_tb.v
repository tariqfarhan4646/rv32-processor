module Bsel_tb;
    reg [31:0] reg_data2;
    reg [31:0] imm_data;
    reg Bsel;
    wire [31:0] operandB;

    Bsel uut(.reg_data2(reg_data2), .imm_data(imm_data), .Bsel(Bsel), .operandB(operandB) );

    initial begin
        Bsel=0; reg_data2=32'd100; imm_data=32'd300;
        #5 $display("operandB= %d (should be reg_data=100 )", operandB);

        Bsel=1;
        #5 $display("operandB= %d (should be imm_data=300 )", operandB);
        
        

    end
    endmodule