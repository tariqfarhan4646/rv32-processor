module reg_file (
    input clk,
    input RegWEn,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rsW,
    input [31:0] dataW,
    output [31:0] data1,
    output [31:0] data2
);

    // 32 registers, each 32-bit wide
    reg [31:0] registers [31:0];

    // Combinational read
    assign data1 = (rs1 == 5'd0) ? 32'd0 : registers[rs1];
    assign data2 = (rs2 == 5'd0) ? 32'd0 : registers[rs2];

    // Write on rising edge of clk
    always @(posedge clk) begin
        if (RegWEn && rsW != 5'd0) begin
            registers[rsW] <= dataW;
        end
    end

endmodule
