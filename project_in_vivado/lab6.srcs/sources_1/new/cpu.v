`timescale 1ns / 1ps

module cpu (
					 input clk,
					 input rst,
					 input [31:0] reg_addr_for_display,
					 output [31:0] register_data_for_display,
					 output [31:0] PC_for_display,
					 output [31:0] instruction_for_display,

					// text area
					 input [6:0] data_got_by_cpu, 
					 output [12:0] addr_requested_by_cpu,
					 input [12:0] total_char_num,

					 // base64 area
					 output we_from_cpu,
					 output [12:0] addr_from_cpu,
					 output [6:0] data_from_cpu
			 );

wire [31: 0] read_data_1;
wire [31: 0] read_data_2;
wire [31: 0] ALU_result;
wire [31: 0] data_memory_output;
wire [31: 0] instruction_memory_output;
wire [31: 0] no_name_1;
wire [31: 0] no_name_2;
wire [31: 0] no_name_3;
wire [31: 0] no_name_4;
wire [31: 0] no_name_5;
wire [31: 0] no_name_6;
wire [31: 0] ResultW;
wire [31: 0] PC;
wire [31: 0] PCF;
wire [31: 0] PCPlus4F;
wire StallF;
wire [31: 0] InstrD ;
wire RegWriteD ;
wire MemtoRegD ;
wire MemWriteD ;
wire [ 3: 0] ALUControlD;
wire ALUSrcD ;
wire RegDstD ;
wire BranchD ;
wire JumpD;
wire RealBranchD ;
wire [ 4: 0] RsD ;
wire [ 4: 0] RtD ;
wire [ 4: 0] RdD ;
wire I_agree_to_branch ;
wire [31: 0] PCPlus4D ;
wire [31: 0] PCBranchD ;
wire [31: 0] SignImmD;
wire StallD;
wire ForwardAD;
wire ForwardBD;
wire RegWriteE ;
wire MemtoRegE ;
wire MemWriteE ;
wire [ 3: 0] ALUControlE;
wire ALUSrcE ;
wire RegDstE ;
wire [ 4: 0] RsE;
wire [ 4: 0] RtE;
wire [ 4: 0] RdE;
wire [31: 0] SrcAE;
wire [31: 0] SrcBE;
wire [31: 0] WriteDataE;
wire [ 4: 0] WriteRegE;
wire [31: 0] SignImmE;
wire FlushE;
wire [1: 0] ForwardAE;
wire [1: 0] ForwardBE;
wire RegWriteM;
wire MemtoRegM;
wire MemWriteM;
wire [31: 0] ALUOutM;
wire [31: 0] WriteDataM;
wire [ 4: 0] WriteRegM;
wire RegWriteW;
wire MemtoRegW;
wire [31: 0] ReadDataW;
wire [31: 0] ALUOutW;
wire [ 4: 0] WriteRegW;
wire [6:0] data_from_cpu_not_trans;

assign PC_for_display = PCF;
assign instruction_for_display = InstrD;
// assign no_name_1 = read_data_1;
// assign no_name_3 = read_data_2;
assign no_name_1 = no_name_2;
assign no_name_3 = no_name_4;
assign RsD = InstrD[25: 21];
assign RtD = InstrD[20: 16];
assign RdD = InstrD[15: 11];
assign RealBranchD = BranchD & I_agree_to_branch;
assign I_agree_to_branch =
			 (InstrD[31:26] == 6'b000100) ? (no_name_2 == no_name_4) :
			 (InstrD[31:26] == 6'b000101) ? (no_name_2 != no_name_4) :
			 0;

Sign_extend #(16, 32) Sign_extend(
								.not_extend(InstrD[15: 0]),
								.extended(SignImmD)
						);

ALU #(32) ALU_in_IF(
				.a(PCF),
				.b(4),
				.ALUControl(4'b0010),
				.y(PCPlus4F)
		);

ALU #(32) ALU_in_ID(
				.a({SignImmD[29: 0], 2'b00}),
				.b(PCPlus4D),
				.ALUControl(4'b0010),
				.y(PCBranchD)
		);

ALU #(32) ALU_in_EX(
				.a(SrcAE),
				.b(SrcBE),
				.ALUControl(ALUControlE),
				.y(ALU_result)
		);


Mux_2_to_1 #(32) Mux_in_WB(
							 .option_0(ALUOutW),
							 .option_1(ReadDataW),
							 .choice(MemtoRegW),
							 .result(ResultW)
					 );

Mux_2_to_1 #(32) Mux_in_ID_for_no_name_first(
							 .option_0(read_data_1),
							 .option_1(ALUOutM),
							 .choice(ForwardAD),
							 .result(no_name_2)
					 );

Mux_2_to_1 #(32) Mux_in_ID_for_no_name_second(
							 .option_0(read_data_2),
							 .option_1(ALUOutM),
							 .choice(ForwardBD),
							 .result(no_name_4)
					 );

Mux_2_to_1 #(32) Mux_in_EX_for_SrcBE(
							 .option_0(WriteDataE),
							 .option_1(SignImmE),
							 .choice(ALUSrcE),
							 .result(SrcBE)
					 );

Mux_2_to_1 #(5) Mux_in_EX_for_WriteRegE(
							 .option_0(RtE),
							 .option_1(RdE),
							 .choice(RegDstE),
							 .result(WriteRegE)
					 );

Mux_4_to_1 #(32) Mux_in_IF (
							 .option_0(PCPlus4F ),
							 .option_1(PCBranchD ),
							 .option_2({PCPlus4D[31: 28], InstrD[25: 0], 2'b00}),
							 .option_3(0 ),
							 .choice ({JumpD, RealBranchD} ),
							 .result (PC )
					 );

Mux_4_to_1 #(32) Mux_in_EX_for_SrcAE(
							 .option_0(no_name_5),
							 .option_1(ResultW),
							 .option_2(ALUOutM),
							 .option_3(0),
							 .choice(ForwardAE),
							 .result(SrcAE)
					 );

Mux_4_to_1 #(32) Mux_in_EX_for_WriteDataE(
							 .option_0(no_name_6),
							 .option_1(ResultW),
							 .option_2(ALUOutM),
							 .option_3(0),
							 .choice(ForwardBE),
							 .result(WriteDataE)
					 );

PC_register PC_register (
								.clk(clk),
								.rst(rst),
								.en(~StallF),
								.PC_input(PC),
								.PC_output(PCF)
						);

IF_ID IF_ID(
					.clk(clk),
					.rst(rst),
					.clr(RealBranchD),
					.en(~StallD),
					.instruction_memory_output(instruction_memory_output),
					.PCPlus4F(PCPlus4F),
					.InstrD(InstrD),
					.PCPlus4D(PCPlus4D)
			);

ID_EX ID_EX (
					.clk (clk),
					.rst (rst),
					.clr (FlushE),
					.RegWriteD (RegWriteD ),
					.MemtoRegD (MemtoRegD ),
					.MemWriteD (MemWriteD ),
					.ALUControlD(ALUControlD),
					.ALUSrcD (ALUSrcD ),
					.RegDstD (RegDstD ),
					.no_name_1 (no_name_1 ),
					.no_name_3 (no_name_3 ),
					.RsD (RsD ),
					.RtD (RtD ),
					.RdD (RdD ),
					.SignImmD (SignImmD ),
					.RegWriteE (RegWriteE ),
					.MemtoRegE (MemtoRegE ),
					.MemWriteE (MemWriteE ),
					.ALUControlE(ALUControlE),
					.ALUSrcE (ALUSrcE ),
					.RegDstE (RegDstE ),
					.no_name_5 (no_name_5 ),
					.no_name_6 (no_name_6 ),
					.RsE (RsE ),
					.RtE (RtE ),
					.RdE (RdE ),
					.SignImmE (SignImmE )
			);

EX_MEM EX_MEM (
					 .clk (clk ),
					 .rst(rst),
					 .RegWriteE (RegWriteE ),
					 .MemtoRegE (MemtoRegE ),
					 .MemWriteE (MemWriteE ),
					 .ALU_result(ALU_result),
					 .WriteDataE(WriteDataE),
					 .WriteRegE (WriteRegE ),
					 .RegWriteM (RegWriteM ),
					 .MemtoRegM (MemtoRegM ),
					 .MemWriteM (MemWriteM ),
					 .ALUOutM (ALUOutM ),
					 .WriteDataM(WriteDataM),
					 .WriteRegM (WriteRegM )
			 );

MEM_WB MEM_WB (
					 .clk (clk ),
					 .rst(rst),
					 .RegWriteM (RegWriteM ),
					 .MemtoRegM (MemtoRegM ),
					 .data_memory_output(data_memory_output),
					 .ALUOutM (ALUOutM ),
					 .WriteRegM (WriteRegM ),
					 .RegWriteW (RegWriteW ),
					 .MemtoRegW (MemtoRegW ),
					 .ReadDataW (ReadDataW ),
					 .ALUOutW (ALUOutW ),
					 .WriteRegW (WriteRegW )
			 );


control control(
						.Op(InstrD[31: 26]),
						.Funct(InstrD[5: 0]),
						.RegWriteD(RegWriteD),
						.MemtoRegD(MemtoRegD),
						.MemWriteD(MemWriteD),
						.ALUControlD(ALUControlD),
						.ALUSrcD(ALUSrcD),
						.RegDstD(RegDstD),
						.BranchD(BranchD),
						.JumpD(JumpD)
				);


// TODO

registers registers(
							.clk(clk),
							.rst(rst),
							.ra0(InstrD[25: 21]),
							.ra1(InstrD[20: 16]),
							.wa(WriteRegW),
							.we(RegWriteW),
							.wd(ResultW),
							.rd0(read_data_1),
							.rd1(read_data_2),
							.reg_addr_for_display(reg_addr_for_display),
							.register_data_for_display(register_data_for_display)
					);

base64_rom base64_rom(data_from_cpu_not_trans, data_from_cpu);

memory memory(
				.clk(clk),
				.we(MemWriteM),
				.addr(ALUOutM),
				.data_input(WriteDataM),
				.data_output(data_memory_output),
				.addr_for_instruction(PCF),
				.data_for_instruction(instruction_memory_output),
				
				.addr_requested_by_cpu(addr_requested_by_cpu),
				.data_got_by_cpu(data_got_by_cpu),
				.total_char_num(total_char_num),
				.we_from_cpu(we_from_cpu),
				.addr_from_cpu(addr_from_cpu),
				.data_from_cpu_not_trans(data_from_cpu_not_trans)
			);

hazard hazard (
	.rst      (rst      ),
	.BranchD  (BranchD  ),
	.JumpD    (JumpD    ),
	.MemtoRegE(MemtoRegE),
	.MemtoRegM(MemtoRegM),
	.RegWriteE(RegWriteE),
	.RegWriteM(RegWriteM),
	.RegWriteW(RegWriteW),
	.WriteRegE(WriteRegE),
	.WriteRegM(WriteRegM),
	.WriteRegW(WriteRegW),
	.RsD      (RsD      ),
	.RtD      (RtD      ),
	.RsE      (RsE      ),
	.RtE      (RtE      ),
	.StallF   (StallF   ),
	.StallD   (StallD   ),
	.ForwardAD(ForwardAD),
	.ForwardBD(ForwardBD),
	.FlushE   (FlushE   ),
	.ForwardAE(ForwardAE),
	.ForwardBE(ForwardBE)
);

endmodule





