`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/02 02:25:32
// Design Name: 
// Module Name: 10sec_timer
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


module tensec_timer(clk,reset,timeout);
input clk;
input reset;
output reg timeout;
reg [3:0] sec;

always @(posedge clk) begin
    if(!reset)
    begin
        sec<=4'b1010;
    end
    else
    begin 
    if(sec==0) begin
        timeout = 1;
    end
    else
    begin
        timeout = 0;
        sec <= sec-1;
    end
end
end

endmodule
