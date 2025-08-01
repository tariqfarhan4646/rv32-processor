module data_mem (
    input clk,
    input [31:0] addr,
    input [31:0] dataW,
    input memRW,
    output [31:0] dataR
);
    // Memory array
    reg [31:0] memory[0:255];

    //Combinational read
    assign dataR= memory[addr[9:2]];

    //Write data @posedge clk and write enable
    always @(posedge clk ) begin
        if (memRW) begin
        memory[addr[9:2]]<=dataW;
        end
        
    end

    
endmodule