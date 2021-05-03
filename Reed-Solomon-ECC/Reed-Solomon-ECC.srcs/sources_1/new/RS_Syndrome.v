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
    Syndrome_Eval_P0 pe0(in,out[8:11]);
    Syndrome_Eval_P1 pe1(in,out[4:7]);
    Syndrome_Eval_P2 pe2(in,out[0:3]);
endmodule

module Syndrome_Eval_P0(
    input [0:59] coef,
    output [0:3] out
    );
    
    wire [0:3]m0;
    wire [0:3]m1;
    wire [0:3]m2;
    wire [0:3]m3;
    wire [0:3]m4;
    wire [0:3]m5;    
    wire [0:3]m6;
    wire [0:3]m7;
    wire [0:3]m8;
    wire [0:3]m9;
    wire [0:3]mA;
    wire [0:3]mB;
    wire [0:3]mC;
    wire [0:3]mD;
    //9DFE_7A5B_C638_421;
    GF_Multiply_9 mult0(coef[0:3],m0);
    GF_Multiply_D mult1(coef[4:7],m1);
    GF_Multiply_F mult2(coef[8:11],m2);
    GF_Multiply_E mult3(coef[12:15],m3);
    GF_Multiply_7 mult4(coef[16:19],m4);
    GF_Multiply_A mult5(coef[20:23],m5);
    GF_Multiply_5 mult6(coef[24:27],m6);
    GF_Multiply_B mult7(coef[28:31],m7);
    GF_Multiply_C mult8(coef[32:35],m8);
    GF_Multiply_6 mult9(coef[36:39],m9);
    GF_Multiply_3 multA(coef[40:43],mA);
    GF_Multiply_8 multB(coef[44:47],mB);
    GF_Multiply_4 multC(coef[48:51],mC);
    GF_Multiply_2 multD(coef[52:55],mD);
    
    assign out = m0 ^ m1 ^ m2 ^ m3 ^ m4 ^ m5 ^ m6 ^ m7 ^ m8 ^ m9 ^ mA ^ mB ^ mC ^ mD ^ coef[56:59];
endmodule

module Syndrome_Eval_P1(
    input [0:59] coef,
    output [0:3] out
    );
    
    wire [0:3]m0;
    wire [0:3]m1;
    wire [0:3]m2;
    wire [0:3]m3;
    wire [0:3]m4;
    wire [0:3]m5;    
    wire [0:3]m6;
    wire [0:3]m7;
    wire [0:3]m8;
    wire [0:3]m9;
    wire [0:3]mA;
    wire [0:3]mB;
    wire [0:3]mC;
    wire [0:3]mD;
    //DEAB_6829_F75C_341
    GF_Multiply_D mult0(coef[0:3],m0);
    GF_Multiply_E mult1(coef[4:7],m1);
    GF_Multiply_A mult2(coef[8:11],m2);
    GF_Multiply_B mult3(coef[12:15],m3);
    GF_Multiply_6 mult4(coef[16:19],m4);
    GF_Multiply_8 mult5(coef[20:23],m5);
    GF_Multiply_2 mult6(coef[24:27],m6);
    GF_Multiply_9 mult7(coef[28:31],m7);
    GF_Multiply_F mult8(coef[32:35],m8);
    GF_Multiply_7 mult9(coef[36:39],m9);
    GF_Multiply_5 multA(coef[40:43],mA);
    GF_Multiply_C multB(coef[44:47],mB);
    GF_Multiply_3 multC(coef[48:51],mC);
    GF_Multiply_4 multD(coef[52:55],mD);
    
    assign out = m0 ^ m1 ^ m2 ^ m3 ^ m4 ^ m5 ^ m6 ^ m7 ^ m8 ^ m9 ^ mA ^ mB ^ mC ^ mD ^ coef[56:59];
endmodule

module Syndrome_Eval_P2(
    input [0:59] coef,
    output [0:3] out
    );
    
    wire [0:3]m0;
    wire [0:3]m1;
    wire [0:3]m2;
    wire [0:3]m3;
    wire [0:3]m4;
    wire [0:3]m5;    
    wire [0:3]m6;
    wire [0:3]m7;
    wire [0:3]m8;
    wire [0:3]m9;
    wire [0:3]mA;
    wire [0:3]mB;
    wire [0:3]mC;
    wire [0:3]mD;
    //FAC8_1FAC_81FA_C81
    GF_Multiply_F mult0(coef[0:3],m0);
    GF_Multiply_A mult1(coef[4:7],m1);
    GF_Multiply_C mult2(coef[8:11],m2);
    GF_Multiply_8 mult3(coef[12:15],m3);
    GF_Multiply_1 mult4(coef[16:19],m4);
    GF_Multiply_F mult5(coef[20:23],m5);
    GF_Multiply_A mult6(coef[24:27],m6);
    GF_Multiply_C mult7(coef[28:31],m7);
    GF_Multiply_8 mult8(coef[32:35],m8);
    GF_Multiply_1 mult9(coef[36:39],m9);
    GF_Multiply_F multA(coef[40:43],mA);
    GF_Multiply_A multB(coef[44:47],mB);
    GF_Multiply_C multC(coef[48:51],mC);
    GF_Multiply_8 multD(coef[52:55],mD);
    
    assign out = m0 ^ m1 ^ m2 ^ m3 ^ m4 ^ m5 ^ m6 ^ m7 ^ m8 ^ m9 ^ mA ^ mB ^ mC ^ mD ^ coef[56:59];
endmodule