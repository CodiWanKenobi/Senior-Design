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
    reg [0:59] msg;
    
    wire [0:15] syndrome;
    wire [0:11] lambda;
    wire [0:7] omega;
    wire [0:14] X;
    wire [0:59] Y;
    
    RS_Syndrome    syn(msg, syndrome);
    RS_BM          bm(syndrome, lambda, omega); 
    RS_ChienSearch cs(lambda, X);
    RS_Forney      fa(lambda, omega, X, Y);
    
    initial begin
        msg = 60'h123456789AB33cc;
        #50
        $display("TC01");
        if(Y != 60'h000000000000000) $display("TC01: Y is Wrong");
        
        msg = 60'h123F56789AB33cc;
        #50
        $display("TC02");
        if(Y != 60'h000B00000000000) $display("TC02: Y is Wrong");
        
        msg = 60'h12345B789AB31cc;
        #50
        $display("TC03");
        if(Y != 60'h00000D000000200) $display("TC03: Y is Wrong");
        
        msg = 60'hda5FFa98630c809;
        #50
        $display("TC04");
        if(Y != 60'h000FE0000000000) $display("TC04: Y is Wrong");
        
        msg = 60'h5b0128d3ff08b32;
        #50
        $display("TC05");
        if(Y != 60'h009000000000000) $display("TC05: Y is Wrong");
    end    
endmodule
