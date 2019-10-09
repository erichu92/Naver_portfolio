`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 11:40:34
// Design Name: 
// Module Name: mux_16_2
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


module mux_16_2(
    A, B, C, Sel
    );
    
    input [15:0] A, B;
    input Sel;
    
    output [15:0] C;
    
    assign C = Sel ? B : A;
    
endmodule
