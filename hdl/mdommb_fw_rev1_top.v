// Aaron Fienberg
// November 2020
//
// Top level module for the rev1 mDOM mainboard
//

module top (
  // 20 MHz oscillator
	input QOSC_CLK_P1V8,

  // Debug UART signals
	output FTD_UART_CTSn,
  input FTD_UART_RTSn,
  output FTD_UART_RXD,
  input FTD_UART_TXD,

  // ADC interface
  output ADC0_CLOCK_P,
  output ADC0_CLOCK_M,
  input ADC0_DA0P,
  input ADC0_DA0M,
  input ADC0_DA1P,
  input ADC0_DA1M,
  input ADC0_DB0P,
  input ADC0_DB0M,
  input ADC0_DB1P,
  input ADC0_DB1M,
  input ADC0_DC0P,
  input ADC0_DC0M,
  input ADC0_DC1P,
  input ADC0_DC1M,
  input ADC0_DCLK_P,
  input ADC0_DCLK_M,
  input ADC0_DD0P,
  input ADC0_DD0M,
  input ADC0_DD1P,
  input ADC0_DD1M,
  input ADC0_FCLK_P,
  input ADC0_FCLK_M,
  input ADC0_SDOUT,
  output ADC0_SEN,
  output ADC0_SYSRF_P,
  output ADC0_SYSRF_M,
  output ADC1_CLOCK_P,
  output ADC1_CLOCK_M,
  input ADC1_DA0P,
  input ADC1_DA0M,
  input ADC1_DA1P,
  input ADC1_DA1M,
  input ADC1_DB0P,
  input ADC1_DB0M,
  input ADC1_DB1P,
  input ADC1_DB1M,
  input ADC1_DC0P,
  input ADC1_DC0M,
  input ADC1_DC1P,
  input ADC1_DC1M,
  input ADC1_DCLK_P,
  input ADC1_DCLK_M,
  input ADC1_DD0P,
  input ADC1_DD0M,
  input ADC1_DD1P,
  input ADC1_DD1M,
  input ADC1_FCLK_P,
  input ADC1_FCLK_M,
  output ADC1_SEN,
  output ADC1_SYSRF_P,
  output ADC1_SYSRF_M,
  output ADC2_CLOCK_P,
  output ADC2_CLOCK_M,
  input ADC2_DA0P,
  input ADC2_DA0M,
  input ADC2_DA1P,
  input ADC2_DA1M,
  input ADC2_DB0P,
  input ADC2_DB0M,
  input ADC2_DB1P,
  input ADC2_DB1M,
  input ADC2_DC0P,
  input ADC2_DC0M,
  input ADC2_DC1P,
  input ADC2_DC1M,
  input ADC2_DCLK_P,
  input ADC2_DCLK_M,
  input ADC2_DD0P,
  input ADC2_DD0M,
  input ADC2_DD1P,
  input ADC2_DD1M,
  input ADC2_FCLK_P,
  input ADC2_FCLK_M,
  output ADC2_SEN,
  output ADC2_SYSRF_P,
  output ADC2_SYSRF_M,
  output ADC3_CLOCK_P,
  output ADC3_CLOCK_M,
  input ADC3_DA0P,
  input ADC3_DA0M,
  input ADC3_DA1P,
  input ADC3_DA1M,
  input ADC3_DB0P,
  input ADC3_DB0M,
  input ADC3_DB1P,
  input ADC3_DB1M,
  input ADC3_DC0P,
  input ADC3_DC0M,
  input ADC3_DC1P,
  input ADC3_DC1M,
  input ADC3_DCLK_P,
  input ADC3_DCLK_M,
  input ADC3_DD0P,
  input ADC3_DD0M,
  input ADC3_DD1P,
  input ADC3_DD1M,
  input ADC3_FCLK_P,
  input ADC3_FCLK_M,
  output ADC3_SEN,
  output ADC3_SYSRF_P,
  output ADC3_SYSRF_M,
  output ADC4_CLOCK_P,
  output ADC4_CLOCK_M,
  input ADC4_DA0P,
  input ADC4_DA0M,
  input ADC4_DA1P,
  input ADC4_DA1M,
  input ADC4_DB0P,
  input ADC4_DB0M,
  input ADC4_DB1P,
  input ADC4_DB1M,
  input ADC4_DC0P,
  input ADC4_DC0M,
  input ADC4_DC1P,
  input ADC4_DC1M,
  input ADC4_DCLK_P,
  input ADC4_DCLK_M,
  input ADC4_DD0P,
  input ADC4_DD0M,
  input ADC4_DD1P,
  input ADC4_DD1M,
  input ADC4_FCLK_P,
  input ADC4_FCLK_M,
  output ADC4_SEN,
  output ADC4_SYSRF_P,
  output ADC4_SYSRF_M,
  output ADC5_CLOCK_P,
  output ADC5_CLOCK_M,
  input ADC5_DA0P,
  input ADC5_DA0M,
  input ADC5_DA1P,
  input ADC5_DA1M,
  input ADC5_DB0P,
  input ADC5_DB0M,
  input ADC5_DB1P,
  input ADC5_DB1M,
  input ADC5_DC0P,
  input ADC5_DC0M,
  input ADC5_DC1P,
  input ADC5_DC1M,
  input ADC5_DCLK_P,
  input ADC5_DCLK_M,
  input ADC5_DD0P,
  input ADC5_DD0M,
  input ADC5_DD1P,
  input ADC5_DD1M,
  input ADC5_FCLK_P,
  input ADC5_FCLK_M,
  output ADC5_SEN,
  output ADC5_SYSRF_P,
  output ADC5_SYSRF_M,
  output ADC_RESET,
  output ADC_SCLK,
  output ADC_SDATA,

  // Discriminators
  input DISCR_OUT0,
  input DISCR_OUT1,
  input DISCR_OUT2,
  input DISCR_OUT3,
  input DISCR_OUT4,
  input DISCR_OUT5,
  input DISCR_OUT6,
  input DISCR_OUT7,
  input DISCR_OUT8,
  input DISCR_OUT9,
  input DISCR_OUT10,
  input DISCR_OUT11,
  input DISCR_OUT12,
  input DISCR_OUT13,
  input DISCR_OUT14,
  input DISCR_OUT15,
  input DISCR_OUT16,
  input DISCR_OUT17,
  input DISCR_OUT18,
  input DISCR_OUT19,
  input DISCR_OUT20,
  input DISCR_OUT21,
  input DISCR_OUT22,
  input DISCR_OUT23
);
`include "mDOM_trig_bundle_inc.v"
`include "mDOM_wvb_conf_bundle_inc.v"

localparam[15:0] FW_VNUM = 16'h1;

// number of ADC channels
localparam N_CHANNELS = 24;
localparam N_ADC_BITS = 12;
localparam N_DISCR_BITS = 8;

// determines waveform buffer depths
// start with depth of 1024 samples; can increase later
localparam P_WVB_ADR_WIDTH = 10;

localparam P_HDR_WIDTH = P_WVB_ADR_WIDTH == 10 ? 71 : 80;

//
// clock generation
//

// generate 125 MHz, 200 MHz, 375 MHz, 500 MHz clocks
wire lclk_adcclk_locked;
wire idelay_discrclk_locked;
wire clk_100MHz;
wire clk_125MHz;
wire clk_200MHz;
wire clk_375MHz;
wire clk_500MHz;
lclk_adcclk_wiz LCLK_ADCCLK_WIZ_0
  (
   .clk_in1(QOSC_CLK_P1V8),
   .clk_out1(clk_125MHz),
   .clk_out2(clk_375MHz),
   .locked(lclk_adcclk_locked),
   .reset(1'b0)
  );
wire lclk = clk_125MHz;
wire lclk_rst = !lclk_adcclk_locked;
assign i_adc_clock = clk_125MHz;

wire discr_fclk_125MHz;
idelay_discr_clk_wiz IDELAY_DISCR_CLK_WIZ_0
  (
   .clk_in1(QOSC_CLK_P1V8),
   .clk_out1(clk_200MHz),
   .clk_out2(clk_500MHz),
   .clk_out3(discr_fclk_125MHz),
   .clk_out4(clk_100MHz),
   .locked(idelay_discrclk_locked),
   .reset(1'b0)
  );

// IDELAY control; this should automatically be replicated to all banks where it is needed
// (see https://forums.xilinx.com/t5/Memory-Interfaces-and-NoC/IDELAYCTRL-in-Kintex-MIG/m-p/524885#M6824)
IDELAYCTRL delayctrl(.RDY(idelayctrl_rdy),.REFCLK(clk_200MHz),.RST(!idelay_discrclk_locked));

// Input clocks and clock forwarding
// Handled with ODDR -> OBUFDS
// see page 128 of https://www.xilinx.com/support/documentation/user_guides/ug471_7Series_SelectIO.pdf
// also https://forums.xilinx.com/t5/Other-FPGA-Architecture/drive-clock-out-from-FPGA/td-p/838391
// and  https://forums.xilinx.com/t5/Other-FPGA-Architecture/Output-differential-clock-kintex-7/td-p/771524
wire[5:0] adc_clk_P = {ADC5_CLOCK_P, ADC4_CLOCK_P,
                       ADC3_CLOCK_P, ADC2_CLOCK_P,
                       ADC1_CLOCK_P, ADC0_CLOCK_P};
wire[5:0] adc_clk_N = {ADC5_CLOCK_M, ADC4_CLOCK_M,
                       ADC3_CLOCK_M, ADC2_CLOCK_M,
                       ADC1_CLOCK_M, ADC0_CLOCK_M};
wire[5:0] adc_sysrf_P = {ADC5_SYSRF_P, ADC4_SYSRF_P,
                         ADC3_SYSRF_P, ADC2_SYSRF_P,
                         ADC1_SYSRF_P, ADC0_SYSRF_P};
wire[5:0] adc_sysrf_N = {ADC5_SYSRF_M, ADC4_SYSRF_M,
                         ADC3_SYSRF_M, ADC2_SYSRF_M,
                         ADC1_SYSRF_M, ADC0_SYSRF_M};
wire[5:0] adc_dclock_P = {ADC5_DCLK_P, ADC4_DCLK_P,
                          ADC3_DCLK_P, ADC2_DCLK_P,
                          ADC1_DCLK_P, ADC0_DCLK_P};
wire[5:0] adc_dclock_N = {ADC5_DCLK_M, ADC4_DCLK_M,
                          ADC3_DCLK_M, ADC2_DCLK_M,
                          ADC1_DCLK_M, ADC0_DCLK_M};
wire[5:0] adc_fclock_P = {ADC5_FCLK_P, ADC4_FCLK_P,
                          ADC3_FCLK_P, ADC2_FCLK_P,
                          ADC1_FCLK_P, ADC0_FCLK_P};
wire[5:0] adc_fclock_N = {ADC5_FCLK_M, ADC4_FCLK_M,
                          ADC3_FCLK_M, ADC2_FCLK_M,
                          ADC1_FCLK_M, ADC0_FCLK_M};

wire[5:0] i_adc_dclock;
wire[5:0] i_adc_fclock;

generate
  genvar i;
  for (i = 0; i < 6; i = i + 1) begin : io_clk_gen
    wire oddr_clk_q;
    ODDR #(
           .DDR_CLK_EDGE("OPPOSITE_EDGE"),
           .INIT(1'b0),
           .SRTYPE("SYNC")
         )
    clk_forward
    (
      .Q(oddr_clk_q),
      .C(i_adc_clock),
      .D1(1'b0),
      .D2(1'b1),
      .CE(1'b1),
      .R(1'b0),
      .S(1'b0)
    );
    OBUFDS OBUF_ADC_CLOCK(.I(oddr_clk_q), .O(adc_clk_P[i]), .OB(adc_clk_N[i]));

    wire oddr_sysrf_q;
    ODDR #(
           .DDR_CLK_EDGE("OPPOSITE_EDGE"),
           .INIT(1'b0),
           .SRTYPE("SYNC")
         )
    sysrf_forward
    (
      .Q(oddr_sysrf_q),
      .C(i_adc_clock),
      .D1(1'b0),
      .D2(1'b1),
      .CE(1'b1),
      .R(1'b0),
      .S(1'b0)
    );
    OBUFDS OBUF_ADC_SYSRF(.I(oddr_sysrf_q), .O(adc_sysrf_P[i]), .OB(adc_sysrf_N[i]));

    IBUFGDS IBUFGDS_DCLOCK(.I(adc_dclock_P[i]), .IB(adc_dclock_N[i]), .O(i_adc_dclock[i]));
    IBUFGDS IBUFGDS_FCLOCK(.I(adc_fclock_P[i]), .IB(adc_fclock_N[i]), .O(i_adc_fclock[i]));
  end

endgenerate


// ADC / DISCR interface inputs
localparam DEFAULT_DELAY = 5'b0;
wire[47:0] adc_DP = {ADC5_DD1P, ADC5_DD0P, ADC5_DC1P, ADC5_DC0P,
                     ADC5_DB1P, ADC5_DB0P, ADC5_DA1P, ADC5_DA0P,
                     ADC4_DD1P, ADC4_DD0P, ADC4_DC1P, ADC4_DC0P,
                     ADC4_DB1P, ADC4_DB0P, ADC4_DA1P, ADC4_DA0P,
                     ADC3_DD1P, ADC3_DD0P, ADC3_DC1P, ADC3_DC0P,
                     ADC3_DB1P, ADC3_DB0P, ADC3_DA1P, ADC3_DA0P,
                     ADC2_DD1P, ADC2_DD0P, ADC2_DC1P, ADC2_DC0P,
                     ADC2_DB1P, ADC2_DB0P, ADC2_DA1P, ADC2_DA0P,
                     ADC1_DD1P, ADC1_DD0P, ADC1_DC1P, ADC1_DC0P,
                     ADC1_DB1P, ADC1_DB0P, ADC1_DA1P, ADC1_DA0P,
                     ADC0_DD1P, ADC0_DD0P, ADC0_DC1P, ADC0_DC0P,
                     ADC0_DB1P, ADC0_DB0P, ADC0_DA1P, ADC0_DA0P};

wire[47:0] adc_DN = {ADC5_DD1M, ADC5_DD0M, ADC5_DC1M, ADC5_DC0M,
                     ADC5_DB1M, ADC5_DB0M, ADC5_DA1M, ADC5_DA0M,
                     ADC4_DD1M, ADC4_DD0M, ADC4_DC1M, ADC4_DC0M,
                     ADC4_DB1M, ADC4_DB0M, ADC4_DA1M, ADC4_DA0M,
                     ADC3_DD1M, ADC3_DD0M, ADC3_DC1M, ADC3_DC0M,
                     ADC3_DB1M, ADC3_DB0M, ADC3_DA1M, ADC3_DA0M,
                     ADC2_DD1M, ADC2_DD0M, ADC2_DC1M, ADC2_DC0M,
                     ADC2_DB1M, ADC2_DB0M, ADC2_DA1M, ADC2_DA0M,
                     ADC1_DD1M, ADC1_DD0M, ADC1_DC1M, ADC1_DC0M,
                     ADC1_DB1M, ADC1_DB0M, ADC1_DA1M, ADC1_DA0M,
                     ADC0_DD1M, ADC0_DD0M, ADC0_DC1M, ADC0_DC0M,
                     ADC0_DB1M, ADC0_DB0M, ADC0_DA1M, ADC0_DA0M};

wire[23:0] discr_out = {DISCR_OUT23, DISCR_OUT22, DISCR_OUT21, DISCR_OUT20,
                        DISCR_OUT19, DISCR_OUT18, DISCR_OUT17, DISCR_OUT16,
                        DISCR_OUT15, DISCR_OUT14, DISCR_OUT13, DISCR_OUT12,
                        DISCR_OUT11, DISCR_OUT10, DISCR_OUT9, DISCR_OUT8,
                        DISCR_OUT7, DISCR_OUT6, DISCR_OUT5, DISCR_OUT4,
                        DISCR_OUT3, DISCR_OUT2, DISCR_OUT1, DISCR_OUT0};

// ADC / DISCR interface xdom controls
wire[N_CHANNELS*10-1:0] adc_delay_tap_out_xdom;
wire[N_CHANNELS-1:0] adc_io_reset_xdom;
wire[N_CHANNELS-1:0] discr_io_reset_xdom;
wire[N_CHANNELS-1:0] adc_delay_reset_xdom;
wire[N_CHANNELS*2-1:0] adc_delay_ce_xdom;
wire[N_CHANNELS*2-1:0] adc_delay_inc_xdom;
wire[N_CHANNELS*2-1:0] adc_bitslip_xdom;
wire[N_CHANNELS-1:0] discr_bitslip_xdom;

// ADC / DISCR data streams
wire[N_CHANNELS*N_ADC_BITS-1:0] adc_data;
wire[N_CHANNELS*N_DISCR_BITS-1:0] discr_data;

generate
  for (i = 0; i < N_CHANNELS; i = i + 1) begin : adc_discr_iface_gen
    adc_discr_channel ADC_DISCR_CHAN
    (
      .adc_DP(adc_DP[2*i+1 : 2*i]),
      .adc_DN(adc_DN[2*i+1 : 2*i]),
      .discr_out(discr_out[i]),
      .lclk(lclk),
      .discr_fclk(discr_fclk_125MHz),
      .adc_dclk(clk_375MHz),
      .discr_dclk(clk_500MHz),
      .in_delay_reset({adc_delay_reset_xdom[i], adc_delay_reset_xdom[i]}),
      .in_delay_data_ce(adc_delay_ce_xdom[2*i+1 : 2*i]),
      .in_delay_data_inc(adc_delay_inc_xdom[2*i+1 : 2*i]),
      .adc_bitslip(adc_bitslip_xdom[2*i+1 : 2*i]),
      .adc_io_reset({adc_io_reset_xdom[i], adc_io_reset_xdom[i]}),
      .discr_bitslip(discr_bitslip_xdom[i]),
      .discr_io_reset(discr_io_reset_xdom[i]),
      .adc_bits(adc_data[N_ADC_BITS*(i+1)-1 : N_ADC_BITS*i]),
      .discr_bits(discr_data[N_DISCR_BITS*(i+1)-1 : N_DISCR_BITS*i]),
      .delay_tap_in_0(DEFAULT_DELAY),
      .delay_tap_in_1(DEFAULT_DELAY),
      .delay_tap_out_0(adc_delay_tap_out_xdom[10*i+4 : 10*i]),
      .delay_tap_out_1(adc_delay_tap_out_xdom[10*i+9 : 10*i+5])
    );
  end
endgenerate

/////////////////////////////////////////////////////////////////////////
// xDOM interface
// Addressing:
//     12'hfff: Version/build number
//     12'hffe: trig settings
//             [0] et
//             [1] gt
//             [2] lt
//             [3] discr_trig_pol
//             [4] dicr_trig_en
//             [5] thresh_trig_en
//             [6] ext_trig_en
//     12'hffd: trig threshold [11:0]
//     12'hffc:
//             [i] sw_trig (channel i, up to 15)
//     12'hffb:
//             [0] trig_mode
//     12'hffa:
//             [i] trig_arm (channel i)
//     12'hff9:
//             [i] trig_armed (channel i)
//     12'hff8:
//             [0] cnst_run
//     12'hff7: const config [11:0]
//     12'hff6: test config  [11:0]
//     12'hff5: post config [7:0]
//     12'hff4: pre config [4:0]
//     12'heff: dpram_len [10:0]
//     12'hefe:
//             [0] dpram_done
//     12'hefd:
//             [0] dpram_sel (0: ddr3 transfer dpram, 1: direct rdout (rd only))
//     12'hefc: n_waveforms in waveform buffer
//     12'hefb: words used in waveform buffer
//     12'hefa: waveform buffer overflow [15:0]
//     12'hef9: waveform buffer reset [15:0]
//     12'hef8: wvb_reader enable
//     12'hef7: wvb_reader dpram mode
//     12'hef6: wvb header full ([i] for channel i, up to 15)
//     12'hef5: chan select for waveform buffer n_words/n_wfms
//              (efa and ef9)
//     12'hef4: sw_trig[23:16]
//     12'hef3: trig_arm[23:16]
//     12'hef2: trig_armed[23:16]
//     12'hef1: waveform buffer overflow [23:16]
//     12'hef0: waveform buffer reset [23:16]
//     12'heef: wvb header full [23:16]
//
//     ADC / DISCR IO controls
//     12'heee: [4:0] IO control chan select (0-23)
//     12'heed: the following apply to the channel selected in reg 12'heee
//              [0] D0 delay_inc
//              [1] D0 delay_ce
//              [2] D0 bitslip
//              [4] D1 delay_inc
//              [5] D1 delay_ce
//              [6] D1 bitslip
//              [8] discr bitslip
//     12'heec: [4:0] D0 delay tapout
//              [9:5] D1 delay tapout
//     12'heeb: adc io reset [23:16] (defaults to 1)
//     12'heea: adc io reset [15:0] (defaults to 1)
//     12'hee9: adc delay reset [23:16]
//     12'hee8: adc delay reset [15:0]
//     12'hee7: discr io reset [23:16] (defaults to 1)
//     12'hee6: discr io reset [15:0] (defaults to 1)
//     12'hee5: [0] ADC_RESET
//
//     DDR3 test signals
//     12'hdff: page transfer addr[27:16]
//     12'hdfe: page transger addr[15:0]
//     12'hdfd: [0] pg transfer optype (0 read, 1 write)
//     12'hdfc: [0] pg transfer task reg
//     12'hdfb: DDR3 sys rst (active low)
//     12'hdfa: DDR3 cal complete
//     12'hdf9: [11:0] mem interface device temp
//     12'hdf8: [0] ddr3 ui sync rst
//
//     hit buffer controller
//     12'hcff: [0] enable
//     12'hcfe: [15:0] start_pg
//     12'hcfd: [15:0] stop_pg
//     12'hcfc: [15:0] first_pg (readback)
//     12'hcfb: [15:0] last_pg (readback)
//     12'hcfa: [15:0] pg_clr_count
//     12'hcf9: [0] flush_task
//              [1] pg_clr_task
//     12'hcf8: [15:0] rd_pg_num
//     12'hcf7: [15:0] wr_pg_num
//     12'hcf6: [15:0] n_used_pgs
//     12'hcf5: [0] empty
//              [1] full
//              [2] buffered_data

// trigger/wvb conf
wire[L_WIDTH_MDOM_TRIG_BUNDLE-1:0] xdom_trig_bundle;
wire[L_WIDTH_MDOM_WVB_CONF_BUNDLE-1:0] xdom_wvb_conf_bundle;
wire[N_CHANNELS-1:0] xdom_wvb_rst;
wire[N_CHANNELS-1:0] xdom_arm;
wire[N_CHANNELS-1:0] xdom_trig_run;

// waveform buffer status
wire[N_CHANNELS-1:0] wvb_armed;
wire[N_CHANNELS-1:0] wvb_overflow;
wire[N_CHANNELS*16-1:0] wfms_in_buf;
wire[N_CHANNELS*16-1:0] buf_wds_used;
wire[N_CHANNELS-1:0] wvb_hdr_full;

// wvb reader
wire[15:0] rdout_dpram_len;
wire rdout_dpram_run;
wire xdom_rdout_dpram_busy;
wire rdout_dpram_wren;
wire[9:0] rdout_dpram_wr_addr;
wire[31:0] rdout_dpram_data;
wire wvb_reader_enable;
wire wvb_reader_dpram_mode;

// DDR3 interface
wire ddr3_ui_clk;
wire[27:0] xdom_pg_req_addr;
wire xdom_pg_optype;
wire xdom_pg_req;
wire xdom_pg_ack;
wire ddr3_sys_rst;
wire ddr3_cal_complete;
wire ddr3_ui_sync_rst;
wire[11:0] ddr3_device_temp;
wire[7:0] ddr3_dpram_addr;
wire xdom_ddr3_dpram_wren;
wire[127:0] ddr3_dpram_din;
wire[127:0] xdom_ddr3_dpram_dout;

// hit buffer controller
// force hbuf controller to be disabled for now;
// ATD TODO: add hbuf controller after direct readout is working
wire hbuf_enable = 0;
// fake register users can write to until hbuf controller is included
wire dummy_hbuf_enable;

wire[15:0] hbuf_start_pg;
wire[15:0] hbuf_stop_pg;
wire[15:0] hbuf_first_pg;
wire[15:0] hbuf_last_pg;
wire[15:0] hbuf_pg_clr_count;
wire hbuf_pg_clr_req;
wire hbuf_pg_clr_ack;
wire hbuf_flush_req;
wire hbuf_flush_ack;
wire[15:0] hbuf_rd_pg_num;
wire[15:0] hbuf_wr_pg_num;
wire[15:0] hbuf_n_used_pgs;
wire hbuf_empty;
wire hbuf_full;
wire hbuf_buffered_data;

xdom #(.N_CHANNELS(N_CHANNELS)) XDOM_0
(
  .clk(lclk),
  .rst(lclk_rst),
  .vnum(FW_VNUM),

  // trigger/wvb conf
  .xdom_trig_bundle(xdom_trig_bundle),
  .xdom_wvb_conf_bundle(xdom_wvb_conf_bundle),
  .xdom_wvb_arm(xdom_arm),
  .xdom_trig_run(xdom_trig_run),
  .wvb_rst(xdom_wvb_rst),

  // waveform buffer status
  .wvb_armed(wvb_armed),
  .wvb_overflow(wvb_overflow),
  .wfms_in_buf(wfms_in_buf),
  .buf_wds_used(buf_wds_used),
  .wvb_hdr_full(wvb_hdr_full),

  // wvb reader
  .dpram_len_in(rdout_dpram_len),
  .rdout_dpram_run(rdout_dpram_run && !hbuf_enable),
  .dpram_busy(xdom_rdout_dpram_busy),
  .rdout_dpram_wren(rdout_dpram_wren && !hbuf_enable),
  .rdout_dpram_wr_addr(rdout_dpram_wr_addr),
  .rdout_dpram_data(rdout_dpram_data),
  .wvb_reader_enable(wvb_reader_enable),
  .wvb_reader_dpram_mode(wvb_reader_dpram_mode),

  // ADC / DISCR IO controls
  .adc_delay_tap_out(adc_delay_tap_out_xdom),
  .adc_io_reset(adc_io_reset_xdom),
  .discr_io_reset(discr_io_reset_xdom),
  .adc_delay_reset(adc_delay_reset_xdom),
  .adc_delay_ce(adc_delay_ce_xdom),
  .adc_delay_inc(adc_delay_inc_xdom),
  .adc_bitslip(adc_bitslip_xdom),
  .discr_bitslip(discr_bitslip_xdom),

  .adc_reset(ADC_RESET),

  // DDR3 interface
  .ddr3_ui_clk(ddr3_ui_clk),
  .pg_req_addr(xdom_pg_req_addr),
  .pg_optype(xdom_pg_optype),
  .pg_req(xdom_pg_req),
  .pg_ack(xdom_pg_ack),
  .ddr3_sys_rst(ddr3_sys_rst),
  .ddr3_cal_complete(ddr3_cal_complete),
  .ddr3_ui_sync_rst(ddr3_ui_sync_rst),
  .ddr3_device_temp(ddr3_device_temp),
  .ddr3_dpram_addr(ddr3_dpram_addr),
  .ddr3_dpram_wren(xdom_ddr3_dpram_wren),
  .ddr3_dpram_din(ddr3_dpram_din),
  .ddr3_dpram_dout(xdom_ddr3_dpram_dout),

  // hit buffer controller
  .hbuf_enable(dummy_hbuf_enable),
  .hbuf_start_pg(hbuf_start_pg),
  .hbuf_stop_pg(hbuf_stop_pg),
  .hbuf_first_pg(hbuf_first_pg),
  .hbuf_last_pg(hbuf_last_pg),
  .hbuf_pg_clr_count(hbuf_pg_clr_count),
  .hbuf_pg_clr_req(hbuf_pg_clr_req),
  .hbuf_pg_clr_ack(hbuf_pg_clr_ack),
  .hbuf_flush_req(hbuf_flush_req),
  .hbuf_flush_ack(hbuf_flush_ack),
  .hbuf_rd_pg_num(hbuf_rd_pg_num),
  .hbuf_wr_pg_num(hbuf_wr_pg_num),
  .hbuf_n_used_pgs(hbuf_n_used_pgs),
  .hbuf_empty(hbuf_empty),
  .hbuf_full(hbuf_full),
  .hbuf_buffered_data(hbuf_buffered_data),

  // debug UART
  .debug_txd(FTD_UART_TXD),
  .debug_rxd(FTD_UART_RXD),
  .debug_rts_n(1'b0),
  .debug_cts_n()
);
assign FTD_UART_CTSn = 0;

//
// placeholder LTC counter
//
reg[47:0] ltc = 0;
always @(posedge lclk) begin
  if (lclk_rst) begin
    ltc <= 0;
  end

  else begin
    ltc <= ltc + 1;
  end
end

//
// Waveform acquisition modules
//
// configuration currently shared between all channels
// ATF TODO: add separate configuration for each channel

wire[N_CHANNELS-1:0] wvb_hdr_empty;
wire[N_CHANNELS-1:0] wvb_hdr_rdreq;
wire[N_CHANNELS-1:0] wvb_wvb_rdreq;
wire[N_CHANNELS-1:0] wvb_rddone;
wire[N_CHANNELS*22-1:0] wvb_data_out;
wire[N_CHANNELS*P_HDR_WIDTH-1:0] wvb_hdr_data;

// register the xdom trigger/wvb configuration
(* max_fanout = 5 *) reg[L_WIDTH_MDOM_TRIG_BUNDLE-1:0] xdom_trig_bundle_reg;
(* max_fanout = 5 *) reg[L_WIDTH_MDOM_WVB_CONF_BUNDLE-1:0] xdom_wvb_conf_bundle_reg;
always @(posedge lclk) begin
  xdom_trig_bundle_reg <= xdom_trig_bundle;
  xdom_wvb_conf_bundle_reg <= xdom_wvb_conf_bundle;
end

generate
  for (i = 0; i < N_CHANNELS; i = i + 1) begin : waveform_acq_gen
    waveform_acquisition #(.P_ADR_WIDTH(P_WVB_ADR_WIDTH),
                           .P_HDR_WIDTH(P_HDR_WIDTH))
    WFM_ACQ
    (
      .clk(lclk),
      .rst(lclk_rst || xdom_wvb_rst[i]),

      .adc_data(adc_data[N_ADC_BITS*(i+1)-1 : N_ADC_BITS*i]),
      .discr_data(discr_data[N_DISCR_BITS*(i+1)- 1 : N_DISCR_BITS*i]),

      // WVB reader interface
      .wvb_data_out(wvb_data_out[22*(i+1)-1 : 22*i]),
      .wvb_hdr_data_out(wvb_hdr_data[P_HDR_WIDTH*(i+1)-1 : P_HDR_WIDTH*i]),
      .wvb_hdr_full(wvb_hdr_full[i]),
      .wvb_hdr_empty(wvb_hdr_empty[i]),
      .wvb_n_wvf_in_buf(wfms_in_buf[16*(i+1)-1 : 16*i]),
      .wvb_wused(buf_wds_used[16*(i+1)-1 : 16*i]),
      .wvb_hdr_rdreq(wvb_hdr_rdreq[i]),
      .wvb_wvb_rdreq(wvb_wvb_rdreq[i]),
      .wvb_wvb_rddone(wvb_rddone[i]),

      // Local time counter
      .ltc_in(ltc),

      // External
      .ext_trig_in(1'b0),
      .wvb_trig_out(),
      .wvb_trig_test_out(),

      // XDOM interface
      .xdom_arm(xdom_arm[i]),
      .xdom_trig_run(xdom_trig_run[i]),
      .xdom_wvb_trig_bundle(xdom_trig_bundle_reg),
      .xdom_wvb_config_bundle(xdom_wvb_conf_bundle_reg),
      .xdom_wvb_armed(wvb_armed[i]),
      .xdom_wvb_overflow(wvb_overflow[i])
    );
  end
endgenerate

//
// hit buffer controller
//
// wire hbuf_dpram_busy;
// wire[127:0] hbuf_dpram_dout;
// wire[7:0] hbuf_dpram_addr;
// wire hbuf_pg_req;
// wire hbuf_pg_ack;
// wire hbuf_pg_optype;
// wire[27:0] hbuf_pg_req_addr;

// hbuf_ctrl HBUF_CTRL_0
// (
//  .clk(lclk),
//  .rst(lclk_rst),
//  .en(hbuf_enable),

//  .start_pg(hbuf_start_pg),
//  .stop_pg(hbuf_stop_pg),
//  .first_pg(hbuf_first_pg),
//  .last_pg(hbuf_last_pg),

//  .flush_req(hbuf_flush_req),
//  .flush_ack(hbuf_flush_ack),

//  .empty(hbuf_empty),
//  .full(hbuf_full),
//  .rd_pg_num(hbuf_rd_pg_num),
//  .wr_pg_num(hbuf_wr_pg_num),
//  .n_used_pgs(hbuf_n_used_pgs),

//  .pg_clr_cnt(hbuf_pg_clr_count),
//  .pg_clr_req(hbuf_pg_clr_req),
//  .pg_clr_ack(hbuf_pg_clr_ack),

//  .buffered_data(hbuf_buffered_data),

//  .dpram_len_in(rdout_dpram_len),
//  .rdout_dpram_run(rdout_dpram_run && hbuf_enable),
//  .dpram_busy(hbuf_dpram_busy),
//  .rdout_dpram_wren(rdout_dpram_wren && hbuf_enable),

//  .rdout_dpram_wr_addr(rdout_dpram_wr_addr),
//  .rdout_dpram_data(rdout_dpram_data),

//  .ddr3_ui_clk(ddr3_ui_clk),
//  .ddr3_dpram_dout(hbuf_dpram_dout),
//  .ddr3_dpram_rd_addr(ddr3_dpram_addr),

//  .pg_ack(hbuf_pg_ack),
//  .pg_req(hbuf_pg_req),
//  .pg_optype(hbuf_pg_optype),
//  .pg_addr(hbuf_pg_req_addr)
// );

//
// Waveform buffer reader
//

// ATF TODO: uncomment this and remove line below when adding hbuf controller
// wire rdout_dpram_busy = hbuf_enable ? hbuf_dpram_busy : xdom_rdout_dpram_busy;
wire rdout_dpram_busy = xdom_rdout_dpram_busy;

wvb_reader #(.N_CHANNELS(N_CHANNELS),
             .P_WVB_ADR_WIDTH(P_WVB_ADR_WIDTH),
             .P_HDR_WIDTH(P_HDR_WIDTH))
WVB_READER
(
  .clk(lclk),
  .rst(lclk_rst),
  .en(wvb_reader_enable),

  // dpram interface
  .dpram_data(rdout_dpram_data),
  .dpram_addr(rdout_dpram_wr_addr),
  .dpram_wren(rdout_dpram_wren),
  .dpram_len(rdout_dpram_len),
  .dpram_run(rdout_dpram_run),
  .dpram_busy(rdout_dpram_busy),
  .dpram_mode(wvb_reader_dpram_mode),

  // wvb interface
  .hdr_rdreq(wvb_hdr_rdreq),
  .wvb_rdreq(wvb_wvb_rdreq),
  .wvb_rddone(wvb_rddone),
  .wvb_data(wvb_data_out),
  .hdr_data(wvb_hdr_data),
  .hdr_empty(wvb_hdr_empty)
);

//
// DDR3 pg transfer mux
// runs in DDR3 UI clock domain
//

// wire ddr3_pg_req;
// wire ddr3_pg_optype;
// wire ddr3_pg_ack;
// wire[27:0] ddr3_pg_req_addr;
// wire[127:0] ddr3_dpram_dout;
// wire ddr3_dpram_wren;

// DDR3_pg_transfer_mux DDR3_MUX
// (
//  .clk(ddr3_ui_clk),
//  .rst(ddr3_ui_sync_rst),

//  .hbuf_pg_req(hbuf_pg_req),
//  .hbuf_pg_optype(hbuf_pg_optype),
//  .hbuf_pg_ack(hbuf_pg_ack),
//  .hbuf_pg_req_addr(hbuf_pg_req_addr),
//  .hbuf_dpram_dout(hbuf_dpram_dout),

//  .xdom_pg_req(xdom_pg_req),
//  .xdom_pg_optype(xdom_pg_optype),
//  .xdom_pg_ack(xdom_pg_ack),
//  .xdom_pg_req_addr(xdom_pg_req_addr),
//  .xdom_dpram_dout(xdom_ddr3_dpram_dout),
//  .xdom_dpram_wren(xdom_ddr3_dpram_wren),

//  .ddr3_pg_req(ddr3_pg_req),
//  .ddr3_pg_optype(ddr3_pg_optype),
//  .ddr3_pg_ack(ddr3_pg_ack),
//  .ddr3_pg_req_addr(ddr3_pg_req_addr),
//  .ddr3_dpram_dout(ddr3_dpram_dout),
//  .ddr3_dpram_wren(ddr3_dpram_wren)
// );

// //
// // DDR3 page transter
// //

// DDR3_DPRAM_transfer DDR3_TRANSFER_0
// (
//  .ddr3_dq(ddr3_dq),
//  .ddr3_dqs_n(ddr3_dqs_n),
//  .ddr3_dqs_p(ddr3_dqs_p),
//  .ddr3_addr(ddr3_addr),
//  .ddr3_ba(ddr3_ba),
//  .ddr3_ras_n(ddr3_ras_n),
//  .ddr3_cas_n(ddr3_cas_n),
//  .ddr3_we_n(ddr3_we_n),
//  .ddr3_reset_n(ddr3_reset_n),
//  .ddr3_ck_p(ddr3_ck_p),
//  .ddr3_ck_n(ddr3_ck_n),
//  .ddr3_cke(ddr3_cke),
//  .ddr3_cs_n(ddr3_cs_n),
//  .ddr3_dm(ddr3_dm),
//  .ddr3_odt(ddr3_odt),
//  .sys_clk_i(sys_clk_i),
//  .clk_ref_i(ref_clk),

//  .ui_clk(ddr3_ui_clk),

//  .sys_rst(ddr3_sys_rst),

//  .pg_req(ddr3_pg_req),
//  .pg_optype(ddr3_pg_optype),
//  .pg_req_addr(ddr3_pg_req_addr),
//  .pg_ack(ddr3_pg_ack),

//  .init_calib_complete(ddr3_cal_complete),
//  .ui_clk_sync_rst(ddr3_ui_sync_rst),
//  .device_temp(ddr3_device_temp),

//  .dpram_dout(ddr3_dpram_dout),
//  .dpram_din(ddr3_dpram_din),
//  .dpram_addr(ddr3_dpram_addr),
//  .dpram_wren(ddr3_dpram_wren)
// );

endmodule