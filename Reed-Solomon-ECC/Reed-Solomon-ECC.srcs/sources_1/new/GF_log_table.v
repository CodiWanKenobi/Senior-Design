`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT
// Engineer: Zach Zipper
// 
// Create Date: 02/26/2021 04:43:36 PM
// Design Name: 
// Module Name: GF_log_table
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Lookup table for taking the log of a GF element
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GF_log_table(
    input [0:3] in,
    output reg [0:3] out
    );
    always @(*) begin
        case(in)
            4'b0000: out = 4'b0000;
            4'b0001: out = 4'b0000;
            4'b0010: out = 4'b0001;
            4'b0011: out = 4'b0100;
            4'b0100: out = 4'b0010;
            4'b0101: out = 4'b1000;
            4'b0110: out = 4'b0101;
            4'b0111: out = 4'b1010;
            4'b1000: out = 4'b0011;
            4'b1001: out = 4'b1110;
            4'b1010: out = 4'b1001;
            4'b1011: out = 4'b0111;
            4'b1100: out = 4'b0110;
            4'b1101: out = 4'b1101;
            4'b1110: out = 4'b1011;
            4'b1111: out = 4'b1100;
            default: out = 4'b0000;
        endcase
    end
endmodule
