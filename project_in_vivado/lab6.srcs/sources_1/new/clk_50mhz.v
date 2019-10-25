`timescale 1ns / 1ps

module clk_50mhz(
    input rst,
    input clk_100mhz,
    output reg clk_50mhz
    );

always @(posedge clk_100mhz or posedge rst)
if (rst) begin clk_50mhz<=0; end
else clk_50mhz<=~clk_50mhz;

endmodule
