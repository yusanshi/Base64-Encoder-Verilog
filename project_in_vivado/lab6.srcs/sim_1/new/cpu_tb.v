`timescale 1ns / 1ps

module cpu_tb ();
reg clk ;
reg rst ;
wire [6:0] data_got_by_cpu;
wire [12:0] total_char_num;

wire [12:0] addr_requested_by_cpu;
wire we_from_cpu;
wire [12:0] addr_from_cpu;
wire [6:0] data_from_cpu;

cpu cpu (
        .clk (clk ),
        .rst (rst ),
        .data_got_by_cpu(data_got_by_cpu),
        .total_char_num(total_char_num),
        .addr_requested_by_cpu(addr_requested_by_cpu),
        .we_from_cpu(we_from_cpu),
        .addr_from_cpu(addr_from_cpu),
        .data_from_cpu(data_from_cpu)
    );

assign total_char_num = 19;

assign data_got_by_cpu =
(addr_requested_by_cpu == 0) ? 121:
(addr_requested_by_cpu == 1) ? 117:
(addr_requested_by_cpu == 2) ? 108:
(addr_requested_by_cpu == 3) ? 101:
(addr_requested_by_cpu == 4) ? 105:
(addr_requested_by_cpu == 5) ? 50:
(addr_requested_by_cpu == 6) ? 48:
(addr_requested_by_cpu == 7) ? 49:
(addr_requested_by_cpu == 8) ? 56:
(addr_requested_by_cpu == 9) ? 64:
(addr_requested_by_cpu == 10) ? 103:
(addr_requested_by_cpu == 11) ? 109:
(addr_requested_by_cpu == 12) ? 97:
(addr_requested_by_cpu == 13) ? 105:
(addr_requested_by_cpu == 14) ? 108:
(addr_requested_by_cpu == 15) ? 46:
(addr_requested_by_cpu == 16) ? 99:
(addr_requested_by_cpu == 17) ? 111:
(addr_requested_by_cpu == 18) ? 109: 0;

// input: yulei2018@gmail.com
// output: eXVsZWkyMDE4QGdtYWlsLmNvbQ==

// yulei2018@gmail.com
// 0:ascii = 121;
// 1:ascii = 117;
// 2:ascii = 108;
// 3:ascii = 101;
// 4:ascii = 105;
// 5:ascii = 50;
// 6:ascii = 48;
// 7:ascii = 49;
// 8:ascii = 56;
// 9:ascii = 64;
// 10:ascii = 103;
// 11:ascii = 109;
// 12:ascii = 97;
// 13:ascii = 105;
// 14:ascii = 108;
// 15:ascii = 46;
// 16:ascii = 99;
// 17:ascii = 111;
// 18:ascii = 109;

// eXVsZWkyMDE4QGdtYWlsLmNvbQ==
// 0:ascii = 101;
// 1:ascii = 88;
// 2:ascii = 86;
// 3:ascii = 115;
// 4:ascii = 90;
// 5:ascii = 87;
// 6:ascii = 107;
// 7:ascii = 121;
// 8:ascii = 77;
// 9:ascii = 68;
// 10:ascii = 69;
// 11:ascii = 52;
// 12:ascii = 81;
// 13:ascii = 71;
// 14:ascii = 100;
// 15:ascii = 116;
// 16:ascii = 89;
// 17:ascii = 87;
// 18:ascii = 108;
// 19:ascii = 115;
// 20:ascii = 76;
// 21:ascii = 109;
// 22:ascii = 78;
// 23:ascii = 118;
// 24:ascii = 98;
// 25:ascii = 81;
// 26:ascii = 61;
// 27:ascii = 61;


integer k;

initial
begin
    clk = 0;
    rst = 1;
    #2 rst = 0;

    for (k = 0; k < 5000; k = k + 1)
    begin
        #2 clk = ~clk;
    end

end

endmodule
