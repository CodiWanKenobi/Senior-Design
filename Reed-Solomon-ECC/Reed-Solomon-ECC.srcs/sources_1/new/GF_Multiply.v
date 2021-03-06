`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2021 09:58:13 PM
// Design Name: 
// Module Name: GF_Multiply
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

module GF_Multiply(
    input [0:3] A,
    input [0:3] B,
    output reg [0:3] out
    );
    
    wire [0:7] combined;
    assign combined = (A << 4) | B;
    always @(*) begin    
        case(combined)
			8'b00010001: out = 4'b0001;
			8'b00010010: out = 4'b0010;
			8'b00010011: out = 4'b0011;
			8'b00010100: out = 4'b0100;
			8'b00010101: out = 4'b0101;
			8'b00010110: out = 4'b0110;
			8'b00010111: out = 4'b0111;
			8'b00011000: out = 4'b1000;
			8'b00011001: out = 4'b1001;
			8'b00011010: out = 4'b1010;
			8'b00011011: out = 4'b1011;
			8'b00011100: out = 4'b1100;
			8'b00011101: out = 4'b1101;
			8'b00011110: out = 4'b1110;
			8'b00011111: out = 4'b1111;
			8'b00100001: out = 4'b0010;
			8'b00100010: out = 4'b0100;
			8'b00100011: out = 4'b0110;
			8'b00100100: out = 4'b1000;
			8'b00100101: out = 4'b1010;
			8'b00100110: out = 4'b1100;
			8'b00100111: out = 4'b1110;
			8'b00101000: out = 4'b0011;
			8'b00101001: out = 4'b0001;
			8'b00101010: out = 4'b0111;
			8'b00101011: out = 4'b0101;
			8'b00101100: out = 4'b1011;
			8'b00101101: out = 4'b1001;
			8'b00101110: out = 4'b1111;
			8'b00101111: out = 4'b1101;
			8'b00110001: out = 4'b0011;
			8'b00110010: out = 4'b0110;
			8'b00110011: out = 4'b0101;
			8'b00110100: out = 4'b1100;
			8'b00110101: out = 4'b1111;
			8'b00110110: out = 4'b1010;
			8'b00110111: out = 4'b1001;
			8'b00111000: out = 4'b1011;
			8'b00111001: out = 4'b1000;
			8'b00111010: out = 4'b1101;
			8'b00111011: out = 4'b1110;
			8'b00111100: out = 4'b0111;
			8'b00111101: out = 4'b0100;
			8'b00111110: out = 4'b0001;
			8'b00111111: out = 4'b0010;
			8'b01000001: out = 4'b0100;
			8'b01000010: out = 4'b1000;
			8'b01000011: out = 4'b1100;
			8'b01000100: out = 4'b0011;
			8'b01000101: out = 4'b0111;
			8'b01000110: out = 4'b1011;
			8'b01000111: out = 4'b1111;
			8'b01001000: out = 4'b0110;
			8'b01001001: out = 4'b0010;
			8'b01001010: out = 4'b1110;
			8'b01001011: out = 4'b1010;
			8'b01001100: out = 4'b0101;
			8'b01001101: out = 4'b0001;
			8'b01001110: out = 4'b1101;
			8'b01001111: out = 4'b1001;
			8'b01010001: out = 4'b0101;
			8'b01010010: out = 4'b1010;
			8'b01010011: out = 4'b1111;
			8'b01010100: out = 4'b0111;
			8'b01010101: out = 4'b0010;
			8'b01010110: out = 4'b1101;
			8'b01010111: out = 4'b1000;
			8'b01011000: out = 4'b1110;
			8'b01011001: out = 4'b1011;
			8'b01011010: out = 4'b0100;
			8'b01011011: out = 4'b0001;
			8'b01011100: out = 4'b1001;
			8'b01011101: out = 4'b1100;
			8'b01011110: out = 4'b0011;
			8'b01011111: out = 4'b0110;
			8'b01100001: out = 4'b0110;
			8'b01100010: out = 4'b1100;
			8'b01100011: out = 4'b1010;
			8'b01100100: out = 4'b1011;
			8'b01100101: out = 4'b1101;
			8'b01100110: out = 4'b0111;
			8'b01100111: out = 4'b0001;
			8'b01101000: out = 4'b0101;
			8'b01101001: out = 4'b0011;
			8'b01101010: out = 4'b1001;
			8'b01101011: out = 4'b1111;
			8'b01101100: out = 4'b1110;
			8'b01101101: out = 4'b1000;
			8'b01101110: out = 4'b0010;
			8'b01101111: out = 4'b0100;
			8'b01110001: out = 4'b0111;
			8'b01110010: out = 4'b1110;
			8'b01110011: out = 4'b1001;
			8'b01110100: out = 4'b1111;
			8'b01110101: out = 4'b1000;
			8'b01110110: out = 4'b0001;
			8'b01110111: out = 4'b0110;
			8'b01111000: out = 4'b1101;
			8'b01111001: out = 4'b1010;
			8'b01111010: out = 4'b0011;
			8'b01111011: out = 4'b0100;
			8'b01111100: out = 4'b0010;
			8'b01111101: out = 4'b0101;
			8'b01111110: out = 4'b1100;
			8'b01111111: out = 4'b1011;
			8'b10000001: out = 4'b1000;
			8'b10000010: out = 4'b0011;
			8'b10000011: out = 4'b1011;
			8'b10000100: out = 4'b0110;
			8'b10000101: out = 4'b1110;
			8'b10000110: out = 4'b0101;
			8'b10000111: out = 4'b1101;
			8'b10001000: out = 4'b1100;
			8'b10001001: out = 4'b0100;
			8'b10001010: out = 4'b1111;
			8'b10001011: out = 4'b0111;
			8'b10001100: out = 4'b1010;
			8'b10001101: out = 4'b0010;
			8'b10001110: out = 4'b1001;
			8'b10001111: out = 4'b0001;
			8'b10010001: out = 4'b1001;
			8'b10010010: out = 4'b0001;
			8'b10010011: out = 4'b1000;
			8'b10010100: out = 4'b0010;
			8'b10010101: out = 4'b1011;
			8'b10010110: out = 4'b0011;
			8'b10010111: out = 4'b1010;
			8'b10011000: out = 4'b0100;
			8'b10011001: out = 4'b1101;
			8'b10011010: out = 4'b0101;
			8'b10011011: out = 4'b1100;
			8'b10011100: out = 4'b0110;
			8'b10011101: out = 4'b1111;
			8'b10011110: out = 4'b0111;
			8'b10011111: out = 4'b1110;
			8'b10100001: out = 4'b1010;
			8'b10100010: out = 4'b0111;
			8'b10100011: out = 4'b1101;
			8'b10100100: out = 4'b1110;
			8'b10100101: out = 4'b0100;
			8'b10100110: out = 4'b1001;
			8'b10100111: out = 4'b0011;
			8'b10101000: out = 4'b1111;
			8'b10101001: out = 4'b0101;
			8'b10101010: out = 4'b1000;
			8'b10101011: out = 4'b0010;
			8'b10101100: out = 4'b0001;
			8'b10101101: out = 4'b1011;
			8'b10101110: out = 4'b0110;
			8'b10101111: out = 4'b1100;
			8'b10110001: out = 4'b1011;
			8'b10110010: out = 4'b0101;
			8'b10110011: out = 4'b1110;
			8'b10110100: out = 4'b1010;
			8'b10110101: out = 4'b0001;
			8'b10110110: out = 4'b1111;
			8'b10110111: out = 4'b0100;
			8'b10111000: out = 4'b0111;
			8'b10111001: out = 4'b1100;
			8'b10111010: out = 4'b0010;
			8'b10111011: out = 4'b1001;
			8'b10111100: out = 4'b1101;
			8'b10111101: out = 4'b0110;
			8'b10111110: out = 4'b1000;
			8'b10111111: out = 4'b0011;
			8'b11000001: out = 4'b1100;
			8'b11000010: out = 4'b1011;
			8'b11000011: out = 4'b0111;
			8'b11000100: out = 4'b0101;
			8'b11000101: out = 4'b1001;
			8'b11000110: out = 4'b1110;
			8'b11000111: out = 4'b0010;
			8'b11001000: out = 4'b1010;
			8'b11001001: out = 4'b0110;
			8'b11001010: out = 4'b0001;
			8'b11001011: out = 4'b1101;
			8'b11001100: out = 4'b1111;
			8'b11001101: out = 4'b0011;
			8'b11001110: out = 4'b0100;
			8'b11001111: out = 4'b1000;
			8'b11010001: out = 4'b1101;
			8'b11010010: out = 4'b1001;
			8'b11010011: out = 4'b0100;
			8'b11010100: out = 4'b0001;
			8'b11010101: out = 4'b1100;
			8'b11010110: out = 4'b1000;
			8'b11010111: out = 4'b0101;
			8'b11011000: out = 4'b0010;
			8'b11011001: out = 4'b1111;
			8'b11011010: out = 4'b1011;
			8'b11011011: out = 4'b0110;
			8'b11011100: out = 4'b0011;
			8'b11011101: out = 4'b1110;
			8'b11011110: out = 4'b1010;
			8'b11011111: out = 4'b0111;
			8'b11100001: out = 4'b1110;
			8'b11100010: out = 4'b1111;
			8'b11100011: out = 4'b0001;
			8'b11100100: out = 4'b1101;
			8'b11100101: out = 4'b0011;
			8'b11100110: out = 4'b0010;
			8'b11100111: out = 4'b1100;
			8'b11101000: out = 4'b1001;
			8'b11101001: out = 4'b0111;
			8'b11101010: out = 4'b0110;
			8'b11101011: out = 4'b1000;
			8'b11101100: out = 4'b0100;
			8'b11101101: out = 4'b1010;
			8'b11101110: out = 4'b1011;
			8'b11101111: out = 4'b0101;
			8'b11110001: out = 4'b1111;
			8'b11110010: out = 4'b1101;
			8'b11110011: out = 4'b0010;
			8'b11110100: out = 4'b1001;
			8'b11110101: out = 4'b0110;
			8'b11110110: out = 4'b0100;
			8'b11110111: out = 4'b1011;
			8'b11111000: out = 4'b0001;
			8'b11111001: out = 4'b1110;
			8'b11111010: out = 4'b1100;
			8'b11111011: out = 4'b0011;
			8'b11111100: out = 4'b1000;
			8'b11111101: out = 4'b0111;
			8'b11111110: out = 4'b0101;
			8'b11111111: out = 4'b1010;
			
			default: out = 4'b0000;
        endcase   
	end
endmodule

module GF_Multiply_1(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b0001: out = 4'b0001;
			4'b0010: out = 4'b0010;
			4'b0011: out = 4'b0011;
			4'b0100: out = 4'b0100;
			4'b0101: out = 4'b0101;
			4'b0110: out = 4'b0110;
			4'b0111: out = 4'b0111;
			4'b1000: out = 4'b1000;
			4'b1001: out = 4'b1001;
			4'b1010: out = 4'b1010;
			4'b1011: out = 4'b1011;
			4'b1100: out = 4'b1100;
			4'b1101: out = 4'b1101;
			4'b1110: out = 4'b1110;
			4'b1111: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_2(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b1001: out = 4'b0001;
			4'b0001: out = 4'b0010;
			4'b1000: out = 4'b0011;
			4'b0010: out = 4'b0100;
			4'b1011: out = 4'b0101;
			4'b0011: out = 4'b0110;
			4'b1010: out = 4'b0111;
			4'b0100: out = 4'b1000;
			4'b1101: out = 4'b1001;
			4'b0101: out = 4'b1010;
			4'b1100: out = 4'b1011;
			4'b0110: out = 4'b1100;
			4'b1111: out = 4'b1101;
			4'b0111: out = 4'b1110;
			4'b1110: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_3(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b1110: out = 4'b0001;
			4'b1111: out = 4'b0010;
			4'b0001: out = 4'b0011;
			4'b1101: out = 4'b0100;
			4'b0011: out = 4'b0101;
			4'b0010: out = 4'b0110;
			4'b1100: out = 4'b0111;
			4'b1001: out = 4'b1000;
			4'b0111: out = 4'b1001;
			4'b0110: out = 4'b1010;
			4'b1000: out = 4'b1011;
			4'b0100: out = 4'b1100;
			4'b1010: out = 4'b1101;
			4'b1011: out = 4'b1110;
			4'b0101: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_4(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b1101: out = 4'b0001;
			4'b1001: out = 4'b0010;
			4'b0100: out = 4'b0011;
			4'b0001: out = 4'b0100;
			4'b1100: out = 4'b0101;
			4'b1000: out = 4'b0110;
			4'b0101: out = 4'b0111;
			4'b0010: out = 4'b1000;
			4'b1111: out = 4'b1001;
			4'b1011: out = 4'b1010;
			4'b0110: out = 4'b1011;
			4'b0011: out = 4'b1100;
			4'b1110: out = 4'b1101;
			4'b1010: out = 4'b1110;
			4'b0111: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_5(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b1011: out = 4'b0001;
			4'b0101: out = 4'b0010;
			4'b1110: out = 4'b0011;
			4'b1010: out = 4'b0100;
			4'b0001: out = 4'b0101;
			4'b1111: out = 4'b0110;
			4'b0100: out = 4'b0111;
			4'b0111: out = 4'b1000;
			4'b1100: out = 4'b1001;
			4'b0010: out = 4'b1010;
			4'b1001: out = 4'b1011;
			4'b1101: out = 4'b1100;
			4'b0110: out = 4'b1101;
			4'b1000: out = 4'b1110;
			4'b0011: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_6(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b0111: out = 4'b0001;
			4'b1110: out = 4'b0010;
			4'b1001: out = 4'b0011;
			4'b1111: out = 4'b0100;
			4'b1000: out = 4'b0101;
			4'b0001: out = 4'b0110;
			4'b0110: out = 4'b0111;
			4'b1101: out = 4'b1000;
			4'b1010: out = 4'b1001;
			4'b0011: out = 4'b1010;
			4'b0100: out = 4'b1011;
			4'b0010: out = 4'b1100;
			4'b0101: out = 4'b1101;
			4'b1100: out = 4'b1110;
			4'b1011: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_7(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b0110: out = 4'b0001;
			4'b1100: out = 4'b0010;
			4'b1010: out = 4'b0011;
			4'b1011: out = 4'b0100;
			4'b1101: out = 4'b0101;
			4'b0111: out = 4'b0110;
			4'b0001: out = 4'b0111;
			4'b0101: out = 4'b1000;
			4'b0011: out = 4'b1001;
			4'b1001: out = 4'b1010;
			4'b1111: out = 4'b1011;
			4'b1110: out = 4'b1100;
			4'b1000: out = 4'b1101;
			4'b0010: out = 4'b1110;
			4'b0100: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_8(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b1111: out = 4'b0001;
			4'b1101: out = 4'b0010;
			4'b0010: out = 4'b0011;
			4'b1001: out = 4'b0100;
			4'b0110: out = 4'b0101;
			4'b0100: out = 4'b0110;
			4'b1011: out = 4'b0111;
			4'b0001: out = 4'b1000;
			4'b1110: out = 4'b1001;
			4'b1100: out = 4'b1010;
			4'b0011: out = 4'b1011;
			4'b1000: out = 4'b1100;
			4'b0111: out = 4'b1101;
			4'b0101: out = 4'b1110;
			4'b1010: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_9(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b0010: out = 4'b0001;
			4'b0100: out = 4'b0010;
			4'b0110: out = 4'b0011;
			4'b1000: out = 4'b0100;
			4'b1010: out = 4'b0101;
			4'b1100: out = 4'b0110;
			4'b1110: out = 4'b0111;
			4'b0011: out = 4'b1000;
			4'b0001: out = 4'b1001;
			4'b0111: out = 4'b1010;
			4'b0101: out = 4'b1011;
			4'b1011: out = 4'b1100;
			4'b1001: out = 4'b1101;
			4'b1111: out = 4'b1110;
			4'b1101: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_A(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b1100: out = 4'b0001;
			4'b1011: out = 4'b0010;
			4'b0111: out = 4'b0011;
			4'b0101: out = 4'b0100;
			4'b1001: out = 4'b0101;
			4'b1110: out = 4'b0110;
			4'b0010: out = 4'b0111;
			4'b1010: out = 4'b1000;
			4'b0110: out = 4'b1001;
			4'b0001: out = 4'b1010;
			4'b1101: out = 4'b1011;
			4'b1111: out = 4'b1100;
			4'b0011: out = 4'b1101;
			4'b0100: out = 4'b1110;
			4'b1000: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_B(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b0101: out = 4'b0001;
			4'b1010: out = 4'b0010;
			4'b1111: out = 4'b0011;
			4'b0111: out = 4'b0100;
			4'b0010: out = 4'b0101;
			4'b1101: out = 4'b0110;
			4'b1000: out = 4'b0111;
			4'b1110: out = 4'b1000;
			4'b1011: out = 4'b1001;
			4'b0100: out = 4'b1010;
			4'b0001: out = 4'b1011;
			4'b1001: out = 4'b1100;
			4'b1100: out = 4'b1101;
			4'b0011: out = 4'b1110;
			4'b0110: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_C(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b1010: out = 4'b0001;
			4'b0111: out = 4'b0010;
			4'b1101: out = 4'b0011;
			4'b1110: out = 4'b0100;
			4'b0100: out = 4'b0101;
			4'b1001: out = 4'b0110;
			4'b0011: out = 4'b0111;
			4'b1111: out = 4'b1000;
			4'b0101: out = 4'b1001;
			4'b1000: out = 4'b1010;
			4'b0010: out = 4'b1011;
			4'b0001: out = 4'b1100;
			4'b1011: out = 4'b1101;
			4'b0110: out = 4'b1110;
			4'b1100: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_D(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b0100: out = 4'b0001;
			4'b1000: out = 4'b0010;
			4'b1100: out = 4'b0011;
			4'b0011: out = 4'b0100;
			4'b0111: out = 4'b0101;
			4'b1011: out = 4'b0110;
			4'b1111: out = 4'b0111;
			4'b0110: out = 4'b1000;
			4'b0010: out = 4'b1001;
			4'b1110: out = 4'b1010;
			4'b1010: out = 4'b1011;
			4'b0101: out = 4'b1100;
			4'b0001: out = 4'b1101;
			4'b1101: out = 4'b1110;
			4'b1001: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_E(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b0011: out = 4'b0001;
			4'b0110: out = 4'b0010;
			4'b0101: out = 4'b0011;
			4'b1100: out = 4'b0100;
			4'b1111: out = 4'b0101;
			4'b1010: out = 4'b0110;
			4'b1001: out = 4'b0111;
			4'b1011: out = 4'b1000;
			4'b1000: out = 4'b1001;
			4'b1101: out = 4'b1010;
			4'b1110: out = 4'b1011;
			4'b0111: out = 4'b1100;
			4'b0100: out = 4'b1101;
			4'b0001: out = 4'b1110;
			4'b0010: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule

module GF_Multiply_F(
	input [0:3] A,
	output reg [0:3] out
	);

	always @(*) begin
		case(A)
			4'b1000: out = 4'b0001;
			4'b0011: out = 4'b0010;
			4'b1011: out = 4'b0011;
			4'b0110: out = 4'b0100;
			4'b1110: out = 4'b0101;
			4'b0101: out = 4'b0110;
			4'b1101: out = 4'b0111;
			4'b1100: out = 4'b1000;
			4'b0100: out = 4'b1001;
			4'b1111: out = 4'b1010;
			4'b0111: out = 4'b1011;
			4'b1010: out = 4'b1100;
			4'b0010: out = 4'b1101;
			4'b1001: out = 4'b1110;
			4'b0001: out = 4'b1111;
			default: out = 4'b0000;
		endcase
	end
endmodule