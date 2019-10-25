`timescale 1ns / 1ps


module seg_display (
           input clk,   // 100MHz
           input rst,
           input [ 7: 0] has_dot ,            //  whether to display the dot
           input [ 7: 0] is_display ,            // whether to display the number
           input [31: 0] data_to_display,
           output reg [ 7: 0] seg ,
           output reg [ 7: 0] an
       );

reg [19: 0] count;
wire [ 6: 0] data_seg [7: 0];

bcdto7segment_dataflow seg0(.x(data_to_display[3: 0]), .seg(data_seg[0]));
bcdto7segment_dataflow seg1(.x(data_to_display[7: 4]), .seg(data_seg[1]));
bcdto7segment_dataflow seg2(.x(data_to_display[11: 8]), .seg(data_seg[2]));
bcdto7segment_dataflow seg3(.x(data_to_display[15: 12]), .seg(data_seg[3]));
bcdto7segment_dataflow seg4(.x(data_to_display[19: 16]), .seg(data_seg[4]));
bcdto7segment_dataflow seg5(.x(data_to_display[23: 20]), .seg(data_seg[5]));
bcdto7segment_dataflow seg6(.x(data_to_display[27: 24]), .seg(data_seg[6]));
bcdto7segment_dataflow seg7(.x(data_to_display[31: 28]), .seg(data_seg[7]));

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        an <= 8'b00000000;
        seg <= 8'b00000000;
        count <= 0;
    end

    else
    begin
        // when "count" counts 100000 times, switch to next seg,
        // so every seg is working 1 ms (100k/100M=1/1000s=1ms).
        if (count == 800000)
        begin
            an <= 8'b11111110;

            if (is_display[0]) seg <= {~has_dot[0], data_seg[0]};
            else seg <= {~has_dot[0], 7'b1111111};
            count <= 0;
        end

        else if (count == 700000)
        begin
            an <= 8'b11111101;

            if (is_display[1]) seg <= {~has_dot[1], data_seg[1]};
            else seg <= {~has_dot[1], 7'b1111111};
            count <= count + 1;
        end

        else if (count == 600000)
        begin
            an <= 8'b11111011;

            if (is_display[2]) seg <= {~has_dot[2], data_seg[2]};
            else seg <= {~has_dot[2], 7'b1111111};
            count <= count + 1;
        end

        else if (count == 500000)
        begin
            an <= 8'b11110111;

            if (is_display[3]) seg <= {~has_dot[3], data_seg[3]};
            else seg <= {~has_dot[3], 7'b1111111};
            count <= count + 1;
        end

        else if (count == 400000)
        begin
            an <= 8'b11101111;

            if (is_display[4]) seg <= {~has_dot[4], data_seg[4]};
            else seg <= {~has_dot[4], 7'b1111111};
            count <= count + 1;
        end

        else if (count == 300000)
        begin
            an <= 8'b11011111;

            if (is_display[5]) seg <= {~has_dot[5], data_seg[5]};
            else seg <= {~has_dot[5], 7'b1111111};
            count <= count + 1;
        end

        else if (count == 200000)
        begin
            an <= 8'b10111111;

            if (is_display[6]) seg <= {~has_dot[6], data_seg[6]};
            else seg <= {~has_dot[6], 7'b1111111};
            count <= count + 1;
        end

        else if (count == 100000)
        begin
            an <= 8'b01111111;

            if (is_display[7]) seg <= {~has_dot[7], data_seg[7]};
            else seg <= {~has_dot[7], 7'b1111111};
            count <= count + 1;
        end

        else count <= count + 1;
    end
end

endmodule
