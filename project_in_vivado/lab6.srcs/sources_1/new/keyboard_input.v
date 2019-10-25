`timescale 1ns / 1ps

module keyboard_input(
    input clk,
    input rst,
    input PS2_CLK,
    input PS2_DATA,
    output reg [6:0] data,
    output reg valid_shock,
    output [31:0] key_code
    );

wire [7:0] datacur;
wire [7:0] dataprev;
wire [7:0] dataprevprev;

reg valid_flag;
wire shift;

// TODO
// Now when press Shift and then press more than one keys,
// only the fisrt is in "shift mode".
// To correct it,
// use a state to inditate whether is in "shift mode":
// if (prev:cur) == **59 or **12 enter shift mode
// if (prev:cur) == F012 or F059 exit shift mode
// Notes: Use FSM to do this

assign shift = (dataprev == 8'h12 || dataprev == 8'h59) && dataprevprev != 8'hf0;

assign datacur = key_code[7:0];
assign dataprev = key_code[15:8];
assign dataprevprev = key_code[23:16];

always @(posedge clk or posedge rst)
if (rst) begin valid_shock <= 0; valid_flag <= 1; end
else
begin
    if (datacur != 8'h12 && datacur != 8'h59 && dataprev != 8'hf0 && datacur != 8'hf0)
    begin
        if (valid_flag == 1)
        begin
            if (data == 0) valid_shock <= 0;
            else begin valid_shock <= 1; valid_flag <=0; end
        end
        else valid_shock <= 0;
    end else begin valid_shock <= 0; valid_flag <= 1; end
end

always @(posedge clk or posedge rst)
begin
    if (rst) data <= 0;
    else
    case (datacur)
        8'h1c: data <= (shift == 1)?65:97; // A/a
        8'h32: data <= (shift == 1)?66:98; // B/b
        8'h21: data <= (shift == 1)?67:99; // ...
        8'h23: data <= (shift == 1)?68:100;
        8'h24: data <= (shift == 1)?69:101;
        8'h2b: data <= (shift == 1)?70:102;
        8'h34: data <= (shift == 1)?71:103;
        8'h33: data <= (shift == 1)?72:104;
        8'h43: data <= (shift == 1)?73:105;
        8'h3b: data <= (shift == 1)?74:106;
        8'h42: data <= (shift == 1)?75:107;
        8'h4b: data <= (shift == 1)?76:108;
        8'h3a: data <= (shift == 1)?77:109;
        8'h31: data <= (shift == 1)?78:110;
        8'h44: data <= (shift == 1)?79:111;
        8'h4d: data <= (shift == 1)?80:112;
        8'h15: data <= (shift == 1)?81:113;
        8'h2d: data <= (shift == 1)?82:114;
        8'h1b: data <= (shift == 1)?83:115;
        8'h2c: data <= (shift == 1)?84:116;
        8'h3c: data <= (shift == 1)?85:117;
        8'h2a: data <= (shift == 1)?86:118;
        8'h1d: data <= (shift == 1)?87:119;
        8'h22: data <= (shift == 1)?88:120;
        8'h35: data <= (shift == 1)?89:121; // ...
        8'h1a: data <= (shift == 1)?90:122; // Z/z
        8'h29: data <= 32; // sapce
        8'h66: data <= 8; // backspace
        8'h16: data <= (shift == 1)?33:49; // 1
        8'h1e: data <= (shift == 1)?64:50;
        8'h26: data <= (shift == 1)?35:51;
        8'h25: data <= (shift == 1)?36:52;
        8'h2e: data <= (shift == 1)?37:53;
        8'h36: data <= (shift == 1)?94:54;
        8'h3d: data <= (shift == 1)?38:55;
        8'h3e: data <= (shift == 1)?42:56;
        8'h46: data <= (shift == 1)?40:57; // 9
        8'h45: data <= (shift == 1)?41:48; // 0
        8'h4e: data <= (shift == 1)?95:45; // _-
        8'h55: data <= (shift == 1)?43:61; // +=
        8'h41: data <= (shift == 1)?60:44; // <,
        8'h49: data <= (shift == 1)?62:46; // >.
        8'h4a: data <= (shift == 1)?63:47; // ?/
        8'h4c: data <= (shift == 1)?58:59; // :;
        8'h52: data <= (shift == 1)?34:39; // "'
        8'h54: data <= (shift == 1)?123:91; // {[
        8'h5b: data <= (shift == 1)?125:93; // }]
        8'h5d: data <= (shift == 1)?124:92; // |\
        8'h0e: data <= (shift == 1)?126:96; // ~`
        8'h70: data <= 48; // 0 (small keyboard)
        8'h69: data <= 49; // 1 (small keyboard)
        8'h72: data <= 50; // 2 (small keyboard)
        8'h7a: data <= 51; // 3 (small keyboard)
        8'h6b: data <= 52; // 4 (small keyboard)
        8'h73: data <= 53; // 5 (small keyboard)
        8'h74: data <= 54; // 6 (small keyboard)
        8'h6c: data <= 55; // 7 (small keyboard)
        8'h75: data <= 56; // 8 (small keyboard)
        8'h7d: data <= 57; // 9 (small keyboard)
        8'h71: data <= 46; // . (small keyboard)
        8'h79: data <= 43; // + (small keyboard)
        8'h7b: data <= 45; // - (small keyboard)
        8'h7c: data <= 42; // * (small keyboard)
        default: data <= 0;
    endcase
end

PS2_receiver (
             .clk(clk),
             .rst(rst),
             .kclk (PS2_CLK),
             .kdata (PS2_DATA),
             .keycodeout(key_code)
             // .valid_shock(valid_shock)
             );


endmodule
