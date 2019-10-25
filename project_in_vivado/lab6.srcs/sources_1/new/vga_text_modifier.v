`timescale 1ns / 1ps

module vga_text_modifier (
           input clk ,
           input rst ,
           input [31: 0] register_data_for_display ,
           input [31:0] PC_for_display,
           input [31:0] instruction_for_display,
           input [6:0] input_area_for_display,
           input [6:0] output_area_for_display,
           output [12:0] input_area_addr_for_display,
           output [12:0] output_area_addr_for_display,
           output [31: 0] reg_addr_for_display ,
           output reg text_modify_enable,
           output [13: 0] char_count_to_change,
           output [15: 0] char_to_change_to
       );

reg [ 7: 0] x ;
reg [ 6: 0] y ;
wire [ 7: 0] x_ori ;
wire [ 6: 0] y_ori ;
reg [ 3: 0] number ;
wire [ 6: 0] ascii_from_number ;
reg [ 6: 0] ascii ;
reg is_from_number ;

assign char_count_to_change = (240*y+x) == 0 ? 16319: (240*y+x-1);
assign char_to_change_to = (is_from_number == 1) ? {9'b0, ascii_from_number} : {9'b0, ascii};
assign reg_addr_for_display = y-7;
assign input_area_addr_for_display = 80*(y-5)+x-14;
assign output_area_addr_for_display = 80*(y-5)+x-107;

number_to_ascii (number, ascii_from_number);


always @(posedge clk or posedge rst)
    if (rst) x <= 0;
    else x <= (x + 1 == 240) ? 0 : (x + 1);


always @(posedge clk or posedge rst)
    if (rst) y <= 0;
    else y <= (x + 1 == 240) ? ((y + 1 == 68) ? 0 : y + 1) : y;


always @(posedge clk or posedge rst)
    if (rst) text_modify_enable <= 0;
    else
    begin
        if (y >= 7 && y < 39 && x >= 220 && x < 228)
        begin
            text_modify_enable <= 1; is_from_number <= 1;
            number <= register_data_for_display[31 - 4 * (x - 220) -: 4];
        end
        else if (y == 44 && x>=217 && x < 225)
        begin
            text_modify_enable <= 1; is_from_number <= 1;
            number <= instruction_for_display[31 - 4 * (x - 217) -: 4];
        end
        else if (y == 45 && x>=217 && x < 225)
        begin
            text_modify_enable <= 1; is_from_number <= 1;
            number <= PC_for_display[31 - 4 * (x - 217) -: 4];
        end
        // else if (y>=5 && y<65 && x>=14 && x<94)
        else if (y>=5 && y<7 && x>=14 && x<94)
        begin
          text_modify_enable <= 1; is_from_number <= 0;
          ascii <= input_area_for_display;
        end
        // else if (y>=5 && y<65 && x>=107 && x<187)
        else if (y>=5 && y<7 && x>=107 && x<187)
        begin
          text_modify_enable <= 1; is_from_number <= 0;
          ascii <= output_area_for_display;
        end
        else text_modify_enable <= 0;
    end

endmodule
