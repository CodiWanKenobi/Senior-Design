`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2021 07:29:41 PM
// Design Name: 
// Module Name: GF_Multiply
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


module GF_Multiply(
    input [0:3] A,
    input [0:3] B,
    output [0:3] out
    );
   
    wire [0:3]logA;
    wire [0:3]logB;
    GF_log_table log1(A[0:3], logA);
    GF_log_table log2(B[0:3], logB);
    
    wire [0:4] added;
    wire [0:3] product;
    
    assign added = logA + logB;
    
    GF_exp_table exp1(added,product);
    
    assign out = product & {4{(|A) & (|B)}};
endmodule
