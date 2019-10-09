`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 11:51:25
// Design Name: 
// Module Name: sl_12_2
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


module sl_12_2(
    A, B
    );
    input [11:0] A;
    output [13:0] B;
    
    assign B[13:2] = A;
    assign B[1:0] = 2'b00;
    
endmodule
