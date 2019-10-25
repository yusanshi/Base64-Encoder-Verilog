`timescale 1ns / 1ps


module registers (
           input clk ,
           input rst ,
           input [ 4: 0] ra0, ra1, wa ,
           input we ,
           input [31: 0] wd ,
           output [31: 0] rd0, rd1,
           input [4:0] reg_addr_for_display,
           output [31:0] register_data_for_display
       );

reg [31: 0] reg_file[31: 0];
integer k;

always @ (negedge clk or posedge rst)
if (rst)
begin
    for (k = 0; k < 32; k = k + 1)
    reg_file[k] <= 0;
end
else 
  begin
    // reg_file[17] <= data_got_by_cpu;
    // reg_file[21] <= total_char_num;
    if (we && wa != 0) reg_file[wa] <= wd;
  end

assign rd0 = reg_file[ra0];
assign rd1 = reg_file[ra1];
assign register_data_for_display = reg_file[reg_addr_for_display];

// assign addr_requested_by_cpu = reg_file[16];
// assign we_from_cpu = reg_file[18];
// assign addr_from_cpu = reg_file[19];
// assign data_from_cpu_not_trans = reg_file[20];

endmodule