`timescale 1ns / 1ps

module half_adder(a,b,sum,c_out);
    input a,b; 
    output sum,c_out; 
    xor xor1(sum,a,b); 
    and and1(c_out,a,b); 
endmodule

