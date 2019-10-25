`timescale 1ns / 1ps


module control (
           input [5: 0] Op ,
           input [5: 0] Funct,

           output reg RegWriteD,
           output reg MemtoRegD,
           output reg MemWriteD,
           output reg [3: 0] ALUControlD,
           output reg ALUSrcD,
           output reg RegDstD,
           output reg BranchD,
           output reg JumpD
       );

// Op[5:0]
// R-type: 6'b000000
// lw:  6'b100011
// sw:  6'b101011
// beq:  6'b000100
// bne:  6'b000101
// j:  6'b000010

// addi:  6'b001000
// andi:  6'b001100
// ori: 6'b001101
// xori: 6'b001110
// slti: 6'b001010

always @( * )
    case (Op)
        6'b000000:    // R-type
            begin
                RegWriteD <= 1;
                MemtoRegD <= 0;
                MemWriteD <= 0;
                ALUControlD <=
                    (Funct == 6'b100000) ? 4'b0010 : // Add
                    (Funct == 6'b100010) ? 4'b0110 : // Sub
                    (Funct == 6'b100100) ? 4'b0000 : // And
                    (Funct == 6'b100101) ? 4'b0001 : // Or
                    (Funct == 6'b101010) ? 4'b0111 : // Xor
                    (Funct == 6'b100110) ? 4'b0011 : // Nor
                    (Funct == 6'b100111) ? 4'b0100 : // Stl
                    (Funct == 6'b000100) ? 4'b0101 : // Sllv
                    (Funct == 6'b000110) ? 4'b1000 : // Srlv
                    4'b0000;
                ALUSrcD <= 0;
                RegDstD <= 1;
                BranchD <= 0;
                JumpD <= 0;
            end

    6'b100011:    // lw
    begin
        RegWriteD <= 1;
        MemtoRegD <= 1;
        MemWriteD <= 0;
        ALUControlD <= 4'b0010;
        ALUSrcD <= 1;
        RegDstD <= 0;
        BranchD <= 0;
        JumpD <= 0;

    end

    6'b101011:    // sw
    begin
        RegWriteD <= 0;
        MemtoRegD <= 0;
        MemWriteD <= 1;
        ALUControlD <= 4'b0010;
        ALUSrcD <= 1;
        RegDstD <= 0;
        BranchD <= 0;
        JumpD <= 0;
    end

    6'b000100:    // beq
    begin
        RegWriteD <= 0;
        MemtoRegD <= 0;
        MemWriteD <= 0;
        ALUControlD <= 4'b0000;
        ALUSrcD <= 0;
        RegDstD <= 0;
        BranchD <= 1;
        JumpD <= 0;
    end

    6'b000101:    // bne
    begin
        RegWriteD <= 0;
        MemtoRegD <= 0;
        MemWriteD <= 0;
        ALUControlD <= 4'b0000;
        ALUSrcD <= 0;
        RegDstD <= 0;
        BranchD <= 1;
        JumpD <= 0;
    end

    6'b000010:    // j
    begin
        RegWriteD <= 0;
        MemtoRegD <= 0;
        MemWriteD <= 0;
        ALUControlD <= 4'b0000;
        ALUSrcD <= 0;
        RegDstD <= 0;
        BranchD <= 0;
        JumpD <= 1;
    end

    6'b001000:   // addi
    begin
        RegWriteD <= 1;
        MemtoRegD <= 0;
        MemWriteD <= 0;
        ALUControlD <= 4'b0010;
        ALUSrcD <= 1;
        RegDstD <= 0;
        BranchD <= 0;
        JumpD <= 0;
    end

    6'b001100:   // andi
    begin
        RegWriteD <= 1;
        MemtoRegD <= 0;
        MemWriteD <= 0;
        ALUControlD <= 4'b0000;
        ALUSrcD <= 1;
        RegDstD <= 0;
        BranchD <= 0;
        JumpD <= 0;
    end

    6'b001101:   // ori
    begin
        RegWriteD <= 1;
        MemtoRegD <= 0;
        MemWriteD <= 0;
        ALUControlD <= 4'b0001;
        ALUSrcD <= 1;
        RegDstD <= 0;
        BranchD <= 0;
        JumpD <= 0;
    end

    6'b001110:   // xori
    begin
        RegWriteD <= 1;
        MemtoRegD <= 0;
        MemWriteD <= 0;
        ALUControlD <= 4'b0011;
        ALUSrcD <= 1;
        RegDstD <= 0;
        BranchD <= 0;
        JumpD <= 0;
    end

    6'b001010:   // slti
    begin
        RegWriteD <= 1;
        MemtoRegD <= 0;
        MemWriteD <= 0;
        ALUControlD <= 4'b0111;
        ALUSrcD <= 1;
        RegDstD <= 0;
        BranchD <= 0;
        JumpD <= 0;
    end

    default:
    begin
        RegWriteD <= 0;
        MemtoRegD <= 0;
        MemWriteD <= 0;
        ALUControlD <= 0;
        ALUSrcD <= 0;
        RegDstD <= 0;
        BranchD <= 0;
        JumpD <= 0;
    end

endcase


endmodule
