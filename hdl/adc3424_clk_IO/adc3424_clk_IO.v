// Aaron Fienberg
// November 2020
//
// clk IO for ADC3424 chips on the mDOM mainboard
//
// handles CLOCK, SYSRF, DCLK, FCLK
//
// handled with ODDR -> OBUFDS
// see page 128 of https://www.xilinx.com/support/documentation/user_guides/ug471_7Series_SelectIO.pdf
// also https://forums.xilinx.com/t5/Other-FPGA-Architecture/drive-clock-out-from-FPGA/td-p/838391
// and  https://forums.xilinx.com/t5/Other-FPGA-Architecture/Output-differential-clock-kintex-7/td-p/771524


module ADC3424_clk_IO
(
  input enc_clk,

  input dclk_P,
  input dclk_N,
  output dclk_out,

  input fclk_P,
  input fclk_N,
  output fclk_out,

  output adc_clk_P,
  output adc_clk_N,
  output sysrf_P,
  output sysrf_N
);

wire oddr_clk_q;
ODDR #(
       .DDR_CLK_EDGE("OPPOSITE_EDGE"),
       .INIT(1'b0),
       .SRTYPE("SYNC")
     )
clk_forward
(
  .Q(oddr_clk_q),
  .C(enc_clk),
  .D1(1'b0),
  .D2(1'b1),
  .CE(1'b1),
  .R(1'b0),
  .S(1'b0)
);
OBUFDS OBUF_ADC_CLOCK(.I(oddr_clk_q), .O(adc_clk_P), .OB(adc_clk_N));

wire oddr_sysrf_q;
ODDR #(
       .DDR_CLK_EDGE("OPPOSITE_EDGE"),
       .INIT(1'b0),
       .SRTYPE("SYNC")
     )
sysrf_forward
(
  .Q(oddr_sysrf_q),
  .C(enc_clk),
  .D1(1'b0),
  .D2(1'b1),
  .CE(1'b1),
  .R(1'b0),
  .S(1'b0)
);
OBUFDS OBUF_ADC_SYSRF(.I(oddr_sysrf_q), .O(sysrf_P), .OB(sysrf_N));

IBUFGDS IBUFGDS_DCLOCK(.I(dclk_P), .IB(dclk_N), .O(dclk_out));
IBUFGDS IBUFGDS_FCLOCK(.I(fclk_P), .IB(fclk_N), .O(fclk_out));

endmodule