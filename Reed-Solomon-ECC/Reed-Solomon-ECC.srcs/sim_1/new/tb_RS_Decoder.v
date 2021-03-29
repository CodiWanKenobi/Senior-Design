`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2021 11:56:21 AM
// Design Name: 
// Module Name: tb_RS_Decoder
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


module tb_RS_Decoder();

    reg [0:59] msg_in;
    wire [0:43] msg_out;
    
    RS_Decoder decode(msg_in, msg_out);
    
    initial begin
        msg_in = 60'h123456789AB33cc;
        #50
        $display("TC01: No errors");
        if (msg_out != 44'h123456789AB) $display("Result is wrong");
        
        msg_in = 60'h123F56789AB33cc;
        #50
        $display("TC02: 1 error");
        if (msg_out != 44'h123456789AB) $display("Result is wrong");
        
        msg_in = 60'h12345B789AB31cc;
        #50
        $display("TC03: 2 errors");
        if (msg_out != 44'h123456789AB) $display("Result is wrong");
        
        msg_in = 60'hda5FFa98630c809;
        #50
        $display("TC04: 2 errors");
        if(msg_out != 44'hda501a98630) $display ("Result is wrong.");
        
        msg_in = 60'h5b0128d3ff08b32;
        #50
        $display("TC05: 1 error");
        if(msg_out != 44'h5b9128d3ff0) $display ("Result is wrong.");
        
    end

endmodule
