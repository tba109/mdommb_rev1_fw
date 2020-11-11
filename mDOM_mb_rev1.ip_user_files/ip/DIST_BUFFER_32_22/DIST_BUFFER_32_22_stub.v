// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Tue Nov 10 12:33:44 2020
// Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/atfie/IceCube/mDOMDevelopment/mdommb_rev1_fw/mDOM_mb_rev1.srcs/sources_1/ip/DIST_BUFFER_32_22/DIST_BUFFER_32_22_stub.v
// Design      : DIST_BUFFER_32_22
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s100fgga676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.1" *)
module DIST_BUFFER_32_22(a, d, dpra, clk, we, qdpo)
/* synthesis syn_black_box black_box_pad_pin="a[4:0],d[21:0],dpra[4:0],clk,we,qdpo[21:0]" */;
  input [4:0]a;
  input [21:0]d;
  input [4:0]dpra;
  input clk;
  input we;
  output [21:0]qdpo;
endmodule
