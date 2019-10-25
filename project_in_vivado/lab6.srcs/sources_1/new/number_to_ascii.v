`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2019 07:50:37 PM
// Design Name: 
// Module Name: number_to_ascii
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module number_to_ascii(
    input [3:0] number,
    output [6:0] ascii
    );

    number_to_lowercase_ascii (
        .a(number), 
        .spo(ascii)
        );

    
endmodule
