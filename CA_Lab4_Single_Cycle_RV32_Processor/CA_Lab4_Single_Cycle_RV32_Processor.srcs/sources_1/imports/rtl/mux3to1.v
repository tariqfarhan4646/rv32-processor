module mux3to1 (
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [1:0] sel,
    output [31:0] out
);

    assign out = (sel == 2'b00) ? in0 :
                 (sel == 2'b01) ? in1 :
                 (sel == 2'b10) ? in2 : 32'b0;

endmodule
