`timescale 1ns / 1ps


module memory(
           input clk,
           input we,
           input [31: 0] addr,
           input [31: 0] data_input,
           output [31: 0] data_output,

           input [31:0] addr_for_instruction,
           output [31:0] data_for_instruction,

           output [12:0] addr_requested_by_cpu,
           input [6:0] data_got_by_cpu,
           input [12:0] total_char_num,
           output we_from_cpu,
           output [12:0] addr_from_cpu,
           output [6:0] data_from_cpu_not_trans
       );

reg [31:0] mem_1024;
wire [31:0] mem_1028;
reg [31:0] mem_1032;
reg [31:0] mem_1036;
reg [31:0] mem_1040;
wire [31:0] mem_1044;

wire is_inner;

wire we_inner;
wire we_exter;

wire [31:0] out_inner;
reg [31:0] out_exter;

assign is_inner = addr < 1024;

assign addr_requested_by_cpu = mem_1024;
assign mem_1028 = data_got_by_cpu;
assign we_from_cpu = mem_1032;
assign addr_from_cpu = mem_1036;
assign data_from_cpu_not_trans = mem_1040;
assign mem_1044 = total_char_num;

always @(posedge clk)
begin
case (addr)
    1024: mem_1024 <=  (we_exter) ? data_input:mem_1024;
    1028: out_exter <= mem_1028;
    1032: mem_1032 <=  (we_exter) ? data_input:mem_1032;
    1036: mem_1036 <=  (we_exter) ? data_input:mem_1036;
    1040: mem_1040 <=  (we_exter) ? data_input:mem_1040;
    1044: out_exter <= mem_1044;
  endcase
end

assign data_output = (is_inner)? out_inner:out_exter;
assign we_inner = (is_inner)? we:0;
assign we_exter = (is_inner)? 0:we;

dist_mem_gen_0 DIST_MEM_GEN_0 (
                   .a (addr>>2),
                   .d (data_input),
                   .clk (clk),
                   .we (we_inner),
                   .spo (out_inner),

                   .dpra(addr_for_instruction>>2),
                   .dpo(data_for_instruction)
               );
endmodule
