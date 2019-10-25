`timescale 1ns / 1ps


module MEM_WB(
           input clk,
           input rst,
           input RegWriteM,
           input MemtoRegM,
           input [31: 0] data_memory_output,
           input [31: 0] ALUOutM,
           input [4: 0] WriteRegM,
           output reg RegWriteW,
           output reg MemtoRegW,
           output reg[31: 0] ReadDataW,
           output reg [31: 0] ALUOutW,
           output reg [4: 0] WriteRegW
       );

always @(posedge clk or posedge rst)
  if (rst)
  begin
    RegWriteW <= 0;
    MemtoRegW <= 0;
    ReadDataW <= 0;
    ALUOutW <= 0;
    WriteRegW <= 0;
  end
  else
  begin
    RegWriteW <= RegWriteM;
    MemtoRegW <= MemtoRegM;
    ReadDataW <= data_memory_output;
    ALUOutW <= ALUOutM;
    WriteRegW <= WriteRegM;
end

endmodule
