`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2021 09:58:13 PM
// Design Name: 
// Module Name: GF_NewMultiply
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


module GF_NewMultiply(
    input [0:3] A,
    input [0:3] B,
    output [0:3] out
    );
    
    wire [0:3] shift;
    wire [0:17] buffer;
    GF_log_table exp(B, shift);
    assign buffer = (A << shift) | (18'b000000000000000000);
    assign out = ({4{buffer[0]}} & 4'h4) ^ ({4{buffer[1]}} & 4'h2) ^ ({4{buffer[2]}} & 4'h1) ^
    ({4{buffer[3]}} & 4'h9) ^ ({4{buffer[4]}} & 4'hD) ^ ({4{buffer[5]}} & 4'hF) ^ 
    ({4{buffer[6]}} & 4'hE) ^ ({4{buffer[7]}} & 4'h7) ^ ({4{buffer[8]}} & 4'hA) ^
    ({4{buffer[9]}} & 4'h5) ^ ({4{buffer[10]}} & 4'hB) ^ ({4{buffer[11]}} & 4'hC) ^
    ({4{buffer[12]}} & 4'h6) ^ ({4{buffer[13]}} & 4'h3) ^ (buffer[14:17]) & ({4{|B}});
    
endmodule
