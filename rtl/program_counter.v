module program_counter (
    input clk,
    input reset,
    input [31:0] next_pc,
    output reg [31:0] pc

);
    //Synshronous PC update
    always @(posedge clk or posedge reset) begin
        if(reset) pc <= 32'b0; //Update pc to zero
        else pc<=next_pc; //Update pc to next inst
        
    end
    
endmodule