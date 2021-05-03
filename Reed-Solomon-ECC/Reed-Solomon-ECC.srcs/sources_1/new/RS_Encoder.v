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
    
    Enc_Eval_P0 pe0 (in, s0);
    Enc_Eval_P1 pe1 (in, s1);
    Enc_Eval_P2 pe2 (in, s2);
    Enc_Eval_P3 pe3 (in, s3);
    
    assign out = {in, s3, s2, s1, s0};
endmodule

module Enc_Eval_P0(
    input [0:43] coef,
    output [0:3] out
    );
    //A53A_D3F3_68C
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
    GF_Multiply_A mult0(coef[0:3],m0);
    GF_Multiply_5 mult1(coef[4:7],m1);
    GF_Multiply_3 mult2(coef[8:11],m2);
    GF_Multiply_A mult3(coef[12:15],m3);
    GF_Multiply_D mult4(coef[16:19],m4);
    GF_Multiply_3 mult5(coef[20:23],m5);
    GF_Multiply_F mult6(coef[24:27],m6);
    GF_Multiply_3 mult7(coef[28:31],m7);
    GF_Multiply_6 mult8(coef[32:35],m8);
    GF_Multiply_8 mult9(coef[36:39],m9);
    GF_Multiply_C multA(coef[40:43],mA);
    
    assign out = m0 ^ m1 ^ m2 ^ m3 ^ m4 ^ m5 ^ m6 ^ m7 ^ m8 ^ m9 ^ mA;
endmodule

module Enc_Eval_P1(
    input [0:43] coef,
    output [0:3] out
    );
    //D775_82FB_131
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
    GF_Multiply_D mult0(coef[0:3],m0);
    GF_Multiply_7 mult1(coef[4:7],m1);
    GF_Multiply_7 mult2(coef[8:11],m2);
    GF_Multiply_5 mult3(coef[12:15],m3);
    GF_Multiply_8 mult4(coef[16:19],m4);
    GF_Multiply_2 mult5(coef[20:23],m5);
    GF_Multiply_F mult6(coef[24:27],m6);
    GF_Multiply_B mult7(coef[28:31],m7);
    GF_Multiply_1 mult8(coef[32:35],m8);
    GF_Multiply_3 mult9(coef[36:39],m9);
    GF_Multiply_1 multA(coef[40:43],mA);
    
    assign out = m0 ^ m1 ^ m2 ^ m3 ^ m4 ^ m5 ^ m6 ^ m7 ^ m8 ^ m9 ^ mA;
endmodule

module Enc_Eval_P2(
    input [0:43] coef,
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
    GF_Multiply_C mult0(coef[0:3],m0);
    GF_Multiply_B mult1(coef[4:7],m1);
    GF_Multiply_1 mult2(coef[8:11],m2);
    GF_Multiply_3 mult3(coef[12:15],m3);
    GF_Multiply_C mult4(coef[16:19],m4);
    GF_Multiply_B mult5(coef[20:23],m5);
    GF_Multiply_C mult6(coef[24:27],m6);
    GF_Multiply_5 mult7(coef[28:31],m7);
    GF_Multiply_B mult8(coef[32:35],m8);
    GF_Multiply_3 mult9(coef[36:39],m9);
    GF_Multiply_3 multA(coef[40:43],mA);
    
    assign out = m0 ^ m1 ^ m2 ^ m3 ^ m4 ^ m5 ^ m6 ^ m7 ^ m8 ^ m9 ^ mA;
endmodule

module Enc_Eval_P3(
    input [0:43] coef,
    output [0:3] out
    );

    //44'hA84D8BDCD9F
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
    GF_Multiply_A mult0(coef[0:3],m0);
    GF_Multiply_8 mult1(coef[4:7],m1);
    GF_Multiply_4 mult2(coef[8:11],m2);
    GF_Multiply_D mult3(coef[12:15],m3);
    GF_Multiply_8 mult4(coef[16:19],m4);
    GF_Multiply_B mult5(coef[20:23],m5);
    GF_Multiply_D mult6(coef[24:27],m6);
    GF_Multiply_C mult7(coef[28:31],m7);
    GF_Multiply_D mult8(coef[32:35],m8);
    GF_Multiply_9 mult9(coef[36:39],m9);
    GF_Multiply_F multA(coef[40:43],mA);
    
    assign out = m0 ^ m1 ^ m2 ^ m3 ^ m4 ^ m5 ^ m6 ^ m7 ^ m8 ^ m9 ^ mA;
endmodule