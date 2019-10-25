`timescale 1ns / 1ps

module IF_ID (
           input clk ,
           input rst,
           input clr ,
           input en,
           input [31: 0] instruction_memory_output,
           input [31: 0] PCPlus4F ,
           output reg [31: 0] InstrD ,
           output reg [31: 0] PCPlus4D
       );

always @(posedge clk or posedge rst)
  begin
    if (rst)
      begin
        InstrD   <= 0;
        PCPlus4D <= 0;
      end
    else if (~en)
      begin
        InstrD   <= InstrD;
        PCPlus4D <= PCPlus4D;
      end
    else if (clr)
      begin
        InstrD   <= 0;
        PCPlus4D <= 0;
      end
      else begin
        InstrD   <= instruction_memory_output;
        PCPlus4D <= PCPlus4F;
      end
  end

endmodule
