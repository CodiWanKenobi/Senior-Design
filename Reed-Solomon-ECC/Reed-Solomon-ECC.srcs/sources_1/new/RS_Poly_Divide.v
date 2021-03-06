`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2021 12:33:20 AM
// Design Name: 
// Module Name: RS_Poly_Divide
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

// Code generating polynomial: g(x) = x^4 + 15x^3 + 3x^2 + x + 12 -> {1,15,3,1,12}
`define genpoly0 4'h1
`define genpoly1 4'hF
`define genpoly2 4'h3
`define genpoly3 4'h1
`define genpoly4 4'hC

module RS_Poly_Divide_CGP(  // Returns A % Code Generating polynomial
    input [0:43] A,
    output [0:15] R
    );

    // i = 0
    wire [0:3] q00;
    wire [0:3] q01;
    wire [0:3] q02;
    wire [0:3] q03;
    polyDivideHelper pd0(A[0:3],A[4:7],A[8:11],A[12:15],A[16:19],q00,q01,q02,q03);

    
    // i = 1
    wire [0:3] q10;
    wire [0:3] q11;
    wire [0:3] q12;
    wire [0:3] q13;
    polyDivideHelper pd1(q00,q01,q02,q03,A[20:23],q10,q11,q12,q13);
    
    // i = 2
    wire [0:3] q20;
    wire [0:3] q21;
    wire [0:3] q22;
    wire [0:3] q23;
    polyDivideHelper pd2(q10,q11,q12,q13,A[24:27],q20,q21,q22,q23);
    
    // i = 3
    wire [0:3] q30;
    wire [0:3] q31;
    wire [0:3] q32;
    wire [0:3] q33;
    polyDivideHelper pd3(q20,q21,q22,q23,A[28:31],q30,q31,q32,q33);
    
    // i = 4
    wire [0:3] q40;
    wire [0:3] q41;
    wire [0:3] q42;
    wire [0:3] q43;
    polyDivideHelper pd4(q30,q31,q32,q33,A[32:35],q40,q41,q42,q43);
    
    // i = 5
    wire [0:3] q50;
    wire [0:3] q51;
    wire [0:3] q52;
    wire [0:3] q53;
    polyDivideHelper pd5(q40,q41,q42,q43,A[36:39],q50,q51,q52,q53);
    
    // i = 6
    wire [0:3] q60;
    wire [0:3] q61;
    wire [0:3] q62;
    wire [0:3] q63;
    polyDivideHelper pd6(q50,q51,q52,q53,A[40:43],q60,q61,q62,q63);
    
    // i = 7
    wire [0:3] q70;
    wire [0:3] q71;
    wire [0:3] q72;
    wire [0:3] q73;
    polyDivideHelper pd7(q60,q61,q62,q63,4'h0,q70,q71,q72,q73);
    
    // i = 8
    wire [0:3] q80;
    wire [0:3] q81;
    wire [0:3] q82;
    wire [0:3] q83;
    polyDivideHelper pd8(q70,q71,q72,q73,4'h0,q80,q81,q82,q83);
    
    // i = 9
    wire [0:3] q90;
    wire [0:3] q91;
    wire [0:3] q92;
    wire [0:3] q93;
    polyDivideHelper pd9(q80,q81,q82,q83,4'h0,q90,q91,q92,q93);
    
    // i = 10
    wire [0:3] qA0;
    wire [0:3] qA1;
    wire [0:3] qA2;
    wire [0:3] qA3;
    polyDivideHelper pdA(q90,q91,q92,q93,4'h0,qA0,qA1,qA2,qA3);
    
    
    assign R = {qA0, qA1, qA2, qA3};
    
endmodule

module polyDivideHelper(
    input [0:3] coef,
    input [0:3] sym0,
    input [0:3] sym1,
    input [0:3] sym2,
    input [0:3] sym3,
    output [0:3] out0,
    output [0:3] out1,
    output [0:3] out2,
    output [0:3] out3
    );
    // j = 1
    wire [0:3] prod10;
    GF_Multiply gfmult10(`genpoly1,coef,prod10);
    assign out0 = sym0 ^ prod10;

    // j = 2
    wire [0:3] prod11;
    GF_Multiply gfmult11(`genpoly2,coef,prod11);
    assign out1 = sym1 ^ prod11;
    
    // j = 3
//    wire [0:3] prod12;
//    GF_Multiply gfmult12(`genpoly3,coef,prod12);
    assign out2 = sym2 ^ coef;
    
    // j = 4
    wire [0:3] prod13;
    GF_Multiply gfmult13(`genpoly4,coef,prod13);
    assign out3 = sym3 ^ prod13;
endmodule
