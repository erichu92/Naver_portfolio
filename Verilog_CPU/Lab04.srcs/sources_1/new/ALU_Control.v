`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 05:02:33
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(
    Func, ALUOp, ALU_Out
    );
    input [5:0] Func;
    input [3:0] ALUOp;
    output [5:0] ALU_Out;
    
    assign ALU_Out = ALUOp == 4'd15 ? Func :
                              4'd
    
endmodule
