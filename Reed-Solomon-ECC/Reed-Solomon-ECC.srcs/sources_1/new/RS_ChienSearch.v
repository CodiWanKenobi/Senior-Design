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

    wire [0:3]n14_m0;
    wire [0:3]n14_m1;
    GF_Multiply_4 mult14_0(lambda[0:3],n14_m0);
    GF_Multiply_2 mult14_1(lambda[4:7],n14_m1);
    assign val14 = n14_m0 ^ n14_m1 ^ lambda[8:11];
    

    wire [0:3]n13_m0;
    wire [0:3]n13_m1;
    GF_Multiply_3 mult13_0(lambda[0:3],n13_m0);
    GF_Multiply_4 mult13_1(lambda[4:7],n13_m1);
    assign val13 = n13_m0 ^ n13_m1 ^ lambda[8:11];
    
    wire [0:3]n12_m0;
    wire [0:3]n12_m1;
    GF_Multiply_C mult12_0(lambda[0:3],n12_m0);
    GF_Multiply_8 mult12_1(lambda[4:7],n12_m1);
    assign val12 = n12_m0 ^ n12_m1 ^ lambda[8:11];
        
    wire [0:3]n11_m0;
    wire [0:3]n11_m1;
    GF_Multiply_5 mult11_0(lambda[0:3],n11_m0);
    GF_Multiply_3 mult11_1(lambda[4:7],n11_m1);
    assign val11 = n11_m0 ^ n11_m1 ^ lambda[8:11];
    
    wire [0:3]n10_m0;
    wire [0:3]n10_m1;
    GF_Multiply_7 mult10_0(lambda[0:3],n10_m0);
    GF_Multiply_6 mult10_1(lambda[4:7],n10_m1);
    assign val10 = n10_m0 ^ n10_m1 ^ lambda[8:11];
    
    wire [0:3]n09_m0;
    wire [0:3]n09_m1;
    GF_Multiply_F mult09_0(lambda[0:3],n09_m0);
    GF_Multiply_C mult09_1(lambda[4:7],n09_m1);
    assign val09 = n09_m0 ^ n09_m1 ^ lambda[8:11];
    
    wire [0:3]n08_m0;
    wire [0:3]n08_m1;
    GF_Multiply_9 mult08_0(lambda[0:3],n08_m0);
    GF_Multiply_B mult08_1(lambda[4:7],n08_m1);
    assign val08 = n08_m0 ^ n08_m1 ^ lambda[8:11];
    
    wire [0:3]n07_m0;
    wire [0:3]n07_m1;
    GF_Multiply_2 mult07_0(lambda[0:3],n07_m0);
    GF_Multiply_5 mult07_1(lambda[4:7],n07_m1);
    assign val07 = n07_m0 ^ n07_m1 ^ lambda[8:11];
    
    wire [0:3]n06_m0;
    wire [0:3]n06_m1;
    GF_Multiply_8 mult06_0(lambda[0:3],n06_m0);
    GF_Multiply_A mult06_1(lambda[4:7],n06_m1);
    assign val06 = n06_m0 ^ n06_m1 ^ lambda[8:11];
    
    wire [0:3]n05_m0;
    wire [0:3]n05_m1;
    GF_Multiply_6 mult05_0(lambda[0:3],n05_m0);
    GF_Multiply_7 mult05_1(lambda[4:7],n05_m1);
    assign val05 = n05_m0 ^ n05_m1 ^ lambda[8:11];
    
    wire [0:3]n04_m0;
    wire [0:3]n04_m1;
    GF_Multiply_B mult04_0(lambda[0:3],n04_m0);
    GF_Multiply_E mult04_1(lambda[4:7],n04_m1);
    assign val04 = n04_m0 ^ n04_m1 ^ lambda[8:11];
    
    wire [0:3]n03_m0;
    wire [0:3]n03_m1;
    GF_Multiply_A mult03_0(lambda[0:3],n03_m0);
    GF_Multiply_F mult03_1(lambda[4:7],n03_m1);
    assign val03 = n03_m0 ^ n03_m1 ^ lambda[8:11];
        
    wire [0:3]n02_m0;
    wire [0:3]n02_m1;
    GF_Multiply_E mult02_0(lambda[0:3],n02_m0);
    GF_Multiply_D mult02_1(lambda[4:7],n02_m1);
    assign val02 = n02_m0 ^ n02_m1 ^ lambda[8:11];

    wire [0:3]n01_m0;
    wire [0:3]n01_m1;
    GF_Multiply_D mult01_0(lambda[0:3],n01_m0);
    GF_Multiply_9 mult01_1(lambda[4:7],n01_m1);
    assign val01 = n01_m0 ^ n01_m1 ^ lambda[8:11];
    
    assign val00 = lambda[0:3] ^ lambda[4:7] ^ lambda[8:11];
    
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
