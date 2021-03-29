`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UT
// Engineer: Zach Zipper
// 
// Create Date: 03/28/2021 02:47:59 PM
// Design Name: 
// Module Name: tb_RS_ForneyAlgo
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


module tb_RS_ForneyAlgo();
    reg [0:15] syndrome;
    reg [0:11] lambda;
    wire [0:14] X;
    wire [0:7] omega;
    wire [0:59] Y;
    
    RS_ChienSearch cs(lambda, X);
    RS_CalcOmega co(syndrome, lambda, omega);
    RS_ForneyAlgo fa(lambda, omega, X, Y);
    
    initial begin
        lambda = 12'hEE1;
        syndrome = 16'hC43F;
        #50
        $display("TC01");
        if(omega != 8'h6F) $display("TC01: Omega is Wrong");
        if(Y != 60'h00000D000000200) $display("TC01: Y is Wrong");
        
        /*
        Encoded: [0x5, 0xb, 0xa, 0xb, 0x6, 0xf, 0x0, 0xf, 0xc, 0x5, 0x7, 0x6, 0x4, 0x5, 0x0]
        Errors:  [0x5, 0xb, 0xa, 0x0, 0x6, 0xf, 0x1, 0xf, 0xc, 0x5, 0x7, 0x6, 0x4, 0x5, 0x0]
        */
        lambda = 12'h3B1;
        syndrome = 16'hDBDA;
        #50
        $display("TC02");
        if(omega != 8'hFA) $display("TC02: Omega is Wrong");
        if(Y != 60'h000B00100000000) $display("TC02: Y is Wrong");
        
        /*
        Encoded: [0xb, 0xa, 0x4, 0x5, 0xb, 0x0, 0x4, 0x1, 0x1, 0x1, 0x3, 0xe, 0x4, 0xc, 0xb]
        Errors:  [0xb, 0xa, 0x4, 0x5, 0xb, 0x0, 0x4, 0x1, 0xa, 0x1, 0x3, 0xe, 0x4, 0xc, 0xb]
        */
        lambda = 12'h0C1;
        syndrome = 16'h73DB;
        #50
        $display("TC03");
        if(omega != 8'h0B) $display("TC03: Omega is Wrong");
        if(Y != 60'h00000000B000000) $display("TC03: Y is Wrong");
        
        /*
        Encoded: [0xa, 0x5, 0x9, 0x5, 0x4, 0x7, 0xf, 0x0, 0x3, 0xf, 0xb, 0x4, 0xd, 0x3, 0x2]
        Errors:  [0xa, 0x5, 0x9, 0x5, 0x4, 0x7, 0xf, 0x0, 0x3, 0xf, 0xb, 0x4, 0xd, 0x3, 0xd]
        */
        lambda = 12'h011;
        syndrome = 16'hFFFF;
        #50
        $display("TC04");
        if(omega != 8'h0F) $display("TC04: Omega is Wrong");
        if(Y != 60'h00000000000000F) $display("TC04: Y is Wrong");
        
        /*
        Encoded: [0xa, 0xd, 0xb, 0xe, 0x9, 0x6, 0xf, 0x6, 0xe, 0x5, 0x3, 0xb, 0x3, 0x6, 0x2]
    Errors:  [0x5, 0xe, 0xb, 0xe, 0x9, 0x6, 0xf, 0x6, 0xe, 0x5, 0x3, 0xb, 0x3, 0x6, 0x2]
        */
        lambda = 12'hF41;
        syndrome = 16'h76AC;
        #50
        $display("TC05");
        if(omega != 8'hFC) $display("TC05: Omega is Wrong");
        if(Y != 60'hF30000000000000) $display("TC05: Y is Wrong");      
        
        
    end    
endmodule
