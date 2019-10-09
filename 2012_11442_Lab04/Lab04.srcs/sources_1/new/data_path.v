`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 04:24:54
// Design Name: 
// Module Name: data_path
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

module data_path(
        func, readM, address, data, inputReady, reset_n, clk, output_port, OP, RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, num_inst
    );
    
    inout [`WORD_SIZE-1:0] data;
    
    input inputReady, reset_n, clk;
    input RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    
    output reg readM;
    output reg [`WORD_SIZE-1:0] num_inst;
    output reg [`WORD_SIZE-1:0] output_port;
    output [3:0] OP;
    output [`WORD_SIZE-1:0] address;
    output [5:0] func;
    reg [`WORD_SIZE-1:0] fetch;
    
    wire [`WORD_SIZE-1:0] pc_out;
    wire [`WORD_SIZE-1:0] Data1;
    
    initial begin
        num_inst = 0;
        output_port = 0;
    end
    
    always @(*) begin
        if(!reset_n) begin
            readM = 0;
            num_inst = 0;
            output_port = 0;
            fetch = 0;
        end
    end
    
    
    always @(posedge clk) begin
        if(!reset_n)
            readM <= 0;
        else
            readM <= 1;
    end
    
    always @(posedge inputReady) begin
        fetch = data;
        num_inst = num_inst + 1;
        readM = 0;
    end
    
    
    always @(*) begin
        if( fetch[15:12] == 4'd15 && fetch[5:0] == 6'd28 )
            begin
                output_port = Data1;
            end
    end
    
    wire [`WORD_SIZE-1:0] ALU_A, ALU_B, ALU_C;
    wire [3:0] ALUOp;
    wire [5:0] func;
    wire bcond;
    
    ALU ALU(
        .ALU_A(ALU_A),
        .ALU_B(ALU_B),
        .ALU_C(ALU_C),
        .ALUOp(ALUOp),
        .func(func),
        .bcond(bcond)
    );
    
    wire [1:0] Addr1, Addr2, Addr3;
    wire [`WORD_SIZE-1:0] Data2, Data3;
    wire clk, RegWrite, reset_n;
    
    RF RF(
        .Addr1(Addr1),
        .Addr2(Addr2),
        .Addr3(Addr3),
        .Data1(Data1),
        .Data2(Data2),
        .Data3(Data3),
        .RegWrite(RegWrite),
        .clk(clk),
        .reset_n(reset_n)
    );
    
    wire [7:0] sign_A;
    wire[`WORD_SIZE-1:0] sign_B;
    
    sign_extend sign_extend(
        .A(sign_A),
        .B(sign_B)
    );

    wire [`WORD_SIZE-1:0] pc_in;
    
    pc pc(
        .clk(clk),
        .pc_in(pc_in),
        .pc_out(pc_out),
        .reset_n(reset_n)
    );
    
    wire [`WORD_SIZE-1:0] pc_add;
    
    pc_adder pc_adder(
        .pc_out(pc_out),
        .pc_add(pc_add)
    );
    
    wire [1:0] RegMux_A, RegMux_B, RegMux_C;
    wire RegMux_Sel;
    
    mux_2_2 RegMux(
        .A(RegMux_A),
        .B(RegMux_B),
        .C(RegMux_C),
        .Sel(RegMux_Sel)
    );
    
    wire [`WORD_SIZE-1:0] ALUMux_A, ALUMux_B, ALUMux_C;
    wire ALUMux_Sel;
    
    mux_16_2 ALUMux(
        .A(ALUMux_A),
        .B(ALUMux_B),
        .C(ALUMux_C),
        .Sel(ALUMux_Sel)
    );
    
    wire [`WORD_SIZE-1:0] MemOutMux_A, MemOutMux_B, MemOutMux_C;
    wire MemOutMux_Sel;
    
    mux_16_2 MemOutMux(
        .A(MemOutMux_A),
        .B(MemOutMux_B),
        .C(MemOutMux_C),
        .Sel(MemOutMux_Sel)
    );
    
    wire [`WORD_SIZE-1:0] BrMux_A, BrMux_B, BrMux_C;
    wire BrMux_Sel;
    
    mux_16_2 BrMux(
        .A(BrMux_A),
        .B(BrMux_B),
        .C(BrMux_C),
        .Sel(BrMux_Sel)
    );
    
    wire [`WORD_SIZE-1:0] JmpMux_A, JmpMux_B, JmpMux_C;
    wire JmpMux_Sel;
    
    mux_16_2 JmpMux(
        .A(JmpMux_A),
        .B(JmpMux_B),
        .C(JmpMux_C),
        .Sel(JmpMux_Sel)
    );
    
    // Assign Control Unit
    assign OP = fetch[15:12];
    assign func = fetch[5:0];
    
    // Assign Register File
    assign Addr1 = fetch[11:10];
    assign Addr2 = fetch[9:8];
    assign Addr3 = RegMux_C;
    assign Data3 = MemOutMux_C;
    
    // Assign RegMux
    assign RegMux_A = fetch[9:8];
    assign RegMux_B = fetch[7:6];
    assign RegMux_Sel = RegDst;
    
    // Assign Sign extend
    assign sign_A = fetch[7:0];
    
    // Assign ALU
    assign func = fetch[5:0];
    assign ALUOp = fetch[15:12];
    assign ALU_A = Data1;
    assign ALU_B = ALUMux_C;
    
    // Assign ALU_Mux
    assign ALUMux_A = Data2;
    assign ALUMux_B = sign_B;
    assign ALUMux_Sel = ALUSrc;
    
    // Assign JmpMux
    assign JmpMux_A = pc_add;
    assign JmpMux_B = { pc_add[15:12], fetch[11:0] };
    assign JmpMux_Sel = Jump;
    
    // Assign pc
    assign pc_in = JmpMux_C;
    
    // Assign MemOutMux
    assign MemOutMux_A = ALU_C;
    assign MemOutMux_Sel = MemtoReg;
    
    assign address = pc_out;
    
endmodule
