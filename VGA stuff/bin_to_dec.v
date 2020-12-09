`timescale 1ns / 1ps

module bin_to_dec(
input [5:0] bin_num,
output reg [5:0] dec_num1, dec_num2,
output c_out
// num1 is dec
// num2 is one
    );
    wire [5:0] temp;
    reg [5:0] ten = 5'b01010;
    integer exit=0;
    
        carry_select_subt conv(.a(bin_num), .b(ten), .c_in(0), .sum(temp), .c_out(c_out));

    always@(*)
    begin
    exit=0;
        if(bin_num<5'b01001 && exit==0) begin // less than 9
            dec_num2 = bin_num; // one's place
            dec_num1 = 4'b000;
            exit=1;
        end
        else begin 
         dec_num2 = 4'b110; // one's place
         dec_num1 = 4'b101;
         end
//        if(bin_num>5'b01001 && exit==0) begin // more than 9
//            dec_num2 = temp; // one's place
//            dec_num1 = 4'b001;
//            exit=1;
//        end
//        if(bin_num>5'b10011 && exit==0) begin // more than 19
//            dec_num2= temp;
//            dec_num1 = 4'b0010;
//            exit=1;
//        end
//        if(bin_num>5'b11101 && exit==0) begin // more than 29
//            dec_num2 = temp; // one's place
//            dec_num1 = 4'b0011;
//            exit=1;
//        end
//        if(bin_num>6'b100111 && exit==0) begin // more than 39
//            dec_num2= temp;
//            dec_num1 = 4'b0100;
//            exit=1;
//        end
//        if(bin_num>6'b110001 && exit==0) begin // more than 49
//            dec_num2 = temp; // one's place
//            dec_num1 = 4'b0101;
//            exit=1;
//        end
//        if(bin_num>6'b110001 && exit==0) begin // more than 59
//            dec_num2 = temp; // one's place
//            dec_num1 = 4'b0110;
//            exit=1;
//        end


   end
endmodule