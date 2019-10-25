`timescale 1ns / 1ps

module vga_mode (
           input [20: 0] vaddr ,
           input [10: 0] vaddr_x ,
           input [10: 0] vaddr_y ,
           output is_text_mode
       );

assign is_text_mode = (vaddr_x < 6 || vaddr_x > 1913 || vaddr_y < 6 || vaddr_y > 1073)
                        ? 0:1;

endmodule

