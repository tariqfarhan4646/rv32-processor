module program_counter_tb;
    reg clk;
    reg reset;
    reg[31:0] next_pc;
    wire [31:0] pc;

    program_counter uut (.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc));
    
    always #5 clk=~clk;

    initial begin
        //Initial values
        clk=0; reset=1; next_pc=32'd100;
        #10 reset=0;
        #10 next_pc=32'd104;
        #10 next_pc=32'd108;
        #10 $finish;
    end
endmodule