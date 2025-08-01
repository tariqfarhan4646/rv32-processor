module top_tb;
    reg clk;
    reg reset;

    // Instantiate top module
    top_module uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $display("Running top_tb simulation...");
        clk = 1;
        reset = 1;

   
        $monitor("Time: %t | PC: %h | Inst: %h | x1: %h | x2: %h | Eq: %b | Lt: %b | imm: %h | ALU: %h | jump_target: %h | PCSel: %b | next_pc: %h", 
                 $time, uut.pc, uut.inst, uut.data1, uut.data2, uut.Eq, uut.Lt, uut.imm, uut.alu_result, uut.jump_target, uut.PCSel, uut.next_pc);

        #10 reset = 0; // Release reset

        // Run for a few cycles to simulate instruction execution
        #5000;

        $finish;
    end
endmodule
