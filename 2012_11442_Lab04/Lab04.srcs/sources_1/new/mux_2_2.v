`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 11:42:23
// Design Name: 
// Module Name: mux_2_2
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


module mux_2_2(
    A, B, C, Sel
    );
    
    input [1:0] A, B;
    input Sel;
    
    output [1:0] C;
    
    assign C = Sel ? B : A;
    
endmodule
