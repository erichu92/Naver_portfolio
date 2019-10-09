`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 04:25:33
// Design Name: 
// Module Name: control_unit
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

//`include "opcodes.v"

module control_unit(
        OP, clk, RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, reset_n, func
    );
    
    input [3:0] OP;
    input clk, reset_n;
    input [5:0] func;
    
    output reg RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    
    initial begin
        RegDst <= 0;
        Jump <= 0;
        Branch <= 0;
        MemRead <= 0;
        MemtoReg <= 0;
        MemWrite <= 0;
        ALUSrc <= 0;
        RegWrite <= 0;    
    end
    
    always @(*) begin
        if(!reset_n) begin
            RegDst <= 0;
            Jump <= 0;
            Branch <= 0;
            MemRead <= 0;
            MemtoReg <= 0;
            MemWrite <= 0;
            ALUSrc <= 0;
            RegWrite <= 0;
        end
        else begin
            case(OP)
                4'd1:
                    begin
                    
                    end
                4'd2:
                    begin
                    
                    end
                4'd3:
                    begin
                    
                    end
                4'd4: // ADI
                    begin
                        RegDst <= 0;
                        Jump <= 0;
                        Branch <= 0;
                        MemRead <= 0;
                        MemtoReg <= 0;
                        MemWrite <= 0;
                        ALUSrc <= 1;
                        RegWrite <= 1;
                    end
                4'd5:
                    begin
                    
                    end
                4'd6: // LHI
                    begin
                        RegDst <= 0;
                        Jump <= 0;
                        Branch <= 0;
                        MemRead <= 0;
                        MemtoReg <= 0;
                        MemWrite <= 0;
                        ALUSrc <= 1;
                        RegWrite <= 1;
                    end
                4'd7:
                    begin
                    
                    end
                4'd8:
                    begin
                    
                    end
                4'd9: // JMP
                    begin
                        RegDst <= 0; // Don't Care
                        Jump <= 1;
                        Branch <= 0; // Don't Care
                        MemRead <= 0;
                        MemtoReg <= 0; // Don't Care
                        MemWrite <= 0;
                        ALUSrc <= 0; // Don't Care
                        RegWrite <= 0;
                    end
                4'd10:
                    begin
                    
                    end
                4'd11:
                    begin
                    
                    end
                4'd12:
                    begin
                    
                    end
                4'd13:
                    begin
                    
                    end
                4'd14:
                    begin
                    
                    end
                4'd15: // ADD, SUB, AND, ORR, NOT, TCP, SHL, SHR, RWD, WWD Operation.
                    begin
                        RegDst <= 1;
                        Jump <= 0;
                        Branch <= 0;
                        MemRead <= 0;
                        MemtoReg <= 0;
                        MemWrite <= 0;
                        ALUSrc <= 0;
                        if(func == 6'd28)
                            begin
                                RegWrite = 0;
                            end
                        else
                            begin
                                RegWrite = 1;
                            end
                    end
            endcase
        end
    end
    
endmodule
