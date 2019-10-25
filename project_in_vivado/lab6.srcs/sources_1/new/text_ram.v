`timescale 1ns / 1ps

module text_ram(
    input clk,
    input rst,
    input input_we,
    input output_we,
    input [12:0] input_ra0,
    input [12:0] input_ra1,
    input [12:0] output_ra0,
    // input [12:0] input_wa,
    input [12:0] output_wa,
    input [6:0] input_wd,
    input [6:0] output_wd,

    output [6:0] input_rd0,
    output [6:0] input_rd1,
    output [6:0] output_rd0,

    output [12:0] total_char_num
    );

// base64_text_ram (
//     .a(output_wa),
//     .d(output_wd),
//     .dpra(output_ra0),
//     .clk(clk),
//     .we(output_we),
//     .dpo(output_rd0)
//     );

// reg [6:0] input_area_storage [4799:0];
// reg [6:0] output_area_storage [4799:0];
reg [6:0] input_area_storage [159:0];
reg [6:0] output_area_storage [159:0];
// reg [6:0] input_area_storage [1:0];
// reg [6:0] output_area_storage [1:0];
integer i;
integer j;
reg [12:0] input_count;

assign total_char_num = input_count;

always @ (posedge clk or posedge rst)
if (rst)
begin
    input_count <= 0;
    for (i=0; i<4800; i = i+1)
    begin
        input_area_storage[i] <= 0;
    end
end
else if (input_we) 
    begin
        if (input_wd == 8)
        begin
			if (input_count == 0) begin input_count <= 0; input_area_storage[0] <= 0; end
			else begin input_count <= input_count-1; input_area_storage[input_count-1] <= 0; end
        end
        else
        begin
            input_count <= input_count+1;
            input_area_storage[input_count] <= input_wd;
        end
    end

always @ (posedge clk or posedge rst)
if (rst)
begin
    for (j=0; j<4800; j = j+1)
    begin
        output_area_storage[j] <= 0;
    end
end
else if (output_we)
    begin
        output_area_storage[output_wa] <= output_wd;
    end

assign input_rd0 = input_area_storage[input_ra0];
assign input_rd1 = input_area_storage[input_ra1];
assign output_rd0 = output_area_storage[output_ra0];

endmodule
