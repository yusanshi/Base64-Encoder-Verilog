`timescale 1ns / 1ps

module top (
           input clk ,  // 100Mhz clk
           input rst ,
           input [1:0] frequency,
           input PS2_CLK,
           input PS2_DATA,
           output cpu_clk,
           output [ 7: 0] seg,
           output [ 7: 0] an,
           output h_sync, v_sync,
           output [11: 0] vga
       );

wire [31: 0] seg_data_to_display;

wire [20:0] vaddr;
wire [10:0] vaddr_x;
wire [10:0] vaddr_y;

wire [11:0] vdata  ;

wire text_modify_enable       ;
wire [13:0]  char_count_to_change; // change which char? (0~240*68)
wire [15:0]  char_to_change_to   ; // change char to which? ([6:0] means ascii)

wire pixel_modify_enable;
wire [20: 0] pixel_addr_to_change;
wire [10: 0] pixel_addr_x_to_change;
wire [10: 0] pixel_addr_y_to_change;
wire [11: 0] pixel_to_change_to;

wire [11: 0] vga_text_mode_output ;
wire [11: 0] vga_graph_mode_output;
wire is_text_mode ;

wire [6:0] input_area_for_display;
wire [6:0] output_area_for_display;
wire [31:0] reg_addr_for_display;
wire [12:0] input_area_addr_for_display;
wire [12:0] output_area_addr_for_display;
wire [31:0] register_data_for_display;
wire [31:0] PC_for_display;
wire [31:0] instruction_for_display;

wire [31:0] key_code;

wire [6:0] data_from_keyboard;
wire we_from_keyboard;

wire [6:0] data_from_cpu;
wire [12:0] addr_from_cpu;
wire we_from_cpu;

wire [12:0] addr_requested_by_cpu;
wire [6:0] data_got_by_cpu;

wire [12:0] total_char_num;

wire clk_for_1080p;
wire clk_1hz;
wire clk_10hz;
wire clk_1mhz;
wire clk_50mhz;

assign seg_data_to_display = key_code;
assign vdata = (is_text_mode == 1) ? vga_text_mode_output : vga_graph_mode_output;
assign cpu_clk = 
    (frequency == 0)?clk_1mhz:
    (frequency == 1)?clk_10hz:
    (frequency == 2)?clk_1hz:0;

clk_1hz (rst, clk, clk_1hz);
clk_10hz (rst, clk, clk_10hz);
clk_1mhz (rst, clk, clk_1mhz);
clk_50mhz (rst, clk, clk_50mhz);
clk_wiz_0 (
        .clk_out1(clk_for_1080p),
        .clk_in1(clk)
    );


cpu (
        .clk(cpu_clk),
        .rst(rst),
        .reg_addr_for_display(reg_addr_for_display),
        .register_data_for_display(register_data_for_display),
        .PC_for_display(PC_for_display),
        .instruction_for_display(instruction_for_display),

        .data_got_by_cpu(data_got_by_cpu),
        .addr_requested_by_cpu(addr_requested_by_cpu),
        .total_char_num(total_char_num),


        .we_from_cpu(we_from_cpu),
        .addr_from_cpu(addr_from_cpu),
        .data_from_cpu(data_from_cpu)
    );


seg_display (
        .clk(clk),
        .rst(rst),
        .has_dot(8'b00000000),
        .is_display(8'b11111111),
        .data_to_display(seg_data_to_display),
        .seg(seg),
        .an(an)
    );

vga_mode (
        .vaddr(vaddr),
        .vaddr_x(vaddr_x),
        .vaddr_y(vaddr_y),
        .is_text_mode(is_text_mode)
    );

vga_display (
        .clk(clk_for_1080p),
        .rst(rst),
        .vdata(vdata),
        .vaddr_x(vaddr_x),
        .vaddr_y(vaddr_y),
        .vaddr(vaddr),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .vga(vga)
    );

vga_text_mode (
        .clk(clk_for_1080p),
        .vaddr(vaddr),
        .vaddr_x(vaddr_x),
        .vaddr_y(vaddr_y),
        .vga_text_mode_output(vga_text_mode_output),
        .text_modify_enable(text_modify_enable),
        .char_count_to_change(char_count_to_change),
        .char_to_change_to(char_to_change_to)
    );

vga_text_modifier (
        .clk(clk_for_1080p),
        .rst(rst),
        .register_data_for_display(register_data_for_display),
        .PC_for_display(PC_for_display),
        .instruction_for_display(instruction_for_display),
        .input_area_for_display(input_area_for_display),
        .output_area_for_display(output_area_for_display),
        .input_area_addr_for_display(input_area_addr_for_display),
        .output_area_addr_for_display(output_area_addr_for_display),
        .reg_addr_for_display(reg_addr_for_display),
        .text_modify_enable(text_modify_enable),
        .char_count_to_change(char_count_to_change),
        .char_to_change_to(char_to_change_to)
    );

vga_graph_mode (
        .clk(clk_for_1080p),
        .vaddr(vaddr),
        .vaddr_x(vaddr_x),
        .vaddr_y(vaddr_y),
        .vga_graph_mode_output(vga_graph_mode_output),
        .pixel_modify_enable(pixel_modify_enable),
        .pixel_addr_to_change(pixel_addr_to_change),
        .pixel_addr_x_to_change(pixel_addr_x_to_change),
        .pixel_addr_y_to_change(pixel_addr_y_to_change),
        .pixel_to_change_to(piexel_to_change_to)
    );

text_ram (
    .clk(clk_50mhz),
    .rst(rst),
    .input_we(we_from_keyboard),
    .output_we(we_from_cpu),
    .input_ra0(input_area_addr_for_display),
    .input_ra1(addr_requested_by_cpu),
    .output_ra0(output_area_addr_for_display),
    // .input_wa(addr_from_keyboard),
    .output_wa(addr_from_cpu),
    .input_wd(data_from_keyboard),
    .output_wd(data_from_cpu),

    .input_rd0(input_area_for_display),
    .input_rd1(data_got_by_cpu),
    .output_rd0(output_area_for_display),
    .total_char_num(total_char_num)
    );

keyboard_input(
    .clk(clk_50mhz),
    .rst(rst),
    .PS2_CLK(PS2_CLK),
    .PS2_DATA(PS2_DATA),
    .data(data_from_keyboard),
    .valid_shock(we_from_keyboard),
    .key_code(key_code)
    );

endmodule
