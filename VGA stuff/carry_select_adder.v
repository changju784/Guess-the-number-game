`timescale 1ns / 1ps

module carry_select_adder(
    input[5:0] a,
    input[5:0] b,
    input c_in,
    output reg[5:0] sum,
    output reg c_out
    );
    wire[5:0] s1;
    wire c_out1;
    //for c_in = 0
    ripple_carry r1(.c_in(0), .a1(a[0]), .a2(a[1]), .a3(a[2]), .a4(a[3]),  .a5(a[4]), .a6(a[5]), .b1(b[0]), .b2(b[1]), .b3(b[2]), .b4(b[3]), .b5(b[4]), .b6(b[5]), .sum1(s1[0]), .sum2(s1[1]), .sum3(s1[2]), .sum4(s1[3]), .sum5(s1[4]), .sum6(s1[5]), .c_out(c_out1));
        
    always @ (*)
    begin
    if (c_in == 1'b0)
    begin 
    sum[0]=s1[0];
    sum[1]=s1[1];
    sum[2]=s1[2];
    sum[3]=s1[3];
    sum[4]=s1[4];
    sum[5]=s1[5];
    c_out = c_out1;
    end
    end
endmodule
