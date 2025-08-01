`timescale 1ns / 1ps
module Branch_comp_tb;

    // Inputs
    reg [31:0] A;
    reg [31:0] B;
    reg BrUn;

    // Outputs
    wire Eq;
    wire Lt;

    // Instantiate the Unit Under Test (UUT)
    Branch_comp uut (
        .A(A),
        .B(B),
        .BrUn(BrUn),
        .Eq(Eq),
        .Lt(Lt)
    );

    initial begin
        $display("Time | A         | B         | BrUn | Eq | Lt");
        $monitor("%4t | %h | %h |  %b   |  %b |  %b", $time, A, B, BrUn, Eq, Lt);

        // Case 1: A == B
        A = 32'd10; B = 32'd10; BrUn = 0; #10;

        // Case 2: A < B (signed)
        A = -5; B = 10; BrUn = 0; #10;

        // Case 3: A < B (unsigned)
        A = 32'hFFFFFFFE; B = 32'd1; BrUn = 1; #10;

        // Case 4: A > B (signed)
        A = 32'd100; B = 32'd50; BrUn = 0; #10;

        // Case 5: A > B (unsigned)
        A = 32'd100; B = 32'd50; BrUn = 1; #10;

        // Case 6: A == B again
        A = 32'd0; B = 32'd0; BrUn = 0; #10;

        $finish;
    end

endmodule
