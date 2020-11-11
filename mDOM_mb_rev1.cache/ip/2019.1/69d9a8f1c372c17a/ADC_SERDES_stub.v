// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Tue Nov 10 17:30:52 2020
// Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ADC_SERDES_stub.v
// Design      : ADC_SERDES
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s100fgga676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(data_in_from_pins_p, data_in_from_pins_n, 
  data_in_to_device, in_delay_reset, in_delay_data_ce, in_delay_data_inc, in_delay_tap_in, 
  in_delay_tap_out, bitslip, clk_in, clk_div_in, io_reset)
/* synthesis syn_black_box black_box_pad_pin="data_in_from_pins_p[0:0],data_in_from_pins_n[0:0],data_in_to_device[5:0],in_delay_reset,in_delay_data_ce[0:0],in_delay_data_inc[0:0],in_delay_tap_in[4:0],in_delay_tap_out[4:0],bitslip[0:0],clk_in,clk_div_in,io_reset" */;
  input [0:0]data_in_from_pins_p;
  input [0:0]data_in_from_pins_n;
  output [5:0]data_in_to_device;
  input in_delay_reset;
  input [0:0]in_delay_data_ce;
  input [0:0]in_delay_data_inc;
  input [4:0]in_delay_tap_in;
  output [4:0]in_delay_tap_out;
  input [0:0]bitslip;
  input clk_in;
  input clk_div_in;
  input io_reset;
endmodule
