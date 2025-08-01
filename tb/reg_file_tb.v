module reg_file_tb ;
     reg clk;
    reg RegWEn;
    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rsW;
    reg [31:0] dataW;
    wire[31:0] data1;
    wire [31:0] data2;

 reg_file uut (
        .clk(clk), .RegWEn(RegWEn), .rs1(rs1), .rs2(rs2), .rsW(rsW),
        .dataW(dataW), .data1(data1), .data2(data2)
    );

        always #5 clk = ~clk;

    initial begin
        $display("Test reg file: ");
        clk=0;
        RegWEn=0;
        rs1=0; rs2=0; rsW = 0; dataW = 0;

         #10;
        RegWEn = 1; rsW = 5'd3; dataW = 32'd55; // write 55 to x3
        #10;
        RegWEn = 0; rs1 = 5'd3; rs2 = 5'd0;     // read x3 and x0

        #5 $display("data1: %d (should be 55) data2: %d(should be 0)", data1, data2);
        #5 $finish;
    end

endmodule