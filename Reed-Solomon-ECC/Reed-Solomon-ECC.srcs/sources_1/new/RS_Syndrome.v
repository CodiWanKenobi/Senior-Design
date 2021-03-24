`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2021 11:20:44 AM
// Design Name: 
// Module Name: RS_Syndrome
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


module RS_Syndrome(
    input [0:59] in,
    output [0:15] out
    );
    
    // Doesn't make sense to calculate (alpha^i)^j at execution time because we know alpha, i and j beforehand
    wire [0:59]cS1;
    wire [0:59]cS2;
    wire [0:59]cS3;

    assign cS1 = 60'h9DFE7A5BC638421;
    assign cS2 = 60'hDEAB6829F75C341;
    assign cS3 = 60'hFAC81FAC81FAC81;

    assign out[12:15] = in[0:3] ^ in[4:7] ^ in[8:11] ^ in[12:15] ^ in[16:19] ^ in[20:23] ^ in[24:27] ^ in[28:31] ^ in[32:35] ^ in[36:39] ^ in[40:43] ^ in[44:47] ^ in[48:51] ^ in[52:55] ^ in[56:59];
    GF_Poly_Evaluate pe1(in,cS1,out[8:11]);
    GF_Poly_Evaluate pe2(in,cS2,out[4:7]);
    GF_Poly_Evaluate pe3(in,cS3,out[0:3]);

    
endmodule
