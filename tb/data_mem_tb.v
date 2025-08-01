module data_mem_tb;

    // Inputs to DUT
    reg clk;
    reg [31:0] addr;
    reg [31:0] dataW;
    reg memRW;

    // Output from DUT
    wire [31:0] dataR;

    // Instantiate the data memory module
    data_mem uut (
        .clk(clk),
        .addr(addr),
        .dataW(dataW),
        .memRW(memRW),
        .dataR(dataR)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        $display("Starting data memory test...");

        clk = 0;
        addr = 32'h8;
        dataW = 1234;
        memRW = 1;   // Write operation

        #10;
        memRW = 0;   // Read operation

        #5 $display("Data at address 0x8 is %d (expected: 1234)", dataR);

        $finish;
    end
endmodule
