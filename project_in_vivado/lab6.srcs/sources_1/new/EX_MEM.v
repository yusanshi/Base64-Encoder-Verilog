`timescale 1ns / 1ps


module EX_MEM (
           input clk ,
           input rst,
           input RegWriteE ,
           input MemtoRegE ,
           input MemWriteE ,
           input [31: 0] ALU_result,
           input [31: 0] WriteDataE,
           input [ 4: 0] WriteRegE ,
           output reg RegWriteM ,
           output reg MemtoRegM ,
           output reg MemWriteM ,
           output reg [31: 0] ALUOutM ,
           output reg [31: 0] WriteDataM,
           output reg [ 4: 0] WriteRegM
       );

always @(posedge clk  or posedge rst)
if (rst)
begin
    RegWriteM <= 0;
    MemtoRegM <= 0;
    MemWriteM <= 0;
    ALUOutM <= 0;
    WriteDataM <= 0;
    WriteRegM <= 0;
end
else
begin
    RegWriteM <= RegWriteE;
    MemtoRegM <= MemtoRegE;
    MemWriteM <= MemWriteE;
    ALUOutM <= ALU_result;
    WriteDataM <= WriteDataE;
    WriteRegM <= WriteRegE;
end

endmodule
