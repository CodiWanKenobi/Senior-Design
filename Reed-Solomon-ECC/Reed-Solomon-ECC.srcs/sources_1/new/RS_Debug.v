`timescale 1ns / 1ps

// "Unrolled" Reed-Solomon module with additional I/O for configurable testbench.
// See tb_System_FromFile.v for more information.

module RS_Debug(
    input [1:0]  test_mode,
    input [0:43] msg_in,
    input [0:59] encoded_in,
    input [0:59] error_mask,
    
    output [0:59] encoded_data,
    output [0:43] decoded_msg,
    output [0:15] syndrome_out,
    output valid 
    );
    
    localparam
        TEST_FULL     = 0,
        TEST_DECODE   = 1,
        TEST_SYNDROME = 2;
    
    wire [0:59] enc_out;
    wire [0:59] Y;
    wire [0:59] buffer;
    wire [0:59] orig_msg;
    wire [0:15] check_syndrome;
    wire [0:14] X;
    wire [0:11] lambda;
    wire [0:7]  omega;
        
    // Encode stage
    RS_Encoder  enc(msg_in, enc_out);
    assign encoded_data = |test_mode ? encoded_in : enc_out ^ error_mask;
    
    // Decode stage
    RS_Syndrome    syn(encoded_data, syndrome_out);
    RS_BM          bm(syndrome_out, lambda, omega);
    RS_ChienSearch chien(lambda, X);
    RS_Forney      forney(lambda, omega, X, Y);
    
    GF_PolyAdd #(60) padd(encoded_data, Y, buffer);
    
    RS_Syndrome check(buffer, check_syndrome);
    
    assign orig_msg = (|test_mode) ? encoded_in : msg_in;
    assign decoded_msg = (|syndrome_out) ? orig_msg[0:43] : buffer[0:43];
    assign valid = (|syndrome_out) ? ~(|check_syndrome) : 1'b1;
endmodule
