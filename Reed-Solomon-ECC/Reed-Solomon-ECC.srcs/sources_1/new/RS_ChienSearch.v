`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2021 02:45:18 PM
// Design Name: 
// Module Name: RS_ChienSearch
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

//Chien search to find location of errors
//Input is Lambda (make sure to pad with 0s if lambda is only 2 coefficients)
//Outputs are location of errors
module RS_ChienSearch(
    input [0:11] lambda,
    output [0:14] X
    );
    //these hold alpha^-14 through alpha^-0
    wire [0:11] n14;
    wire [0:11] n13;
    wire [0:11] n12;
    wire [0:11] n11;
    wire [0:11] n10;
    wire [0:11] n09;
    wire [0:11] n08;
    wire [0:11] n07;
    wire [0:11] n06;
    wire [0:11] n05;
    wire [0:11] n04;
    wire [0:11] n03;
    wire [0:11] n02;
    wire [0:11] n01;
    wire [0:11] n00;
    
    //these hold the value of evaluated lambda
    wire [0:3] val00;
    wire [0:3] val01;
    wire [0:3] val02;
    wire [0:3] val03;
    wire [0:3] val04;
    wire [0:3] val05;
    wire [0:3] val06;
    wire [0:3] val07;
    wire [0:3] val08;
    wire [0:3] val09;
    wire [0:3] val10;
    wire [0:3] val11;
    wire [0:3] val12;
    wire [0:3] val13;
    wire [0:3] val14;
    
    assign n14 = 12'h421;
    assign n13 = 12'h341;
    assign n12 = 12'hC81;
    assign n11 = 12'h531;
    assign n10 = 12'h761;
    assign n09 = 12'hFC1;
    assign n08 = 12'h9B1;
    assign n07 = 12'h251;
    assign n06 = 12'h8A1;
    assign n05 = 12'h671;
    assign n04 = 12'hBE1;
    assign n03 = 12'hAF1;
    assign n02 = 12'hED1;
    assign n01 = 12'hD91;
    assign n00 = 12'h111;
    
    GF_Poly_Evaluate3 deg14(lambda, n14, val14);
    GF_Poly_Evaluate3 deg13(lambda, n13, val13);
    GF_Poly_Evaluate3 deg12(lambda, n12, val12);
    GF_Poly_Evaluate3 deg11(lambda, n11, val11);
    GF_Poly_Evaluate3 deg10(lambda, n10, val10);
    GF_Poly_Evaluate3 deg09(lambda, n09, val09);
    GF_Poly_Evaluate3 deg08(lambda, n08, val08);
    GF_Poly_Evaluate3 deg07(lambda, n07, val07);
    GF_Poly_Evaluate3 deg06(lambda, n06, val06);
    GF_Poly_Evaluate3 deg05(lambda, n05, val05);
    GF_Poly_Evaluate3 deg04(lambda, n04, val04);
    GF_Poly_Evaluate3 deg03(lambda, n03, val03);
    GF_Poly_Evaluate3 deg02(lambda, n02, val02);  
    GF_Poly_Evaluate3 deg01(lambda, n01, val01);
    GF_Poly_Evaluate3 deg00(lambda, n00, val00);
    
    assign X[0] = !(val14[0] | val14[1] | val14[2] | val14[3]);
    assign X[1] = !(val13[0] | val13[1] | val13[2] | val13[3]);
    assign X[2] = !(val12[0] | val12[1] | val12[2] | val12[3]);
    assign X[3] = !(val11[0] | val11[1] | val11[2] | val11[3]);
    assign X[4] = !(val10[0] | val10[1] | val10[2] | val10[3]);
    assign X[5] = !(val09[0] | val09[1] | val09[2] | val09[3]);
    assign X[6] = !(val08[0] | val08[1] | val08[2] | val08[3]);
    assign X[7] = !(val07[0] | val07[1] | val07[2] | val07[3]);
    assign X[8] = !(val06[0] | val06[1] | val06[2] | val06[3]);
    assign X[9] = !(val05[0] | val05[1] | val05[2] | val05[3]);
    assign X[10] = !(val04[0] | val04[1] | val04[2] | val04[3]);
    assign X[11] = !(val03[0] | val03[1] | val03[2] | val03[3]);
    assign X[12] = !(val02[0] | val02[1] | val02[2] | val02[3]);
    assign X[13] = !(val01[0] | val01[1] | val01[2] | val01[3]);
    assign X[14] = !(val00[0] | val00[1] | val00[2] | val00[3]);
    
endmodule
