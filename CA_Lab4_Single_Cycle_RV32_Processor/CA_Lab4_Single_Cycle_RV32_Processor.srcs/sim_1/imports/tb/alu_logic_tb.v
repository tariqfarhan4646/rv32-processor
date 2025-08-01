module alu_logic_tb ;
    reg [31:0] op1;
    reg [31:0] op2;
    reg [3:0] alu_control;
     wire [31:0]result;

     alu_logic uut(.op1(op1), .op2(op2), .alu_control(alu_control), .result(result));
    initial begin
     $display("Testing alu_logic: ");

     op1=32'd100; op2=32'd5;
        alu_control = 4'b0010; #5 $display("ADD: %d", result);
        alu_control = 4'b0110; #5 $display("SUB: %d", result);
        alu_control = 4'b0000; #5 $display("AND: %d", result);
        alu_control = 4'b0001; #5 $display("OR : %d", result);
        alu_control = 4'b0111; #5 $display("SLT: %d", result);

        $finish;
        end
endmodule