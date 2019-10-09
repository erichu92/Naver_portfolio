`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/26 04:25:46
// Design Name: 
// Module Name: RF
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

module RF(
    Addr1, Addr2, Addr3, Data1, Data2, Data3, RegWrite, clk, reset_n
    );
    
    input [1:0] Addr1, Addr2, Addr3;
    input [`WORD_SIZE-1:0] Data3;
    input RegWrite, clk, reset_n;
    
    output [`WORD_SIZE-1:0] Data1, Data2;
    
    reg [`WORD_SIZE-1:0] reg0, reg1, reg2, reg3;
    
    assign Data1 = Addr1 == 2'b00 ? reg0 :
                   Addr1 == 2'b01 ? reg1 :
                   Addr1 == 2'b10 ? reg2 :
                   Addr1 == 2'b11 ? reg3 : 0;
    assign Data2 = Addr2 == 2'b00 ? reg0 :
                   Addr2 == 2'b01 ? reg1 :
                   Addr2 == 2'b10 ? reg2 :
                   Addr2 == 2'b11 ? reg3 : 0;
    
    initial begin
        reg0 = 0;
        reg1 = 0;
        reg2 = 0;
        reg3 = 0;
    end
    always @(posedge clk) begin
        if(!reset_n)
            begin
                reg0 <= 0;
                reg1 <= 0;
                reg2 <= 0;
                reg3 <= 0;
            end
        if(RegWrite)
            begin
                case(Addr3)
                    2'b00: reg0 <= Data3;
                    2'b01: reg1 <= Data3;
                    2'b10: reg2 <= Data3;
                    2'b11: reg3 <= Data3;
                endcase
            end
    end

    
endmodule
