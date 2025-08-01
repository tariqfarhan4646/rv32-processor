module inst_mem_tb;
    reg [31:0] addr;
    wire [31:0] dataR;

    // DUT instantiation
    inst_mem uut (
        .addr(addr),
        .dataR(dataR)
    );

    initial begin
        $display("Test inst_mem:");

        addr = 32'd0;
        #5 $display("Instruction at address %d is %d", addr, dataR);

        addr = 32'd4;
        #5 $display("Instruction at address %d is %d", addr, dataR);

        $finish;
    end
endmodule
