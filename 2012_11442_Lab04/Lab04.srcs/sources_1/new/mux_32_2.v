`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 11:39:05
// Design Name: 
// Module Name: mux_32_2
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


module mux_32_2(
    A, B, C, Sel
    );
    
    input [31:0] A, B;
    input Sel;
    
    output C;
    
    assign C = Sel ? B : A;
    
endmodule
