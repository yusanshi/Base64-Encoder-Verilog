`timescale 1ns / 1ps

module clk_10hz(
    input rst,
    input clk_100mhz,
    output reg clk_10hz
    );

reg [27:0] count;

always @(posedge clk_100mhz or posedge rst)
if (rst) begin count<=0; clk_10hz<=0; end
else if (count==5000000) begin clk_10hz<=~clk_10hz; count<=0; end
else count<=count+1;

endmodule
