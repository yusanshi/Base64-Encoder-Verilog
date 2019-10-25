`timescale 1ns / 1ps


module Mux_2_to_1 #(parameter WIDTH = 32) (
           input [WIDTH - 1: 0] option_0,
           input [WIDTH - 1: 0] option_1,
           input choice ,
           output reg [WIDTH - 1: 0] result
       );

always @( * )

case (choice)
    1'b0: result = option_0;
    1'b1: result = option_1;
endcase

endmodule
