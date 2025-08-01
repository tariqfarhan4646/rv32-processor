module Branch_comp (
    input  [31:0] A,
    input  [31:0] B,
    input         BrUn,  // 0: signed, 1: unsigned
    output reg    Eq,    // 1 if A == B
    output reg    Lt     // 1 if A < B
);
    always @(*) begin
        Eq= (A==B);
        if(BrUn) Lt= (A<B); //For unsigned comparison
        else Lt=($signed(A)<$signed(B));  //For signed comparison
    end
    
endmodule