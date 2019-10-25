`timescale 1ns / 1ps

module ID_EX(
           input clk,
           input rst,
           input clr,
           input RegWriteD,
           input MemtoRegD,
           input MemWriteD,
           input [3: 0] ALUControlD,
           input ALUSrcD,
           input RegDstD,
           input [31: 0] no_name_1,
           input [31: 0] no_name_3,
           input [4: 0] RsD,
           input [4: 0] RtD,
           input [4: 0] RdD,
           input [31: 0] SignImmD,
           output reg RegWriteE,
           output reg MemtoRegE,
           output reg MemWriteE,
           output reg [3: 0] ALUControlE,
           output reg ALUSrcE,
           output reg RegDstE,
           output reg [31: 0] no_name_5,
           output reg [31: 0] no_name_6,
           output reg [4: 0] RsE,
           output reg [4: 0] RtE,
           output reg [4: 0] RdE,
           output reg [31: 0] SignImmE
       );

always @(posedge clk or posedge rst)
begin
    if (clr || rst)
    begin
        RegWriteE <= 0;
        MemtoRegE <= 0;
        MemWriteE <= 0;
        ALUControlE <= 0;
        ALUSrcE <= 0;
        RegDstE <= 0;
        no_name_5 <= no_name_1;
        no_name_6 <= no_name_3;
        RsE <= RsD;
        RtE <= RtD;
        RdE <= RdD;
        SignImmE <= SignImmD;
        // no_name_5 <= 0;
        // no_name_6 <= 0;
        // RsE <= 0;
        // RtE <= 0;
        // RdE <= 0;
        // SignImmE <= 0;
    end
    else
    begin
        RegWriteE <= RegWriteD;
        MemtoRegE <= MemtoRegD;
        MemWriteE <= MemWriteD;
        ALUControlE <= ALUControlD;
        ALUSrcE <= ALUSrcD;
        RegDstE <= RegDstD;
        no_name_5 <= no_name_1;
        no_name_6 <= no_name_3;
        RsE <= RsD;
        RtE <= RtD;
        RdE <= RdD;
        SignImmE <= SignImmD;
    end


end

endmodule
