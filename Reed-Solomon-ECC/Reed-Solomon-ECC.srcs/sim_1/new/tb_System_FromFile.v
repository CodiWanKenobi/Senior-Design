`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2021 03:15:40 PM
// Design Name: 
// Module Name: tb_System_FromFile
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


module tb_System_FromFile();

    reg [0:43] in_data;
    reg [0:59] error_mask;
    wire [0:59] encoded_data;
    reg [0:59] modified_data;
    wire [0:43] out_data;
    
    RS_Encoder rse(in_data,encoded_data);
    RS_Decoder rsd(modified_data,out_data);
    
    integer outFile,inFile;

    initial begin
        outFile = $fopen("Output_Data.txt", "w"); //open file for outputting results to
        inFile = $fopen("RS_Input.txt", "r");
        
        while (! $feof(inFile)) begin           //run until reaching end of file
            $fscanf(inFile, "%h", in_data);  //read in a line of the text file
            $fscanf(inFile, "%h", error_mask);  //read in a line of the text file
//            $ferror(inFile,str);
//            $display("%s",str);
            #50
            modified_data = encoded_data ^ error_mask;
            #50;
            $fdisplay(outFile, "Input data: %h", in_data);   //write data 
            $fdisplay(outFile, "Encoded data: %h", encoded_data);   //write data 
            $fdisplay(outFile, "Error mask: %h", error_mask);   //write data 
            $fdisplay(outFile, "Corrected data: %h", out_data);   //write data 
            if(in_data == out_data) begin
                $fdisplay(outFile, "Success\n");   //write data 
            end else begin
                $fdisplay(outFile, "Failure\n");   //write data 
            end
            $fflush(outFile);
            #50;
        end
        
    end
endmodule
