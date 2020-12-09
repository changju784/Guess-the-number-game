`timescale 1ns / 1ps

module carry_select_subt(
    input[5:0] a, //a is the binary number
    input[5:0] b, //b is 10
    input c_in,
    output reg [5:0] sum,
    output c_out
    );
    
    
    wire[5:0] c;
    wire [5:0] tsum1;
    reg [5:0] tsum2;
    
    
    negate neg1(.a(b), .neg(c));
    //ripple_carry subt(.c_in(0), .a1(a[0]), .a2(a[1]), .a3(a[2]), .a4(a[3]), .b1(c[0]), .b2(c[1]), .b3(c[2]), .b4(c[3]), .sum1(sum[0]), .sum2(sum[1]), .sum3(sum[2]), .sum4(sum[3]), .c_out(c_out));
    carry_select_adder subt(.a(a), .b(c), .c_in(c_in), .sum(tsum1), .c_out(c_out));
    
    always@(*)
    begin
    sum = tsum1;
    end
    
    
    
endmodule
