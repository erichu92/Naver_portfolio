`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 14:39:55
// Design Name: 
// Module Name: pc
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

module pc(
    pc_in, pc_out, clk, reset_n
    );
    
    input clk, reset_n;
    input [`WORD_SIZE-1:0] pc_in = 16'd0;
    output reg [`WORD_SIZE-1:0] pc_out;
    
    initial begin
        pc_out = -1;
    end
    
    always @(posedge clk) begin
        if(!reset_n)
            pc_out <= -1;
        else
            pc_out <= pc_in;
    end
    
endmodule
