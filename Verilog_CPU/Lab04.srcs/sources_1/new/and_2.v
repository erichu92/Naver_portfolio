`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 15:17:28
// Design Name: 
// Module Name: and_2
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

`define WORD_SIZE 16

module and_16_2(
    A, B, C
    );
    
    input [`WORD_SIZE-1:0] A, B;
    output reg [`WORD_SIZE-1:0] C;
    
    always @(*) begin
        C = A&B;
    end
endmodule
