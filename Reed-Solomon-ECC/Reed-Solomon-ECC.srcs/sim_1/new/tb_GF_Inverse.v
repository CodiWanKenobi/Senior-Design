`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2021 11:44:36 PM
// Design Name: 
// Module Name: tb_GF_Inverse
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


module tb_GF_Inverse();

    reg [0:3] in;
    
    wire [0:3] out;
    
    GF_Inverse uut(
        .in(in),
        .out(out)
    );
    
    initial begin
    
        in = 4'h0;
        #50;
        $display("TC00");
        if(out != 4'h0) $display ("Result is wrong.");
        
        in = 4'h1;
        #50;
        $display("TC01");
        if(out != 4'h1) $display ("Result is wrong.");
        
        in = 4'h2;
        #50;
        $display("TC02");
        if(out != 4'h9) $display ("Result is wrong.");
        
        in = 4'h3;
        #50;
        $display("TC03");
        if(out != 4'hE) $display ("Result is wrong.");
        
        in = 4'h4;
        #50;
        $display("TC04");
        if(out != 4'hD) $display ("Result is wrong.");
        
        in = 4'h5;
        #50;
        $display("TC05");
        if(out != 4'hB) $display ("Result is wrong.");
        
        in = 4'h6;
        #50;
        $display("TC06");
        if(out != 4'h7) $display ("Result is wrong.");
        
        in = 4'h7;
        #50;
        $display("TC07");
        if(out != 4'h6) $display ("Result is wrong.");
        
        in = 4'h8;
        #50;
        $display("TC08");
        if(out != 4'hF) $display ("Result is wrong.");
        
        in = 4'h9;
        #50;
        $display("TC09");
        if(out != 4'h2) $display ("Result is wrong.");
        
        in = 4'hA;
        #50;
        $display("TC10");
        if(out != 4'hC) $display ("Result is wrong.");
        
        in = 4'hB;
        #50;
        $display("TC11");
        if(out != 4'h5) $display ("Result is wrong.");
        
        in = 4'hC;
        #50;
        $display("TC12");
        if(out != 4'hA) $display ("Result is wrong.");
        
        in = 4'hD;
        #50;
        $display("TC13");
        if(out != 4'h4) $display ("Result is wrong.");
        
        in = 4'hE;
        #50;
        $display("TC14");
        if(out != 4'h3) $display ("Result is wrong.");
        
        in = 4'hF;
        #50;
        $display("TC15");
        if(out != 4'h8) $display ("Result is wrong.");
        
   end 
endmodule