`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2021 11:07:45 PM
// Design Name: 
// Module Name: GF_Divide
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


module GF_Divide(
    input [0:3] A,
    input [0:3] B,
    output reg [0:3] out
    );
    
    wire [0:3]logA;
    wire [0:3]logB;
    GF_log_table log1(A[0:3], logA);
    GF_log_table log2(B[0:3], logB);
    
    reg [0:4]added;
    wire [0:3]product;
    
    always @ (*)
    begin
        added = logA + ~logB;   // ~logB = -logB
    end
    
    GF_exp_table exp1(added,product); 
    
    always @ (*)
    begin
        if(|A == 0 || |B == 0) 
            out = 4'h0;
        else
            out = product;
    end
endmodule
