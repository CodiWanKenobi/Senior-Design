`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2021 11:10:19 AM
// Design Name: 
// Module Name: GF_Poly_Evaluate
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

//Evalute a polynomial with 2 coefficients
//And last coefficient is a 1
module GF_Poly_Evaluate2(
    input [0:7] coef,
    input [0:7] values,
    output [0:3] out
    );
    
    wire [0:3]m0;
    GF_Multiply mult0(coef[0:3],values[0:3],m0);
    assign out = m0 ^ coef[4:7];    

endmodule

//Evaluate a polynomial with 3 coefficients
//And last coefficient is a 1
module GF_Poly_Evaluate3(
    input [0:11] coef,
    input [0:11] values,
    output [0:3] out
    );
    
    wire [0:3]m0;
    GF_Multiply mult0(coef[0:3],values[0:3],m0);
    wire [0:3]m1;
    GF_Multiply mult1(coef[4:7],values[4:7],m1);
    assign out = m0 ^ m1 ^ coef[8:11];    

endmodule

//Evaluates Polynomial with 11 coefficients
module GF_Poly_Evaluate11(
    input [0:43] coef,
    input [0:43] values,
    output [0:3] out
    );
    
    wire [0:3]m0;
    GF_Multiply mult0(coef[0:3],values[0:3],m0);
    wire [0:3]m1;
    GF_Multiply mult1(coef[4:7],values[4:7],m1);
    wire [0:3]m2;
    GF_Multiply mult2(coef[8:11],values[8:11],m2);
    wire [0:3]m3;
    GF_Multiply mult3(coef[12:15],values[12:15],m3);
    wire [0:3]m4;
    GF_Multiply mult4(coef[16:19],values[16:19],m4);
    wire [0:3]m5;
    GF_Multiply mult5(coef[20:23],values[20:23],m5);
    wire [0:3]m6;
    GF_Multiply mult6(coef[24:27],values[24:27],m6);
    wire [0:3]m7;
    GF_Multiply mult7(coef[28:31],values[28:31],m7);
    wire [0:3]m8;
    GF_Multiply mult8(coef[32:35],values[32:35],m8);
    wire [0:3]m9;
    GF_Multiply mult9(coef[36:39],values[36:39],m9);
    wire [0:3]mA;
    GF_Multiply multA(coef[40:43],values[40:43],mA);
    
    
    assign out = m0 ^ m1 ^ m2 ^ m3 ^ m4 ^ m5 ^ m6 ^ m7 ^ m8 ^ m9 ^ mA;
    
endmodule
//Evaluates Polynomial with 15 coefficients
//And last coefficient is a 1
module GF_Poly_Evaluate(
    input [0:59] coef,
    input [0:59] values,
    output [0:3] out
    );
    
    wire [0:3]m0;
    GF_Multiply mult0(coef[0:3],values[0:3],m0);
    wire [0:3]m1;
    GF_Multiply mult1(coef[4:7],values[4:7],m1);
    wire [0:3]m2;
    GF_Multiply mult2(coef[8:11],values[8:11],m2);
    wire [0:3]m3;
    GF_Multiply mult3(coef[12:15],values[12:15],m3);
    wire [0:3]m4;
    GF_Multiply mult4(coef[16:19],values[16:19],m4);
    wire [0:3]m5;
    GF_Multiply mult5(coef[20:23],values[20:23],m5);
    wire [0:3]m6;
    GF_Multiply mult6(coef[24:27],values[24:27],m6);
    wire [0:3]m7;
    GF_Multiply mult7(coef[28:31],values[28:31],m7);
    wire [0:3]m8;
    GF_Multiply mult8(coef[32:35],values[32:35],m8);
    wire [0:3]m9;
    GF_Multiply mult9(coef[36:39],values[36:39],m9);
    wire [0:3]mA;
    GF_Multiply multA(coef[40:43],values[40:43],mA);
    wire [0:3]mB;
    GF_Multiply multB(coef[44:47],values[44:47],mB);
    wire [0:3]mC;
    GF_Multiply multC(coef[48:51],values[48:51],mC);
    wire [0:3]mD;
    GF_Multiply multD(coef[52:55],values[52:55],mD);
    
    assign out = m0 ^ m1 ^ m2 ^ m3 ^ m4 ^ m5 ^ m6 ^ m7 ^ m8 ^ m9 ^ mA ^ mB ^ mC ^ mD ^ coef[56:59];
    
endmodule
