`timescale 1ns / 1ps

module clk_1hz(
    input rst,
    input clk_100mhz,
    output reg clk_1hz
    );

reg [27:0] count;

always @(posedge clk_100mhz or posedge rst)
if (rst) begin count<=0; clk_1hz<=0; end
else if (count==50000000) begin clk_1hz<=~clk_1hz; count<=0; end
else count<=count+1;

endmodule
