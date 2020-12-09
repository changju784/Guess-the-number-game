`timescale 1ns / 1ps

module ripple_carry(
    
    input c_in,
    input a1,
    input b1,
    input a2,
    input b2,
    input a3,
    input b3,
    input a4,
    input b4,
    input a5,
    input b5,
    input a6,
    input b6,
    output sum1,
    output sum2,
    output sum3,
    output sum4,
    output sum5,
    output sum6,
    output c_out
    );
    
    wire w1, w2, w3, w4, w5;
    full_adder f1(.c_in(c_in), .a(a1), .b(b1), .sum(sum1), .c_out(w1));
    full_adder f2(.c_in(w1), .a(a2), .b(b2), .sum(sum2), .c_out(w2));
    full_adder f3(.c_in(w2), .a(a3), .b(b3), .sum(sum3), .c_out(w3));
    full_adder f4(.c_in(w3), .a(a4), .b(b4), .sum(sum4), .c_out(w4));
    full_adder f5(.c_in(w4), .a(a5), .b(b5), .sum(sum5), .c_out(w5));
    full_adder f6(.c_in(w5), .a(a6), .b(b6), .sum(sum6), .c_out(c_out));
    
    
endmodule
