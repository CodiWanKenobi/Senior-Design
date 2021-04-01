`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2021 02:11:03 PM
// Design Name: 
// Module Name: tb_GF_exp_table
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


module tb_GF_exp_table();

    reg [0:4] in;
    reg [0:3] correct;
    wire [0:3] out;
    
    GF_exp_table sut(in, out);
    
    initial begin
        in = 5'b00000;
        correct = 4'b0001;
        #50;
        in = 5'b00001;
        correct = 4'b0010;
        #50;
        in = 5'b00010;
        correct = 4'b0100;
        #50;
        in = 5'b00011;
        correct = 4'b1000;
        #50;
        in = 5'b00100;
        correct = 4'b0011;
        #50;
        in = 5'b00101;
        correct = 4'b0110;
        #50;
        in = 5'b00110;
        correct = 4'b1100;
        #50;
        in = 5'b00111;
        correct = 4'b1011;
        #50;
        in = 5'b01000;
        correct = 4'b0101;
        #50;
        in = 5'b01001;
        correct = 4'b1010;
        #50;
        in = 5'b01010;
        correct = 4'b0111;
        #50;
        in = 5'b01011;
        correct = 4'b1110;
        #50;
        in = 5'b01100;
        correct = 4'b1111;
        #50;
        in = 5'b01101;
        correct = 4'b1101;
        #50;
        in = 5'b01110;
        correct = 4'b1001;
        #50;
        in = 5'b01111;
        correct = 4'b0001;
        #50;
        in = 5'b10000;
        correct = 4'b0010;
        #50;
        in = 5'b10001;
        correct = 4'b0100;
        #50;
        in = 5'b10010;
        correct = 4'b1000;
        #50;
        in = 5'b10011;
        correct = 4'b0011;
        #50;
        in = 5'b10100;
        correct = 4'b0110;
        #50;
        in = 5'b10101;
        correct = 4'b1100;
        #50;
        in = 5'b10110;
        correct = 4'b1011;
        #50;
        in = 5'b10111;
        correct = 4'b0101;
        #50;
        in = 5'b11000;
        correct = 4'b1010;
        #50;
        in = 5'b11001;
        correct = 4'b0111;
        #50;
        in = 5'b11010;
        correct = 4'b1110;
        #50;
        in = 5'b11011;
        correct = 4'b1111;
        #50;
        in = 5'b11100;
        correct = 4'b1101;
        #50;
        in = 5'b11101;
        correct = 4'b1001;
        #50;
        in = 5'b11110;
        correct = 4'b0001;
        #50;
        in = 5'b11111;
        correct = 4'b0010;
        #50;
    end
endmodule
