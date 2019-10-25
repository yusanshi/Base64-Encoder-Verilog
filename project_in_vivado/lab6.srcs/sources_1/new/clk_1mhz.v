`timescale 1ns / 1ps

module clk_1mhz(
    input rst,
    input clk_100mhz,
    output reg clk_1mhz
    );

reg [6:0] count;

always @(posedge clk_100mhz or posedge rst)
if (rst) begin count<=0; clk_1mhz<=0; end
else if (count==49) begin clk_1mhz<=~clk_1mhz; count<=0; end
else count<=count+1;

endmodule
