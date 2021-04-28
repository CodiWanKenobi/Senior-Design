`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2021 01:51:36 PM
// Design Name: 
// Module Name: RS_Encoder
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


module RS_Encoder(
    input [0:43] in,
    output [0:59] out
    );
    
    // these values are determined from creating cauchy matrix with 
    // alpha = omega = [2^0, 2^1, 2^2, ..., 2^14]
    wire [0:43] p0, p1, p2, p3;
    wire [0:3] s0, s1, s2, s3;
    assign p0 = 44'hA53AD3F368C;
    assign p1 = 44'hD77582FB131;
    assign p2 = 44'hCB13CBC5B33;
    assign p3 = 44'hA84D8BDCD9F;
    
    GF_Poly_Evaluate11 pe0 (in, p0, s0);
    GF_Poly_Evaluate11 pe1 (in, p1, s1);
    GF_Poly_Evaluate11 pe2 (in, p2, s2);
    GF_Poly_Evaluate11 pe3 (in, p3, s3);
    
    assign out = {in, s3, s2, s1, s0};
    
endmodule