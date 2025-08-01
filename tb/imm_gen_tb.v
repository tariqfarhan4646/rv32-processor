module imm_gen_tb;
    reg [31:0] inst; 
    wire [31:0] imm_out;

    imm_gen uut (.inst(inst), .imm_out(imm_out));

    initial begin
        inst = 32'hFFF10113; // ADDI x2, x2, -1
        #5 $display("imm out (should be -1) equals: %d",imm_out );
        $finish;
    end

  
endmodule