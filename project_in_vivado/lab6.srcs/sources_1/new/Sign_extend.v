`timescale 1ns / 1ps


module Sign_extend #(parameter FROM = 16, TO = 32) (
           input [FROM - 1: 0] not_extend,
           output reg [ TO - 1: 0] extended
       );
always @( * )
begin
    if (TO > FROM) extended = {{(TO - FROM){not_extend[FROM - 1]}}, not_extend};
    else extended = not_extend;
end

endmodule
