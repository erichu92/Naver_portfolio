`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 04:34:06
// Design Name: 
// Module Name: ALU
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

module ALU(
        ALUOp, func, ALU_A, ALU_B, ALU_C, bcond
    );
    
    input [3:0] ALUOp;
    input [`WORD_SIZE-1:0] ALU_A, ALU_B;
    input [5:0] func;
    
    output reg bcond;
    output reg [`WORD_SIZE-1:0] ALU_C;
    
    always @(*) begin
        case(ALUOp)
            4'd0:
                begin
                
                end
            4'd1:
                begin
                
                end
            4'd2:
                begin
                
                end
            4'd3:
                begin
                
                end
            4'd4: // ADDI
                begin
                    ALU_C = ALU_A + ALU_B;
                end
            4'd5:
                begin
                
                end
            4'd6: // LHI
                begin
                    ALU_C = ALU_B << 8 ;
                end
            4'd7:
                begin
                
                end
            4'd8:
                begin
                
                end
            4'd9: // Jump
                begin
                
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
            4'd15:
                begin
                    case(func)
                        6'd0: // ADD
                            begin
                                ALU_C = ALU_A + ALU_B;
                            end
                        6'd28: // WWD
                            begin
                                ALU_C = ALU_A;
                            end
                    endcase
                end
        endcase
    end
    
endmodule
