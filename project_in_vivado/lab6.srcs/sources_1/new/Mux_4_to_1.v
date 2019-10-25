`timescale 1ns / 1ps

module Mux_4_to_1 #(parameter WIDTH = 32) (
           input [WIDTH - 1: 0] option_0,
           input [WIDTH - 1: 0] option_1,
           input [WIDTH - 1: 0] option_2,
           input [WIDTH - 1: 0] option_3,
           input [ 1: 0] choice ,
           output reg [WIDTH - 1: 0] result
       );

always @( * )

case (choice)
    2'b00: result = option_0;
    2'b01: result = option_1;
    2'b10: result = option_2;
    2'b11: result = option_3;
endcase

endmodule
