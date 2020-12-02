`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 12:05:36 AM
// Design Name: 
// Module Name: lfsr_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lfsr_tb();
reg clk_tb;
reg rst_tb;
wire [3:0] out_tb;

initial
begin
    clk_tb = 0;
    rst_tb = 1;
    #15;
    
    rst_tb = 0;
    #200;
end

always
begin
    #5;
    clk_tb = ~ clk_tb;
end

lfsr DUT(clk_tb,rst_tb,out_tb);

endmodule
