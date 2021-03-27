`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2021 03:36:14 PM
// Design Name: 
// Module Name: tb_RS_ChienSearch
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


module tb_RS_ChienSearch();
    reg [0:11] lambda;
    wire [0:14] X;
    //wire [0:59] val;
    
    RS_ChienSearch cs(lambda, X);
    initial begin
        lambda = 12'hEE1;
        #50;
        $display("TC01");
        if(X != 15'b001000000100000) $display ("Result is wrong.");
        
        lambda = 12'h511;
        #50;
        $display("TC02");
        if(X != 15'b000000000001100) $display ("Result is wrong.");
        
        lambda = 12'h091;
        #50;
        $display("TC03");
        if(X != 15'b000000000000001) $display ("Result is wrong.");
        
        lambda = 12'h051;
        #50;
        $display("TC04");
        if(X != 15'b000000001000000) $display ("Result is wrong.");
        
        lambda = 12'h111;
        #50;
        $display("TC05");
        if(X != 15'b000001000010000) $display ("Result is wrong.");
        
    end    
endmodule
