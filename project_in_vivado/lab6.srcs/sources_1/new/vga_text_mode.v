`timescale 1ns / 1ps

module vga_text_mode(
           input clk,
           // provider
           input [20: 0] vaddr,
           input [10: 0] vaddr_x,
           input [10: 0] vaddr_y,

           output [11: 0] vga_text_mode_output,

           // modifier
           input text_modify_enable,
           input [13: 0] char_count_to_change,
           input [15: 0] char_to_change_to
       );

// 240*68=16320 chars

wire [20:0] vaddr_next  ;
wire [10:0] vaddr_x_next;
wire [10:0] vaddr_y_next;

wire [10: 0] row_count;
wire [10: 0] column_count;

wire [2: 0] x_in_char;
wire [3: 0] y_in_char;

wire [13: 0] count_in_char_RAM_next;

// chars_RAM: 16bit width, [6:0] is ascii,
// other bit could be used such as color,
// background, and so on
wire [15: 0] data_out;
wire [6: 0] ascii_out;
wire [7: 0] font_data_out;

assign vaddr_x_next = (vaddr_x == 1919) ? 0 : vaddr_x + 1;
assign vaddr_y_next = (vaddr_x == 1919) ? ((vaddr_y == 1079) ? 0 : vaddr_y + 1) : vaddr_y;
assign vaddr_next = 1920 * vaddr_y_next + vaddr_x_next;

assign row_count = vaddr_y;
assign column_count = vaddr_x;
assign x_in_char = column_count[2: 0];
assign y_in_char = row_count[3: 0];
assign count_in_char_RAM_next = 240 * vaddr_y_next[10:4]+vaddr_x_next[10:3];

assign ascii_out = data_out[6: 0];


all_text_ascii (
        .a(char_count_to_change),
        .d(char_to_change_to),
        .dpra(count_in_char_RAM_next),
        .clk(clk),
        .we(text_modify_enable),
        .qdpo(data_out)
    );

font_rom (
        .a({ascii_out, y_in_char}),
        .spo(font_data_out)
    );

assign vga_text_mode_output = font_data_out[~x_in_char] == 1 ? 12'hfff : 12'h000;

endmodule
