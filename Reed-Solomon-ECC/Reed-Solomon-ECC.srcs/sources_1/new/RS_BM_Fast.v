`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2021 03:21:57 PM
// Design Name: 
// Module Name: RS_BM_Fast
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


module RS_BM_Fast(
    input [0:15] syndrome,
    output [0:11] lambda4,
    output [0:7] omegaH
    );
    wire check0, check1, check2;
    wire [0:11] lambda0, lambda1, lambda2, lambda3, b0, b1, b2, b3, ls0, ls1,
    ls2, ls3, bs0, bs1, bs2, bs3;
    wire [0:15] delta0, delta1, delta2, delta3, delta4, theta0, theta1, theta2,
    theta3, ds0, ds1, ds2, ds3, ts0, ts1, ts2, ts3;
    wire [0:3] gamma0, gamma1, gamma2, gamma3;
    wire signed [15:0] k1, k2;
    
    //Init
    assign lambda0 = 12'h001;
    assign b0 = 12'h001;
    assign gamma0 = 4'h1;
    assign delta0 = syndrome;
    assign theta0 = syndrome;
    
    //Step 0.1
    GF_PolyScale #(12) scale_ls0 (lambda0, gamma0, ls0);
    GF_PolyScale #(12) scale_bs0 (b0 << 4, delta0[12:15], bs0); 
    GF_PolyAdd #(12) padd_l1 (ls0, bs0, lambda1);
    
    GF_PolyScale #(16) scale_ds0 (delta0 >> 4, gamma0, ds0);
    GF_PolyScale #(16) scale_ts0 (theta0, delta0[12:15], ts0); 
    GF_PolyAdd #(16) padd_d1 (ds0, ts0, delta1);
    
    //Step 0.2
    // check = delta[12:15] != 0 && k >= 0
    assign check0 = delta0[12] | delta0[13] | delta0[14] | delta0[15];
    assign b1 = check0 ? lambda0 : b0 << 4;
    assign theta1 = check0 ? delta0 >> 4 : theta0;
    assign gamma1 = check0 ? delta0[12:15] : gamma0;
    assign k1 = check0 ? -1 : 1;
    
    //Step 1.1
    GF_PolyScale #(12) scale_ls1 (lambda1, gamma1, ls1);
    GF_PolyScale #(12) scale_bs1 (b1 << 4, delta1[12:15], bs1); 
    GF_PolyAdd #(12) padd_l2 (ls1, bs1, lambda2);
    
    GF_PolyScale #(16) scale_ds1 (delta1 >> 4, gamma1, ds1);
    GF_PolyScale #(16) scale_ts1 (theta1, delta1[12:15], ts1); 
    GF_PolyAdd #(16) padd_d2 (ds1, ts1, delta2);
    
    //Step 1.2
    assign check1 = delta1[12] | delta1[13] | delta1[14] | delta1[15] & !k1[15];
    assign b2 = check1 ? lambda1 : b1 << 4;
    assign theta2 = check1 ? delta1 >> 4 : theta1;
    assign gamma2 = check1 ? delta1[12:15] : gamma1;
    assign k2 = check1 ? -k1 - 1 : k1 + 1;
    
    //Step 2.1
    GF_PolyScale #(12) scale_ls2 (lambda2, gamma2, ls2);
    GF_PolyScale #(12) scale_bs2 (b2 << 4, delta2[12:15], bs2); 
    GF_PolyAdd #(12) padd_l3 (ls2, bs2, lambda3);
    
    GF_PolyScale #(16) scale_ds2 (delta2 >> 4, gamma2, ds2);
    GF_PolyScale #(16) scale_ts2 (theta2, delta2[12:15], ts2); 
    GF_PolyAdd #(16) padd_d3 (ds2, ts2, delta3);
    
    //Step 2.2
    assign check2 = delta2[12] | delta2[13] | delta2[14] | delta2[15] & !k2[15];
    assign b3 = check2 ? lambda2 : b2 << 4;
    assign theta3 = check2 ? delta2 >> 4 : theta2;
    assign gamma3 = check2 ? delta2[12:15] : gamma2;
    
    //Step 3.1
    GF_PolyScale #(12) scale_ls3 (lambda3, gamma3, ls3);
    GF_PolyScale #(12) scale_bs3 (b3 << 4, delta3[12:15], bs3); 
    GF_PolyAdd #(12) padd_l4 (ls3, bs3, lambda4);
    
    GF_PolyScale #(16) scale_ds3 (delta3 >> 4, gamma3, ds3);
    GF_PolyScale #(16) scale_ts3 (theta3, delta3[12:15], ts3); 
    GF_PolyAdd #(16) padd_d4 (ds3, ts3, delta4);
    
    assign omegaH = delta4[8:15];
    
    //Step 2.2
    
    
    
endmodule
