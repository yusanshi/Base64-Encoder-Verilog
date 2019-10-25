`timescale 1ns / 1ps


module hazard (
  input            rst      ,
  input            BranchD  ,
  input            JumpD    ,
  input            MemtoRegE,
  input            MemtoRegM,
  input            RegWriteE,
  input            RegWriteM,
  input            RegWriteW,
  input      [4:0] WriteRegE,
  input      [4:0] WriteRegM,
  input      [4:0] WriteRegW,
  input      [4:0] RsD      ,
  input      [4:0] RtD      ,
  input      [4:0] RsE      ,
  input      [4:0] RtE      ,
  output        StallF   ,
  output        StallD   ,
  output        FlushE   ,
  output        ForwardAD,
  output        ForwardBD,
  output  [1:0] ForwardAE,
  output  [1:0] ForwardBE
);

wire lwstall;
wire branchstall;

assign lwstall = ((RsD == RtE) | (RtD == RtE)) & MemtoRegE;
assign branchstall = (BranchD & RegWriteE & (WriteRegE == RsD | WriteRegE == RtD)) | (BranchD & MemtoRegM & (WriteRegM == RsD | WriteRegM == RtD));
assign StallF = lwstall | branchstall;
assign StallD = lwstall | branchstall;
assign FlushE = lwstall | branchstall;
assign ForwardAD = (RsD != 0) & (RsD == WriteRegM) & RegWriteM;
assign ForwardBD = (RtD != 0) & (RtD == WriteRegM) & RegWriteM;
assign ForwardAE = ((RsE != 0) & (RsE == WriteRegM) & RegWriteM) ? 2'b10 :
       ((RsE != 0) & (RsE == WriteRegW) & RegWriteW) ? 2'b01 :
       2'b00;
assign ForwardBE = ((RtE != 0) & (RtE == WriteRegM) & RegWriteM) ? 2'b10 :
       ((RtE != 0) & (RtE == WriteRegW) & RegWriteW) ? 2'b01 :
       2'b00;

endmodule
