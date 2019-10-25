`timescale 1ns / 1ps

module PS2_receiver(
    input clk,
    input rst,
    input kclk,
    input kdata,
    output [31:0] keycodeout
    );
    
    wire kclkf, kdataf;
    reg [7:0]datacur;
    reg [7:0]dataprev;
    reg [3:0]cnt;
    reg [31:0]keycode;
    reg flag;

debouncer debounce(
    .clk(clk),
    .I0(kclk),
    .I1(kdata),
    .O0(kclkf),
    .O1(kdataf)
);
    
always@(negedge kclkf or posedge rst)
begin
if (rst)
    begin
        cnt<=4'b0000;
        flag<=1'b0;
    end
else
    begin   
        case(cnt)
        0:;//Start bit
        1:datacur[0]<=kdataf;
        2:datacur[1]<=kdataf;
        3:datacur[2]<=kdataf;
        4:datacur[3]<=kdataf;
        5:datacur[4]<=kdataf;
        6:datacur[5]<=kdataf;
        7:datacur[6]<=kdataf;
        8:datacur[7]<=kdataf;
        9:flag<=1'b1;
        10:flag<=1'b0;
        endcase

        cnt <= (cnt >= 10)? 0 : cnt+1;
    end
end

always @(posedge flag or posedge rst)
begin
    if (rst) keycode[31:0]<=32'h00000000;
    else
    begin
        keycode[31:24]<=keycode[23:16];
        keycode[23:16]<=keycode[15:8];
        keycode[15:8]<=dataprev;
        keycode[7:0]<=datacur;
        dataprev<=datacur;
    end
end
    
assign keycodeout=keycode;
    
endmodule
