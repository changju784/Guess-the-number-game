`timescale 1ns / 1ps


module negate(
    input [5:0] a,
    output [5:0] neg
    );
    wire [5:0] b;
    xor(b[0], a[0], 1);
    xor(b[1], a[1], 1);
    xor(b[2], a[2], 1);
    xor(b[3], a[3], 1);
    xor(b[4], a[4], 1);
    xor(b[5], a[5], 1);
    
    assign neg = b + 4'b0001;
    
endmodule
