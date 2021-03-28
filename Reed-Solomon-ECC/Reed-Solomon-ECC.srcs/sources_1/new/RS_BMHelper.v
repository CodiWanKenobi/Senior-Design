`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT
// Engineer: Carter Milch
// 
// Create Date: 03/26/2021 01:57:11 PM
// Design Name: 
// Module Name: RS_BMHelper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Helper module for Berlekamp-Massey algorithm.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module RS_BMHelper(
    input [0:15] syndrome,
    output [0:11] lambda
    );
        
    reg error0, error1, error2, error3;
    
    reg [0:3] delta0;
    wire [0:3] delta0_inv,
               delta1, delta1_inv, mult1_out,
               delta2, delta2_inv, mult2_out,
               delta3, mult3_out0, mult3_out1;
    
    reg [0:7]  lambda0;           
    wire [0:7] lambda1;
    wire [0:11] lambda2, lambda3;
    wire [0:7] cx0;    
    wire [0:7] cx0_scaled, cx0_invScaled, lambda_star0,
               cx1, cx1_scaled, cx1_invScaled, lambda_star1;
    wire [0:11] cx2, cx2_scaled, cx2_invScaled, lambda_star2;
    wire [0:11] cx3, cx3_scaled, lambda_star3;
        
    assign cx0 = 8'h10;
    GF_Inverse inv0(delta0, delta0_inv);
    GF_PolyScale #(8) scale_cx0(cx0, delta0, cx0_scaled);
    GF_PolyAdd   #(8) add_lStar0(lambda0, cx0_scaled, lambda_star0);
    GF_PolyScale #(8) scale_cx0_inv(lambda0, delta0_inv, cx0_invScaled);
    
    assign lambda1 = error0 ? lambda_star0 : 8'h01;
    assign cx1 = error0 ? {cx0_invScaled[4:7], 4'h0} : cx0;
    assign delta1 = syndrome[8:11] ^ (error0 ? mult1_out : 4'h0);
    GF_Inverse inv1(delta1, delta1_inv);
    GF_Multiply mult1(lambda1[0:3], syndrome[12:15], mult1_out);
    GF_PolyScale #(8) scale_cx1(cx1, delta1, cx1_scaled);
    GF_PolyAdd   #(8) add_lStar1(lambda1, cx1_scaled, lambda_star1);
    GF_PolyScale #(8) scale_cx1_inv(lambda1, delta1_inv, cx1_invScaled);
    
    assign lambda2 = delta1 ? lambda_star1 : 
                     error0 ? lambda_star0 : lambda0;
    assign cx2 = error1 ? {cx1_invScaled, 4'h0} :
                 error0 ? {cx0_invScaled[4:7], 8'h0} : {cx0, 4'h0};
    assign delta2 = syndrome[4:7] ^ ((error0 | error1) ? mult2_out : 4'h0);
    GF_Inverse inv2(delta2, delta2_inv);
    GF_Multiply mult2(lambda2[4:7], syndrome[8:11], mult2_out);
    GF_PolyScale #(12) scale_cx2(cx2, delta2, cx2_scaled);
    GF_PolyAdd   #(12) add_lStar2(lambda2, cx2_scaled, lambda_star2);
    GF_PolyScale #(12) scale_cx2_inv(lambda2, delta2_inv, cx2_invScaled);
    
    assign lambda3 = delta2 ? lambda_star2 :
                     error1 ? {4'h0, lambda_star1} :
                     error0 ? {4'h0, lambda_star0} : {4'h0, lambda0};
    assign cx3 = error2 ? {cx2_invScaled[3:11], 4'h0} :
                 error1 ? {cx1_invScaled[4:7], 8'h0} : 
                 error0 ? {cx0_invScaled[4:7], 8'h0} : {cx0, 4'h0};
    assign delta3 = syndrome[0:3] ^ (error0 & error2 ? (mult3_out0 ^ mult3_out1) :
                                    (error0 | error2 ? mult3_out0 : 4'h0));
    GF_Multiply mult3_0(lambda3[4:7], syndrome[4:7], mult3_out0);
    GF_Multiply mult3_1(lambda3[0:3], syndrome[8:11], mult3_out1);
    GF_PolyScale #(16) scale_cx3(cx3, delta3, cx3_scaled);
    GF_PolyAdd   #(16) add_lStar3(lambda3, cx3_scaled, lambda_star3);
    
    always @(syndrome) begin
        delta0 = syndrome[12:15];
        lambda0 = 8'h01;
        if (delta0 != 0) begin
            error0 = 1'b1;
        end
        else begin
            error0 = 1'b0;
        end
    end
    
    always @(lambda1) begin
        if (delta1 != 0) begin
            if (error0 == 0) begin
                error1 = 1'b1;
            end
            
        end
        else begin
            error1 = 1'b0;
        end
    end    
    
    always @(lambda2) begin
        if (delta2) begin
            if (~error1) begin
                error2 = 1'b1;
            end
        end
        else begin
            error2 = 1'b0;
        end
    end
    
    assign lambda = delta3 ? lambda_star3 : lambda3;
endmodule