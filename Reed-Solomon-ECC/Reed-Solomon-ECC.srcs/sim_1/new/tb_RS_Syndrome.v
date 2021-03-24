`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2021 12:13:23 PM
// Design Name: 
// Module Name: tb_RS_Syndrome
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


module tb_RS_Syndrome();

    reg [0:59] A;
    wire [0:15] out;
    
    RS_Syndrome syn(A,out);
    
    initial begin
        A = 60'h123456789AB33cc;
        #50;
        $display("TC01");
        if(out != 16'h0000) $display ("Result is wrong.");
        
        A = 60'h12345b789ab31cc;
        #50;
        $display("TC02");
        if(out != 16'hC43F) $display ("Result is wrong.");
        
        A = 60'hba987654321c581;
        #50;
        $display("TC03");
        if(out != 16'h0000) $display ("Result is wrong.");
        
        A = 60'hba987b54321c181;
        #50;
        $display("TC04");
        if(out != 16'h2E89) $display ("Result is wrong.");
        
        A = 60'hda501a98630c809;
        #50;
        $display("TC05");
        if(out != 16'h0000) $display ("Result is wrong.");
        
        A = 60'hda501b98630c109;
        #50;
        $display("TC06");
        if(out != 16'h9088) $display ("Result is wrong.");
        
        A = 60'h5b9128d3ff08b32;
        #50;
        $display("TC07");
        if(out != 16'h0000) $display ("Result is wrong.");
        
        A = 60'h5b912bd3ff08132;
        #50;
        $display("TC08");
        if(out != 16'h3639) $display ("Result is wrong.");
    
    end
endmodule
