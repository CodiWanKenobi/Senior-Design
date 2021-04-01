`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT  
// Engineer: Zach Zipper
// 
// Create Date: 02/26/2021 04:09:39 PM
// Design Name: 
// Module Name: GF_exp_table
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: The exponential lookup table for GF(2^4) elements
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GF_exp_table(
    input [0:4] in,
    output reg [0:3] out
    );
    
    always @(*) begin
        case(in)
            5'b00000, 5'b11110, 5'b01111: out = 4'b0001;
            5'b00001, 5'b11111, 5'b10000: out = 4'b0010;
            5'b00010, 5'b10001: out = 4'b0100;
            5'b00011, 5'b10010: out = 4'b1000;
            5'b00100, 5'b10011: out = 4'b0011;
            5'b00101, 5'b10100: out = 4'b0110;
            5'b00110, 5'b10101: out = 4'b1100;
            5'b00111, 5'b10110: out = 4'b1011;
            5'b01000, 5'b10111: out = 4'b0101;
            5'b01001, 5'b11000: out = 4'b1010;
            5'b01010, 5'b11001: out = 4'b0111;
            5'b01011, 5'b11010: out = 4'b1110;
            5'b01100, 5'b11011: out = 4'b1111;
            5'b01101, 5'b11100: out = 4'b1101;
            5'b01110, 5'b11101: out = 4'b1001;

            default: out = 4'b0000;
        endcase
    end
endmodule
