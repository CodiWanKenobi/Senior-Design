`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2021 11:07:45 PM
// Design Name: 
// Module Name: GF_Inverse
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


module GF_Inverse(
    input [0:3] in,
    output [0:3] out
    );
    
    wire [0:3]logIn;
    GF_log_table log1(in, logIn);
    
    GF_exp_table exp1(~logIn,out); 
    
endmodule
