/////////////////////////////////////////////////////////////////////////////////
// Tyler Anderson Tue 06/18/2019_ 8:48:46.46
//
// Adapted by Aaron Fienberg from mDOT project & artyS7 for the mDOM
//
// xdom.v
//
// currently contains:
//    1.) Debug UART
//    2.) ICM UART
//    3.) MCU UART (unused on the mDOM)
//    4.) Command, response, status
/////////////////////////////////////////////////////////////////////////////////
`include "rev_num.v"
module xdom #(parameter N_CHANNELS = 24, parameter P_WIDTH_MDOM_BSUM_BUNDLE = 45)
(
  input 				clk,
  input 				rst,

  // Version number
  input [15:0] 				vnum,

  // trigger/wvb conf
  output [19:0] 			xdom_trig_bundle,
  output [39:0] 			xdom_wvb_conf_bundle,
  output reg [N_CHANNELS-1:0] 		xdom_wvb_arm = 0,
  output reg [N_CHANNELS-1:0] 		xdom_trig_run = 0,
  output reg [N_CHANNELS-1:0] 		wvb_rst = 0,
  output reg [N_CHANNELS-1:0] 		xdom_trig_en = {N_CHANNELS{1'b1}}, 
 
  // waveform buffer status
  input [N_CHANNELS-1:0] 		wvb_armed,
  input [N_CHANNELS-1:0] 		wvb_overflow,
  input [N_CHANNELS-1:0] 		wvb_hdr_full,
  input [N_CHANNELS-1:0] 		wvb_not_empty,
  input [N_CHANNELS*16 - 1:0] 		wfms_in_buf,
  input [N_CHANNELS*16 - 1:0] 		buf_wds_used,

  // wvb reader
  input [15:0] 				dpram_len_in,
  input 				rdout_dpram_run,
  output reg 				dpram_busy = 0,
  input 				rdout_dpram_wren,
  input [9:0] 				rdout_dpram_wr_addr,
  input [31:0] 				rdout_dpram_data,
  output reg 				wvb_reader_enable = 0,
  output reg 				wvb_reader_dpram_mode = 0,

  // ADC / DISCR IO controls
  input [N_CHANNELS*10-1:0] 		adc_delay_tap_out,
  output reg [N_CHANNELS-1:0] 		adc_io_reset = {N_CHANNELS{1'b1}},
  output reg [N_CHANNELS-1:0] 		discr_io_reset = {N_CHANNELS{1'b1}},
  output reg [N_CHANNELS-1:0] 		adc_delay_reset = 0,
  output [N_CHANNELS*2-1:0] 		adc_delay_ce,
  output [N_CHANNELS*2-1:0] 		adc_delay_inc,
  output [N_CHANNELS*2-1:0] 		adc_bitslip,
  output [N_CHANNELS-1:0] 		discr_bitslip,

  // ADC serial controls
  output reg 				adc_reset = 0,
  output reg [5:0] 			adc_spi_sel = 0,
  output 				adc_spi_req,
  input 				adc_spi_ack,
  output reg [23:0] 			adc_spi_wr_data = 0,
  input [7:0] 				adc_spi_rd_data,

  // AD5668 DAC serial controls
  output reg [2:0] 			dac_spi_sel = 0,
  output reg [2:0] 			dac_chip_sel = 0,
  output 				dac_spi_req,
  input 				dac_spi_ack,
  output reg [31:0] 			dac_spi_wr_data = 0,

  // AFE pulser
  output reg [5:0] 			pulser_io_rst = 6'h3f,
  output [5:0] 				pulser_trig_out,
  output reg [15:0] 			pulser_width = 0,

  // ADS8332 monitoring ADCs
  output 				slo_adc_req,
  input 				slo_adc_ack,
  output reg [18:0] 			slo_adc_wr_data = 0,
  input [18:0] 				slo_adc_rd_data,
  output reg 				slo_adc_chip_sel = 0,
  output 				slo_adc_nconvst,

  // DDR3 interface
  input 				ddr3_ui_clk,
  // note: the memory controller uses byte addresses,
  // but the xdom MCU interface will use 16-bit word addresses
  // to replicate the D-Egg interface
  // byte addresses are used everywhere else in the mDOM firmware
  output [27:0] 			pg_req_addr,
  output reg 				pg_optype = 0,
  output reg 				pg_req = 0,
  input 				pg_ack,
  output reg 				ddr3_sys_rst = 0,
  input 				ddr3_cal_complete,
  input 				ddr3_ui_sync_rst,
  input [11:0] 				ddr3_device_temp,
  input [7:0] 				ddr3_dpram_addr,
  input 				ddr3_dpram_wren,
  input [127:0] 			ddr3_dpram_din,
  output [127:0] 			ddr3_dpram_dout,

  output reg 				ddr3_vtt_s3 = 0,
  output reg 				ddr3_vtt_s5 = 0,

  // hit buffer controller
  output reg 				hbuf_enable = 0,
  output reg [15:0] 			hbuf_start_pg = 0,
  output reg [15:0] 			hbuf_stop_pg = 0,
  input [15:0] 				hbuf_first_pg,
  input [15:0] 				hbuf_last_pg,
  output reg [15:0] 			hbuf_pg_clr_count = 0,
  output reg 				hbuf_pg_clr_req = 0,
  input 				hbuf_pg_clr_ack,
  output reg 				hbuf_flush_req = 0,
  input 				hbuf_flush_ack,
  input [15:0] 				hbuf_rd_pg_num,
  input [15:0] 				hbuf_wr_pg_num,
  input [15:0] 				hbuf_n_used_pgs,
  input 				hbuf_empty,
  input 				hbuf_full,
  input 				hbuf_buffered_data,

  // discr scalers
  (* max_fanout = 5 *) output reg [31:0] scaler_period = 0,
  (* max_fanout = 5 *) output reg [31:0] scaler_inhibit_len = 0,
  input [N_CHANNELS*32-1:0] 		disc_scaler_out,
  // thresh scaler
  input [N_CHANNELS*32-1:0] 		thresh_scaler_out,

  // icm sync signals and ltc
  input [47:0] 				ltc_rd_data,
  output 				ltc_rd_req,
  input 				ltc_rd_ack,
  output reg 				icm_fpga_sync_en = 0,
  input 				icm_sync_rdy,
  input 				icm_sync_err,
  input [47:0] 				expected_sync_ltc,
  input [47:0] 				received_sync_ltc,
  input [15:0] 				icm_sync_err_cnt,

  output [P_WIDTH_MDOM_BSUM_BUNDLE-1:0] bsum_bundle,

  // FPGA_CAL_TRIG interface
  output reg [15:0] 			fpga_cal_trig_width = 0,
  output reg 				fpga_cal_trig_io_rst = 1'b1,
  output 				fpga_cal_trig_trig,
  output reg 				fpga_cal_trig_pol = 1,

  output reg 				dcdc_sync = 0,

  // I2C
  input 				i2cm_0_ack,
  input [7:0] 				i2cm_0_rx_data,
  input 				i2cm_0_i2c_acked,
  input 				i2cm_0_rx_fifo_full,
  input 				i2cm_0_rx_fifo_empty,
  input 				i2cm_0_tx_fifo_full,
  input 				i2cm_0_tx_fifo_empty, 
  output 				i2cm_0_tx_fifo_wr_req,
  output 				i2cm_0_rx_fifo_rd_req,
  output 				i2cm_0_ex_req,
  output reg 				i2cm_0_i2c_ack=0,
  output reg 				i2cm_0_i2c_start=0,
  output reg 				i2cm_0_i2c_stop=0,
  output reg 				i2cm_0_i2c_r_wn=0, 
  output reg [7:0] 			i2cm_0_tx_data=0,

  // global discriminator trigger
  output reg 				global_trig_en = 0,
  output reg 				global_trig_pol = 0,
  output reg [N_CHANNELS-1:0] 		global_trig_src_mask,
  output reg [N_CHANNELS-1:0] 		global_trig_rcv_mask,

`ifndef MDOMREV1
  // FGPA_CAL_TRIG trigger
  output reg 				cal_trig_trig_en = 0,
  output reg 				cal_trig_trig_pol = 0,
 `endif
 
  // Debug FT232R I/O
  input 				debug_txd,
  output 				debug_rxd,
  input 				debug_rts_n,
  output 				debug_cts_n,

  // ICM UART
  output 				icm_tx,
  input 				icm_rx,
  output 				icm_rts,
  input 				icm_cts,

  // MCU UART
  input 				mcu_tx,
  output 				mcu_rx,
  input 				mcu_rts_n,
  output 				mcu_cts_n,

  // Local coincidence - T. Anderson Sat 05/21/2022_15:19:23.50
  output reg [15:0] 			lc_window_width = 4,
  output reg [15:0] 			n_lc_thr = 2,
  output reg 				lc_required = 1'b0, 

  // Thermal shutdown - T. Anderson Mon 11/14/2022_17:54:34.05
  output reg [11:0] 			xdom_thermal_shutdown_temp = 2870, // ~80degC 
  
  // priority input / FMC
  input 				po_wr,
  input 				po_en,
  input [11:0] 				po_a,
  input [15:0] 				po_din,
  output [15:0] 			po_dout
);

///////////////////////////////////////////////////////////////////////////////
// 1.) Debug UART
wire [11:0] debug_logic_adr;
wire [15:0] debug_logic_wr_data;
wire        debug_logic_wr_req;
wire        debug_logic_rd_req;
wire        debug_err_req;
wire [31:0] debug_err_data;
wire [15:0] debug_logic_rd_data;
wire        debug_logic_ack;
wire        debug_err_ack;
ft232r_proc_buffered UART_DEBUG_0
 (
  // Outputs
  .rxd              (debug_rxd),
  .cts_n            (debug_cts_n),
  .logic_adr        (debug_logic_adr[11:0]),
  .logic_wr_data    (debug_logic_wr_data[15:0]),
  .logic_wr_req     (debug_logic_wr_req),
  .logic_rd_req     (debug_logic_rd_req),
  .err_req          (debug_err_req),
  .err_data         (debug_err_data[31:0]),
  // Inputs
  .clk              (clk),
  .rst              (rst),
  .txd              (debug_txd),
  .rts_n            (debug_rts_n),
  .logic_rd_data    (debug_logic_rd_data[15:0]),
  .logic_ack        (debug_logic_ack),
  .err_ack          (debug_err_ack)
  );

`include "mDOM_bsum_bundle_inc.v"
   
///////////////////////////////////////////////////////////////////////////////
// 2.) ICM UART
wire [11:0] icm_logic_adr;
wire [15:0] icm_logic_wr_data;
wire        icm_logic_wr_req;
wire        icm_logic_rd_req;
wire        icm_err_req;
wire [31:0] icm_err_data;
wire [15:0] icm_logic_rd_data;
wire        icm_logic_ack;
wire        icm_err_ack;
ft232r_proc_buffered UART_ICM_0
 (
  // Outputs
  .rxd    (icm_tx),
  .cts_n    (icm_rts),
  .logic_adr  (icm_logic_adr[11:0]),
  .logic_wr_data  (icm_logic_wr_data[15:0]),
  .logic_wr_req (icm_logic_wr_req),
  .logic_rd_req (icm_logic_rd_req),
  .err_req    (icm_err_req),
  .err_data   (icm_err_data[31:0]),
  // Inputs
  .clk    (clk),
  .rst    (rst),
  .txd    (icm_rx),
  .rts_n    (icm_cts),
  .logic_rd_data  (icm_logic_rd_data[15:0]),
  .logic_ack  (icm_logic_ack),
  .err_ack    (icm_err_ack)
);

///////////////////////////////////////////////////////////////////////////////
// 3.) MCU UART (unused on mDOM)
// note: unused in the mDOM, will be held in reset
wire [11:0] mcu_logic_adr;
wire [15:0] mcu_logic_wr_data;
wire        mcu_logic_wr_req;
wire        mcu_logic_rd_req;
wire        mcu_err_req;
wire [31:0] mcu_err_data;
wire [15:0] mcu_logic_rd_data;
wire        mcu_logic_ack;
wire        mcu_err_ack;
ft232r_proc_buffered UART_MCU_0
 (
  // Outputs
  .rxd    (mcu_rx),
  .cts_n    (mcu_cts_n),
  .logic_adr  (mcu_logic_adr[11:0]),
  .logic_wr_data  (mcu_logic_wr_data[15:0]),
  .logic_wr_req (mcu_logic_wr_req),
  .logic_rd_req (mcu_logic_rd_req),
  .err_req    (mcu_err_req),
  .err_data   (mcu_err_data[31:0]),
  // Inputs
  .clk    (clk),
  // .rst    (rst),
  .rst    (1'b1),
  .txd    (mcu_tx),
  .rts_n    (mcu_rts_n),
  .logic_rd_data  (mcu_logic_rd_data[15:0]),
  .logic_ack  (mcu_logic_ack),
  .err_ack    (mcu_err_ack)
);

//////////////////////////////////////////////////////////////////////////////
// 4.) Command, response, status
wire [11:0] y_adr;
wire [15:0] y_wr_data;
wire        y_wr;
reg [15:0] y_rd_data;
crs_master CRSM_0
 (
  // Outputs
  .y_adr            (y_adr[11:0]),
  .y_wr_data        (y_wr_data[15:0]),
  .y_wr             (y_wr),
  .a0_ack           (debug_logic_ack),
  .a0_rd_data       (debug_logic_rd_data[15:0]),
  .a0_buf_rd        (),
  .a1_ack           (mcu_logic_ack),
  .a1_rd_data       (mcu_logic_rd_data[15:0]),
  .a1_buf_rd        (),
  .a2_ack           (icm_logic_ack),
  .a2_rd_data       (icm_logic_rd_data[15:0]),
  .a2_buf_rd        (),
  .a3_ack           (),
  .a3_rd_data       (),
  .a3_buf_rd        (),
  // Inputs
  .clk              (clk),
  .rst              (rst),
  .y_rd_data        (y_rd_data[15:0]),
  .a0_wr_req        (debug_logic_wr_req),
  .a0_bwr_req       (1'b0),
  .a0_rd_req        (debug_logic_rd_req),
  .a0_wr_data       (debug_logic_wr_data[15:0]),
  .a0_adr           (debug_logic_adr[11:0]),
  .a0_buf_empty     (1'b1),
  .a0_buf_wr_data   (),
  .a1_wr_req        (mcu_logic_wr_req),
  .a1_bwr_req       (1'b0),
  .a1_rd_req        (mcu_logic_rd_req),
  .a1_wr_data       (mcu_logic_wr_data[15:0]),
  .a1_adr           (mcu_logic_adr[11:0]),
  .a1_buf_empty     (1'b1),
  .a1_buf_wr_data   (),
  .a2_wr_req  (icm_logic_wr_req),
  .a2_bwr_req (1'b0),
  .a2_rd_req  (icm_logic_rd_req),
  .a2_wr_data (icm_logic_wr_data),
  .a2_adr   (icm_logic_adr[11:0]),
  .a2_buf_empty (1'b1),
  .a2_buf_wr_data (),
  .a3_wr_req        (),
  .a3_bwr_req       (),
  .a3_rd_req        (),
  .a3_wr_data       (),
  .a3_adr           (),
  .a3_buf_empty     (),
  .a3_buf_wr_data   (),
  // Priority Override
  .po_en            (po_en),
  .po_wr            (po_wr),
  .po_adr           (po_a),
  .po_wr_data       (po_din),
  .po_rd_data       (po_dout)
);

// trig bundle
reg wvb_trig_et = 0;
reg wvb_trig_gt = 0;
reg wvb_trig_lt = 0;
reg wvb_trig_run = 0;
reg wvb_trig_discr_trig_pol = 0;
reg [11:0] wvb_trig_thr = 0;
reg wvb_trig_discr_trig_en = 0;
reg wvb_trig_thresh_trig_en = 0;
reg wvb_trig_ext_trig_en = 0;
mDOM_trig_bundle_fan_in TRIG_FAN_IN
  (
   .bundle(xdom_trig_bundle),
   .trig_et(wvb_trig_et),
   .trig_gt(wvb_trig_gt),
   .trig_lt(wvb_trig_lt),
   .trig_run(wvb_trig_run),
   .discr_trig_pol(wvb_trig_discr_trig_pol),
   .trig_thresh(wvb_trig_thr),
   .disc_trig_en(wvb_trig_discr_trig_en),
   .thresh_trig_en(wvb_trig_thresh_trig_en),
   .ext_trig_en(wvb_trig_ext_trig_en)
  );

// wvb conf bundle
reg[11:0] wvb_cnst_config = 0;
reg[7:0] wvb_post_config = 0;
reg[4:0] wvb_pre_config = 0;
reg[11:0] wvb_test_config = 0;
reg wvb_arm = 0;
reg wvb_trig_mode = 0;
reg wvb_cnst_run = 0;
mDOM_wvb_conf_bundle_fan_in WVB_CONF_FAN_IN
  (
   .bundle(xdom_wvb_conf_bundle),
   .cnst_conf(wvb_cnst_config),
   .test_conf(wvb_test_config),
   .post_conf(wvb_post_config),
   .pre_conf(wvb_pre_config),
   .arm(wvb_arm),
   .trig_mode(wvb_trig_mode),
   .cnst_run(wvb_cnst_run)
  );

// bsum bundle
reg bsum_pause = 0;
reg bsum_pause_override = 0;
reg[2:0] bsum_len_sel = 0;
reg[15:0] bsum_pause_len = 0;
reg[11:0] bsum_dev_low = 0;
reg[11:0] bsum_dev_high = 0;
mDOM_bsum_bundle_fan_in BSUM_FAN_IN (
  .bundle(bsum_bundle),
  .pause(bsum_pause),
  .pause_override(bsum_pause_override),
  .sum_len_sel(bsum_len_sel),
  .pause_len(bsum_pause_len),
  .dev_low(bsum_dev_low),
  .dev_high(bsum_dev_high)
);

// buffer status mux
reg[4:0] buf_status_sel;
wire[15:0] wds_used_mux_out;
reg[15:0] wds_used_mux_out_reg = 0;
n_channel_mux #(.N_INPUTS(N_CHANNELS),
                .INPUT_WIDTH(16)) BUF_WDS_USED_MUX
  (
   .in(buf_wds_used),
   .sel(buf_status_sel),
   .out(wds_used_mux_out)
  );

wire[15:0] buf_n_wfms_mux_out;
reg[15:0] buf_n_wfms_mux_out_reg = 0;
n_channel_mux #(.N_INPUTS(N_CHANNELS),
                .INPUT_WIDTH(16)) BUF_N_WFMS_MUX
  (
   .in(wfms_in_buf),
   .sel(buf_status_sel),
   .out(buf_n_wfms_mux_out)
  );

// delay tap_out mux
(* max_fanout = 20 *) reg[4:0] io_ctrl_sel;
wire[9:0] delay_tap_mux_out;
reg[9:0] delay_tap_mux_out_reg = 0;
n_channel_mux #(.N_INPUTS(N_CHANNELS),
                .INPUT_WIDTH(10)) TAP_OUT_MUX
  (
   .in(adc_delay_tap_out),
   .sel(io_ctrl_sel),
   .out(delay_tap_mux_out)
  );

// scaler mux
reg[4:0] scaler_sel;
wire[31:0] disc_scaler_mux_out;
reg[31:0] disc_scaler_mux_out_reg;
n_channel_mux #(.N_INPUTS(N_CHANNELS),
                .INPUT_WIDTH(32)) DISC_SCALER_MUX
  (
   .in(disc_scaler_out),
   .sel(scaler_sel),
   .out(disc_scaler_mux_out)
  );

wire[31:0] thresh_scaler_mux_out;
reg[31:0] thresh_scaler_mux_out_reg;
n_channel_mux #(.N_INPUTS(N_CHANNELS),
                .INPUT_WIDTH(32)) THRESH_SCALER_MUX
  (
   .in(thresh_scaler_out),
   .sel(scaler_sel),
   .out(thresh_scaler_mux_out)
  );

// register mux outputs
always @(posedge clk) begin
  wds_used_mux_out_reg <= wds_used_mux_out;
  buf_n_wfms_mux_out_reg <= buf_n_wfms_mux_out;
  delay_tap_mux_out_reg <= delay_tap_mux_out;
  disc_scaler_mux_out_reg <= disc_scaler_mux_out;
  thresh_scaler_mux_out_reg <= thresh_scaler_mux_out;
end

// ADC / DISCR IO demuxing
wire[N_CHANNELS*2-1:0] adc_delay_ce_0;
reg[N_CHANNELS*2-1:0] adc_delay_ce_1 = 0;
reg[1:0] i_adc_delay_ce = 0;

wire[N_CHANNELS*2-1:0] adc_delay_inc_0;
reg[N_CHANNELS*2-1:0] adc_delay_inc_1 = 0;
reg[1:0] i_adc_delay_inc = 0;

wire[N_CHANNELS*2-1:0] adc_bitslip_0;
reg[N_CHANNELS*2-1:0] adc_bitslip_1 = 0;
reg[1:0] i_adc_bitslip = 0;

wire[N_CHANNELS-1:0] discr_bitslip_0;
reg[N_CHANNELS-1:0] discr_bitslip_1 = 0;
reg i_discr_bitslip = 0;

generate
  genvar i;
  for (i = 0; i < N_CHANNELS; i = i + 1) begin
    assign adc_delay_ce_0[2*i+1 : 2*i] = io_ctrl_sel == i ? i_adc_delay_ce : 2'b0;
    assign adc_delay_inc_0[2*i+1 : 2*i] = io_ctrl_sel == i ? i_adc_delay_inc : 2'b0;
    assign adc_bitslip_0[2*i+1 : 2*i] = io_ctrl_sel == i ? i_adc_bitslip : 2'b0;
    assign discr_bitslip_0[i] = io_ctrl_sel == i ? i_discr_bitslip : 1'b0;
  end
endgenerate

always @(posedge clk) begin
  if (rst) begin
    adc_delay_ce_1 <= 0;
    adc_delay_inc_1 <= 0;
    adc_bitslip_1 <= 0;
    discr_bitslip_1 <= 0;
  end

  else begin
    adc_delay_ce_1 <= adc_delay_ce_0;
    adc_delay_inc_1 <= adc_delay_inc_0;
    adc_bitslip_1 <= adc_bitslip_0;
    discr_bitslip_1 <= discr_bitslip_0;
  end
end
assign adc_delay_ce = adc_delay_ce_1;
assign adc_delay_inc = adc_delay_inc_1;
assign adc_bitslip = adc_bitslip_1;
assign discr_bitslip = discr_bitslip_1;

//
// One shots
//
reg slo_nconvst_os = 0;
one_shot OS_NCONVST (
  .clk(clk),
  .rst_n(!rst),
  .n0(32'd0),
  .n1(32'd60),
  .trig(slo_nconvst_os),
  .a0(1'b1),
  .a1(1'b0),
  .busy(),
  .y(slo_adc_nconvst)
);

//
// Task regs
//
wire [15:0] ltc_task_val;
wire [15:0] ltc_task_req;
wire [15:0] ltc_task_ack;
task_reg #(.P_TASK_ADR(12'hfe3)) LTC_TASK_REG_0
 (
  .clk(clk),
  .rst(rst),
  .adr(y_adr),
  .data(y_wr_data),
  .wr(y_wr),
  .req(ltc_task_req),
  .ack(ltc_task_ack),
  .val(ltc_task_val)
  );
assign ltc_rd_req = ltc_task_req[0];
assign ltc_task_ack[0] = ltc_rd_ack;

wire[15:0] adc_spi_task_val;
wire[15:0] adc_spi_task_req;
wire[15:0] adc_spi_task_ack;
task_reg #(.P_TASK_ADR(12'hbdb)) ADC_SPI_TASK_0 (
  .clk(clk),
  .rst(rst),
  .adr(y_adr),
  .data(y_wr_data),
  .wr(y_wr),
  .req(adc_spi_task_req),
  .ack(adc_spi_task_ack),
  .val(adc_spi_task_val)
);
assign adc_spi_req = adc_spi_task_req[0];
assign adc_spi_task_ack[0] = adc_spi_ack;

wire[15:0] dac_spi_task_val;
wire[15:0] dac_spi_task_req;
wire[15:0] dac_spi_task_ack;
task_reg #(.P_TASK_ADR(12'hbd5)) DAC_SPI_TASK_0 (
  .clk(clk),
  .rst(rst),
  .adr(y_adr),
  .data(y_wr_data),
  .wr(y_wr),
  .req(dac_spi_task_req),
  .ack(dac_spi_task_ack),
  .val(dac_spi_task_val)
);
assign dac_spi_req = dac_spi_task_req[0];
assign dac_spi_task_ack[0] = dac_spi_ack;

wire[15:0] slo_spi_task_val;
wire[15:0] slo_spi_task_req;
wire[15:0] slo_spi_task_ack;
task_reg #(.P_TASK_ADR(12'heff)) SLO_ADC_SPI_TASK_0 (
  .clk(clk),
  .rst(rst),
  .adr(y_adr),
  .data(y_wr_data),
  .wr(y_wr),
  .req(slo_spi_task_req),
  .ack(slo_spi_task_ack),
  .val(slo_spi_task_val)
);
assign slo_adc_req = slo_spi_task_req[2];
assign slo_spi_task_ack[2] = slo_adc_ack;

// I2C Master 0 tasks
wire [15:0] i2cm_0_task_val;
wire [15:0] i2cm_0_task_req;
wire [15:0] i2cm_0_task_ack; 
task_reg #(.P_TASK_ADR(12'hb9c)) I2CM_0_TASK_REG_0 (
  .clk(clk),
  .rst(rst),
  .adr(y_adr),
  .data(y_wr_data),
  .wr(y_wr),
  .req(i2cm_0_task_req),
  .ack(i2cm_0_task_ack),
  .val(i2cm_0_task_val)
);
assign i2cm_0_tx_fifo_wr_req = i2cm_0_task_req[0];
assign i2cm_0_rx_fifo_rd_req = i2cm_0_task_req[1];
assign i2cm_0_ex_req         = i2cm_0_task_req[2];
assign i2cm_0_task_ack[0] = i2cm_0_ack;
assign i2cm_0_task_ack[1] = i2cm_0_ack;
assign i2cm_0_task_ack[2] = i2cm_0_ack; 

// pg op task reg
reg pg_req_start = 0;
// synchronize ack
wire pg_ack_s;
sync PGACKSYNC(.clk(clk), .rst_n(!rst), .a(pg_ack), .y(pg_ack_s));
always @(posedge clk) begin
  pg_req <= pg_req;

  // also drop req if memory interface is reset
  // (rst is active low, so it's really an enable)
  if (pg_ack_s || !ddr3_sys_rst) begin
    pg_req <= 0;
  end

  else if (pg_req_start && !pg_ack_s) begin
    pg_req <= 1;
  end
end
wire pg_task_val = pg_ack_s || pg_req;

// hbuf_flush task reg
reg flush_req_start = 0;
always @(posedge clk) begin
  hbuf_flush_req <= hbuf_flush_req;

  if (hbuf_flush_ack || !hbuf_enable) begin
    hbuf_flush_req <= 0;
  end

  else if (flush_req_start && !hbuf_flush_ack) begin
    hbuf_flush_req <= 1;
  end
end
wire flush_req_val = hbuf_flush_req || hbuf_flush_ack;

// hbuf_pg_clr task reg
reg pg_clr_req_start = 0;
always @(posedge clk) begin
  hbuf_pg_clr_req <= hbuf_pg_clr_req;

  if (hbuf_pg_clr_ack || !hbuf_enable) begin
    hbuf_pg_clr_req <= 0;
  end

  else if (pg_clr_req_start && !hbuf_pg_clr_ack) begin
    hbuf_pg_clr_req <= 1;
  end
end
wire pg_clr_req_val = hbuf_pg_clr_req || hbuf_pg_clr_ack;

// synchronize ddr3_cal_complete
wire ddr3_cal_complete_s;
sync CALSYNC(.clk(clk), .rst_n(!rst), .a(ddr3_cal_complete), .y(ddr3_cal_complete_s));

//////////////////////////////////////////////////////////////////////////////
// Read registers
reg[15:0] dpram_len;

wire [15:0] dpram_rd_data_a;
wire [15:0] dpram_rd_data_b;
wire [15:0] direct_rdout_dpram_data;
reg[15:0] xdom_dpram_rd_data;

// dpram rd mux sel
reg[15:0] dpram_sel = 0;
reg[15:0] test_ctrl_reg = 16'b0;
reg dpram_done = 0;

reg[N_CHANNELS-1:0] pulser_sw_trig_mask = 0;
reg[N_CHANNELS-1:0] sw_trig_mask = 0;
reg[N_CHANNELS-1:0] trig_arm_mask = 0;
reg[31:0] afe_pulser_period = 0;
reg[5:0] pulser_trig_single = 0;
reg[5:0] periodic_pulser_enable = 0;

reg[N_CHANNELS-1:0] cal_trig_sw_trig_mask = 0;
reg[31:0] fpga_cal_trig_period = 0;
reg fpga_cal_trig_single = 0;
reg fpga_cal_trig_periodic_en = 0;

// MDOMREV1: Masking off three LSBs because the MIG bursts 8 words
//           at a time. (1Word = 16b)
// MDOMREV2: handles converting DDR3 16-bit word address from xdom
//           into the byte address used by the memory controller
reg[26:0] pg_req_addr_16b = 0;
// assign pg_req_addr = {pg_req_addr_16b, 1'b0};
// assign pg_req_addr = {pg_req_addr_16b};
   assign pg_req_addr = {pg_req_addr_16b[26:3],3'b000};

always @(*)
 begin
    case(y_adr)
      12'hfff: begin y_rd_data =       vnum;                                                   end
      12'hfe3: begin y_rd_data =       ltc_task_val;                                           end
      12'hfe2: begin y_rd_data =       ltc_rd_data[47:32];                                     end
      12'hfe1: begin y_rd_data =       ltc_rd_data[31:16];                                     end
      12'hfe0: begin y_rd_data =       ltc_rd_data[15:0];                                      end
      12'heff: begin y_rd_data =       slo_spi_task_val;                                       end
      12'hdff: begin y_rd_data =       {15'b0, dpram_done};                                    end
      12'hdfe: begin y_rd_data =       dpram_len;                                              end
      12'hdf9: begin y_rd_data =       dpram_sel;                                              end
      12'hdf8: begin y_rd_data =       {13'b0, slo_adc_wr_data[18:16]};                        end
      12'hdf7: begin y_rd_data =       {13'b0, slo_adc_rd_data[18:16]};                        end
      12'hdf6: begin y_rd_data =       {15'b0, slo_adc_chip_sel};                              end
      12'hdf5: begin y_rd_data =       {15'b0, slo_adc_nconvst};                               end
      12'hdf4: begin y_rd_data =       {15'b0, wvb_reader_enable};                             end
      12'hdf2: begin y_rd_data =       {15'b0, wvb_reader_dpram_mode};                         end
      12'hde4: begin y_rd_data =       slo_adc_wr_data[15:0];                                  end
      12'hde3: begin y_rd_data =       slo_adc_rd_data[15:0];                                  end
      12'hcc4: begin y_rd_data =       {15'b0, icm_fpga_sync_en};                              end
      12'hcb6: begin y_rd_data =       {14'h0, icm_sync_err, icm_sync_rdy};                    end
      12'hcb5: begin y_rd_data =       expected_sync_ltc[47:32];                               end
      12'hcb4: begin y_rd_data =       expected_sync_ltc[31:16];                               end
      12'hcb3: begin y_rd_data =       expected_sync_ltc[15:0];                                end
      12'hcb2: begin y_rd_data =       received_sync_ltc[47:32];                               end
      12'hcb1: begin y_rd_data =       received_sync_ltc[31:16];                               end
      12'hcb0: begin y_rd_data =       received_sync_ltc[15:0];                                end
      12'hcaf: begin y_rd_data =       icm_sync_err_cnt;                                       end
`ifdef MDOMREV1
      12'hbfe: begin y_rd_data =       {7'b0,
                                        global_trig_en,
                                        global_trig_pol,
                                        wvb_trig_ext_trig_en,
                                        wvb_trig_thresh_trig_en,
                                        wvb_trig_discr_trig_en,
                                        wvb_trig_discr_trig_pol,
                                        wvb_trig_lt,
                                        wvb_trig_gt,
                                        wvb_trig_et};                                          end
`endif 
`ifndef MDOMREV1
      12'hbfe: begin y_rd_data =       {5'b0,
					cal_trig_trig_en,
					cal_trig_trig_pol,
					global_trig_en,
					global_trig_pol,
					wvb_trig_ext_trig_en,
					wvb_trig_thresh_trig_en, // Tue 06/07/2022_13:36:13.39 v0x25 fixes missing from v0x22
                                        wvb_trig_discr_trig_en,
                                        wvb_trig_discr_trig_pol,
                                        wvb_trig_lt,
                                        wvb_trig_gt,
                                        wvb_trig_et};                                          end
 `endif
      12'hbfd: begin y_rd_data =       {4'b0, wvb_trig_thr};                                   end
      12'hbfc: begin y_rd_data =       {8'b0, sw_trig_mask[N_CHANNELS-1:16]};                  end
      12'hbfb: begin y_rd_data =       sw_trig_mask[15:0];                                     end
      12'hbfa: begin y_rd_data =       {8'b0, trig_arm_mask[N_CHANNELS-1:16]};                 end
      12'hbf9: begin y_rd_data =       trig_arm_mask[15:0];                                    end
      12'hbf8: begin y_rd_data =       16'b0;                                                  end
      12'hbf7: begin y_rd_data =       {15'b0, wvb_trig_mode};                                 end
      12'hbf6: begin y_rd_data =       {8'b0, wvb_armed[N_CHANNELS-1:16]};                     end
      12'hbf5: begin y_rd_data =       wvb_armed[15:0];                                        end
      12'hbf4: begin y_rd_data =       {15'b0, wvb_cnst_run};                                  end
      12'hbf3: begin y_rd_data =       {4'b0, wvb_cnst_config};                                end
      12'hbf2: begin y_rd_data =       {4'b0, wvb_test_config};                                end
      12'hbf1: begin y_rd_data =       {8'b0, wvb_post_config};                                end
      12'hbf0: begin y_rd_data =       {11'b0, wvb_pre_config};                                end
      12'hbef: begin y_rd_data =       {11'b0, buf_status_sel};                                end
      12'hbee: begin y_rd_data =       buf_n_wfms_mux_out_reg;                                 end
      12'hbed: begin y_rd_data =       wds_used_mux_out_reg;                                   end
      12'hbec: begin y_rd_data =       {8'b0, wvb_overflow[N_CHANNELS-1:16]};                  end
      12'hbeb: begin y_rd_data =       wvb_overflow[15:0];                                     end
      12'hbea: begin y_rd_data =       {8'b0, wvb_rst[N_CHANNELS-1:16]};                       end
      12'hbe9: begin y_rd_data =       wvb_rst[15:0];                                          end
      12'hbe8: begin y_rd_data =       {8'b0, wvb_hdr_full[N_CHANNELS-1:16]};                  end
      12'hbe7: begin y_rd_data =       wvb_hdr_full[15:0];                                     end
      12'hbe6: begin y_rd_data =       {11'b0, io_ctrl_sel};                                   end
      12'hbe5: begin y_rd_data =       {7'b0,
                                        i_discr_bitslip,
                                        1'b0,
                                        i_adc_bitslip[1],
                                        i_adc_delay_ce[1],
                                        i_adc_delay_inc[1],
                                        1'b0,
                                        i_adc_bitslip[0],
                                        i_adc_delay_ce[0],
                                        i_adc_delay_inc[0]};                                   end
      12'hbe4: begin y_rd_data =       {6'b0, delay_tap_mux_out_reg};                          end
      12'hbe3: begin y_rd_data =       {8'b0, adc_io_reset[23:16]};                            end
      12'hbe2: begin y_rd_data =       adc_io_reset[15:0];                                     end
      12'hbe1: begin y_rd_data =       {8'b0, adc_delay_reset[23:16]};                         end
      12'hbe0: begin y_rd_data =       adc_delay_reset[15:0];                                  end
      12'hbdf: begin y_rd_data =       {8'b0, discr_io_reset[23:16]};                          end
      12'hbde: begin y_rd_data =       discr_io_reset[15:0];                                   end
      12'hbdd: begin y_rd_data =       {15'b0, adc_reset};                                     end
      12'hbdc: begin y_rd_data =       {10'b0, adc_spi_sel};                                   end
      12'hbdb: begin y_rd_data =       adc_spi_task_val;                                       end
      12'hbda: begin y_rd_data =       {8'b0, adc_spi_wr_data[23:16]};                         end
      12'hbd9: begin y_rd_data =       adc_spi_wr_data[15:0];                                  end
      12'hbd8: begin y_rd_data =       {8'b0, adc_spi_rd_data};                                end
      12'hbd7: begin y_rd_data =       {13'b0, dac_spi_sel};                                   end
      12'hbd6: begin y_rd_data =       {13'b0, dac_chip_sel};                                  end
      12'hbd5: begin y_rd_data =       dac_spi_task_val;                                       end
      12'hbd4: begin y_rd_data =       dac_spi_wr_data[31:16];                                 end
      12'hbd3: begin y_rd_data =       dac_spi_wr_data[15:0];                                  end
      12'hbd2: begin y_rd_data =       pulser_width;                                           end
      12'hbd1: begin y_rd_data =       {10'b0, pulser_io_rst};                                 end
      12'hbd0: begin y_rd_data =       {8'b0, pulser_sw_trig_mask[N_CHANNELS-1:16]};           end
      12'hbcf: begin y_rd_data =       pulser_sw_trig_mask[15:0];                              end
      12'hbce: begin y_rd_data =       {10'b0, pulser_trig_single};                            end
      12'hbcd: begin y_rd_data =       {5'b0, pg_req_addr_16b[26:16]};                         end
      12'hbcc: begin y_rd_data =       pg_req_addr_16b[15:0];                                  end
      12'hbcb: begin y_rd_data =       {15'b0, pg_optype};                                     end
      12'hbca: begin y_rd_data =       {15'b0, pg_task_val};                                   end
      12'hbc9: begin y_rd_data =       {15'b0, ddr3_sys_rst};                                  end
      12'hbc8: begin y_rd_data =       {15'b0, ddr3_cal_complete_s};                           end
      12'hbc7: begin y_rd_data =       {5'b0, ddr3_device_temp};                               end
      12'hbc6: begin y_rd_data =       {15'b0, ddr3_ui_sync_rst};                              end
      12'hbc5: begin y_rd_data =       {15'b0, hbuf_enable};                                   end
      12'hbc4: begin y_rd_data =       hbuf_start_pg;                                          end
      12'hbc3: begin y_rd_data =       hbuf_stop_pg;                                           end
      12'hbc2: begin y_rd_data =       hbuf_first_pg;                                          end
      12'hbc1: begin y_rd_data =       hbuf_last_pg;                                           end
      12'hbc0: begin y_rd_data =       hbuf_pg_clr_count;                                      end
      12'hbbf: begin y_rd_data =       {14'b0, pg_clr_req_val, flush_req_val};                 end
      12'hbbe: begin y_rd_data =       hbuf_rd_pg_num;                                         end
      12'hbbd: begin y_rd_data =       hbuf_wr_pg_num;                                         end
      12'hbbc: begin y_rd_data =       hbuf_n_used_pgs;                                        end
      12'hbbb: begin y_rd_data =       {13'b0,
                                        hbuf_buffered_data,
                                        hbuf_full, hbuf_empty};                                end
      12'hbba: begin y_rd_data =        scaler_period[31:16];                                  end
      12'hbb9: begin y_rd_data =        scaler_period[15:0];                                   end
      12'hbb8: begin y_rd_data =        {11'b0, scaler_sel};                                   end
      12'hbb7: begin y_rd_data =        disc_scaler_mux_out_reg[31:16];                        end
      12'hbb6: begin y_rd_data =        disc_scaler_mux_out_reg[15:0];                         end
      12'hbb5: begin y_rd_data =        scaler_inhibit_len[31:16];                             end
      12'hbb4: begin y_rd_data =        scaler_inhibit_len[15:0];                              end
      12'hbb3: begin y_rd_data =        afe_pulser_period[31:16];                              end
      12'hbb2: begin y_rd_data =        afe_pulser_period[15:0];                               end
      12'hbb1: begin y_rd_data =        {10'b0, periodic_pulser_enable};                       end
      12'hbb0: begin y_rd_data =        thresh_scaler_mux_out_reg[31:16];                      end
      12'hbaf: begin y_rd_data =        thresh_scaler_mux_out_reg[15:0];                       end
      12'hbae: begin y_rd_data =        {14'b0, ddr3_vtt_s5, ddr3_vtt_s3};                     end
      12'hbad: begin y_rd_data =        {8'b0, wvb_not_empty[N_CHANNELS-1:16]};                end
      12'hbac: begin y_rd_data =        wvb_not_empty[15:0];                                   end
      12'hbab: begin y_rd_data =        {15'b0, |wvb_not_empty};                               end
      12'hbaa: begin y_rd_data =        {14'b0, bsum_pause_override, bsum_pause};              end
      12'hba9: begin y_rd_data =        {13'b0, bsum_len_sel};                                 end
      12'hba8: begin y_rd_data =        bsum_pause_len;                                        end
      12'hba7: begin y_rd_data =        {4'b0, bsum_dev_low};                                  end
      12'hba6: begin y_rd_data =        {4'b0, bsum_dev_high};                                 end
      12'hba5: begin y_rd_data =        fpga_cal_trig_width;                                   end
      12'hba4: begin y_rd_data =        {14'b0, fpga_cal_trig_pol, fpga_cal_trig_io_rst};      end
      12'hba3: begin y_rd_data =        {15'b0, fpga_cal_trig_single};                         end
      12'hba2: begin y_rd_data =        fpga_cal_trig_period[31:16];                           end
      12'hba1: begin y_rd_data =        fpga_cal_trig_period[15:0];                            end
      12'hba0: begin y_rd_data =        {15'b0, fpga_cal_trig_periodic_en};                    end
      12'hb9f: begin y_rd_data =        {15'b0, dcdc_sync};                                    end
      12'hb9e: begin y_rd_data =        {8'b0, cal_trig_sw_trig_mask[N_CHANNELS-1:16]};        end
      12'hb9d: begin y_rd_data =        cal_trig_sw_trig_mask[15:0];                           end
      12'hb9c: begin y_rd_data =        i2cm_0_task_val;                                       end
      12'hb9b: begin y_rd_data =       {i2cm_0_i2c_start,
                                        i2cm_0_i2c_ack,
                                        i2cm_0_i2c_stop,
                                        i2cm_0_i2c_r_wn,
                                        4'h0,
                                        i2cm_0_tx_data};                                       end
      12'hb9a: begin y_rd_data =       {i2cm_0_rx_fifo_full,
                                        i2cm_0_rx_fifo_empty,
                                        5'h0,
                                        i2cm_0_i2c_acked, 
                                        i2cm_0_rx_data};                                       end
      12'hb99: begin y_rd_data =        {8'b0, global_trig_src_mask[N_CHANNELS-1:16]};         end
      12'hb98: begin y_rd_data =        global_trig_src_mask[15:0];                            end
      12'hb97: begin y_rd_data =        {8'b0, global_trig_rcv_mask[N_CHANNELS-1:16]};         end
      12'hb96: begin y_rd_data =        global_trig_rcv_mask[15:0];                            end
      12'hb95: begin y_rd_data =        {8'h0,xdom_trig_en[23:16]};                            end
      12'hb94: begin y_rd_data =        xdom_trig_en[15:0];                                    end
      12'hb93: begin y_rd_data =        lc_window_width;                                       end
      12'hb92: begin y_rd_data =        n_lc_thr;                                              end
      12'hb91: begin y_rd_data =        {15'h0,lc_required};                                   end
      12'hb90: begin y_rd_data =        {4'h0,xdom_thermal_shutdown_temp}; end
      default:
        begin
          y_rd_data = xdom_dpram_rd_data;
        end

    endcase
end

///////////////////////////////////////////////////////////////////////////////
// Write registers (not task regs)
always @(posedge clk)
 begin
    // clear registers that automatically reset (e.g. one shots)
    xdom_trig_run <= 0;
    dpram_done <= 0;
    xdom_wvb_arm <= 0;

    pg_req_start <= 0;
    flush_req_start <= 0;
    pg_clr_req_start <= 0;

    i_adc_delay_ce <= 0;
    i_adc_bitslip <= 0;
    i_discr_bitslip <= 0;

    pulser_trig_single <= 0;
    fpga_cal_trig_single <= 0;

    slo_nconvst_os <= 0;

    if(y_wr)
      case(y_adr)
        12'hdff: begin dpram_done <= y_wr_data[0];                                             end
        12'hdf9: begin dpram_sel <= y_wr_data;                                                 end
        12'hdf8: begin slo_adc_wr_data[18:16] <= y_wr_data[2:0];                               end
        12'hdf6: begin slo_adc_chip_sel <= y_wr_data[0];                                       end
        12'hdf5: begin slo_nconvst_os <= y_wr_data[0];                                         end
        12'hdf4: begin wvb_reader_enable <= y_wr_data[0];                                      end
        12'hdf2: begin wvb_reader_dpram_mode <= y_wr_data[0];                                  end
        12'hde4: begin slo_adc_wr_data[15:0] <= y_wr_data;                                     end
        12'hcc4: begin icm_fpga_sync_en <= y_wr_data[0];                                       end
        12'hbfe: begin
          wvb_trig_et <= y_wr_data[0];
          wvb_trig_gt <= y_wr_data[1];
          wvb_trig_lt <= y_wr_data[2];
          wvb_trig_discr_trig_pol <= y_wr_data[3];
          wvb_trig_discr_trig_en <= y_wr_data[4];
          wvb_trig_thresh_trig_en <= y_wr_data[5];
          wvb_trig_ext_trig_en <= y_wr_data[6];
	  global_trig_pol <= y_wr_data[7];
          global_trig_en <= y_wr_data[8];
 `ifndef MDOMREV1
	  cal_trig_trig_pol <= y_wr_data[9];
	  cal_trig_trig_en <= y_wr_data[10];
 `endif
        end
        12'hbfd: begin wvb_trig_thr <= y_wr_data[11:0];                                        end
        12'hbfc: begin sw_trig_mask[N_CHANNELS-1:16] <= y_wr_data[7:0];                        end
        12'hbfb: begin sw_trig_mask[15:0] <= y_wr_data;                                        end
        12'hbfa: begin trig_arm_mask[N_CHANNELS-1:16] <= y_wr_data[7:0];                       end
        12'hbf9: begin trig_arm_mask[15:0] <= y_wr_data;                                       end
        12'hbf8: begin
          if (y_wr_data[0]) xdom_trig_run <= sw_trig_mask;
          if (y_wr_data[1]) xdom_wvb_arm <= trig_arm_mask;
        end
        12'hbf7: begin wvb_trig_mode <= y_wr_data[0];                                          end
        12'hbf4: begin wvb_cnst_run <= y_wr_data[0];                                           end
        12'hbf3: begin wvb_cnst_config <= y_wr_data[11:0];                                     end
        12'hbf2: begin wvb_test_config <= y_wr_data[11:0];                                     end
        12'hbf1: begin wvb_post_config <= y_wr_data[7:0];                                      end
        12'hbf0: begin wvb_pre_config <= y_wr_data[4:0];                                       end
        12'hbef: begin buf_status_sel <= y_wr_data[4:0];                                       end
        12'hbea: begin wvb_rst[N_CHANNELS-1:16] <= y_wr_data[7:0];                             end
        12'hbe9: begin wvb_rst[15:0] <= y_wr_data;                                             end
        12'hbe6: begin io_ctrl_sel <= y_wr_data[4:0];                                          end
        12'hbe5: begin
          i_adc_delay_inc[0] <= y_wr_data[0];
          i_adc_delay_ce[0] <= y_wr_data[1];
          i_adc_bitslip[0] <= y_wr_data[2];
          i_adc_delay_inc[1] <= y_wr_data[4];
          i_adc_delay_ce[1] <= y_wr_data[5];
          i_adc_bitslip[1] <= y_wr_data[6];
          i_discr_bitslip <= y_wr_data[8];
        end
        12'hbe3: begin adc_io_reset[23:16] <= y_wr_data[7:0];                                  end
        12'hbe2: begin adc_io_reset[15:0] <= y_wr_data;                                        end
        12'hbe1: begin adc_delay_reset[23:16] <= y_wr_data[7:0];                               end
        12'hbe0: begin adc_delay_reset[15:0] <= y_wr_data;                                     end
        12'hbdf: begin discr_io_reset[23:16] <= y_wr_data[7:0];                                end
        12'hbde: begin discr_io_reset[15:0] <= y_wr_data;                                      end
        12'hbdd: begin adc_reset <= y_wr_data[0];                                              end
        12'hbdc: begin adc_spi_sel <= y_wr_data[5:0];                                          end
        12'hbda: begin adc_spi_wr_data[23:16] <= y_wr_data[7:0];                               end
        12'hbd9: begin adc_spi_wr_data[15:0] <= y_wr_data;                                     end
        12'hbd7: begin dac_spi_sel <= y_wr_data[2:0];                                          end
        12'hbd6: begin dac_chip_sel <= y_wr_data[2:0];                                         end
        12'hbd4: begin dac_spi_wr_data[31:16] <= y_wr_data;                                    end
        12'hbd3: begin dac_spi_wr_data[15:0] <= y_wr_data;                                     end
        12'hbd2: begin pulser_width <= y_wr_data;                                              end
        12'hbd1: begin pulser_io_rst <= y_wr_data[5:0];                                        end
        12'hbd0: begin pulser_sw_trig_mask[N_CHANNELS-1:16] <= y_wr_data[7:0];                 end
        12'hbcf: begin pulser_sw_trig_mask[15:0] <= y_wr_data;                                 end
        12'hbce: begin
          pulser_trig_single <= y_wr_data[5:0];
          xdom_trig_run <= pulser_sw_trig_mask;
        end
        12'hbcd: begin pg_req_addr_16b[26:16] <= y_wr_data[10:0];                                  end
        12'hbcc: begin pg_req_addr_16b[15:0] <= y_wr_data[15:0];                                   end
        12'hbcb: begin pg_optype <= y_wr_data[0];                                              end
        12'hbca: begin pg_req_start <= y_wr_data[0];                                           end
        12'hbc9: begin ddr3_sys_rst <= y_wr_data[0];                                           end
        12'hbc5: begin hbuf_enable <= y_wr_data[0];                                            end
        12'hbc4: begin hbuf_start_pg <= y_wr_data;                                             end
        12'hbc3: begin hbuf_stop_pg <= y_wr_data;                                              end
        12'hbc0: begin hbuf_pg_clr_count <= y_wr_data;                                         end
        12'hbbf: begin
          flush_req_start <= y_wr_data[0];
          pg_clr_req_start <= y_wr_data[1];
        end
        12'hbba: begin scaler_period[31:16] <= y_wr_data;                                      end
        12'hbb9: begin scaler_period[15:0] <= y_wr_data;                                       end
        12'hbb8: begin scaler_sel <= y_wr_data[4:0];                                           end
        12'hbb5: begin scaler_inhibit_len[31:16] <= y_wr_data;                                 end
        12'hbb4: begin scaler_inhibit_len[15:0] <= y_wr_data;                                  end
        12'hbb3: begin afe_pulser_period[31:16] <= y_wr_data;                                  end
        12'hbb2: begin afe_pulser_period[15:0] <= y_wr_data;                                   end
        12'hbb1: begin periodic_pulser_enable <= y_wr_data[5:0];                               end
        12'hbae: begin
          ddr3_vtt_s3 <= y_wr_data[0];
          ddr3_vtt_s5 <= y_wr_data[1];
        end
        12'hbaa: begin
          bsum_pause <= y_wr_data[0];
          bsum_pause_override <= y_wr_data[1];
        end
        12'hba9: begin bsum_len_sel <= y_wr_data[2:0];                                         end
        12'hba8: begin bsum_pause_len <= y_wr_data;                                            end
        12'hba7: begin bsum_dev_low <= y_wr_data[11:0];                                        end
        12'hba6: begin bsum_dev_high <= y_wr_data[11:0];                                       end
        12'hba5: begin fpga_cal_trig_width <= y_wr_data;                                       end
        12'hba4: begin
          fpga_cal_trig_io_rst <= y_wr_data[0];
          fpga_cal_trig_pol <= y_wr_data[1];
        end
        12'hba3: begin
          fpga_cal_trig_single <= y_wr_data[0];
          xdom_trig_run <= cal_trig_sw_trig_mask;
        end
        12'hba2: begin fpga_cal_trig_period[31:16] <= y_wr_data;                               end
        12'hba1: begin fpga_cal_trig_period[15:0] <= y_wr_data;                                end
        12'hba0: begin fpga_cal_trig_periodic_en <= y_wr_data[0];                              end
        12'hb9f: begin dcdc_sync <= y_wr_data[0];                                              end
        12'hb9e: begin cal_trig_sw_trig_mask[N_CHANNELS-1:16] <= y_wr_data[7:0];               end
        12'hb9d: begin cal_trig_sw_trig_mask[15:0] <= y_wr_data;                               end
        12'hb9b: begin 
          i2cm_0_i2c_start <= y_wr_data[15];
          i2cm_0_i2c_ack   <= y_wr_data[14];
          i2cm_0_i2c_stop  <= y_wr_data[13];
          i2cm_0_i2c_r_wn  <= y_wr_data[12];
          i2cm_0_tx_data   <= y_wr_data[7:0]; 
        end
        12'hb99: begin global_trig_src_mask[N_CHANNELS-1:16] <= y_wr_data[7:0];                end
        12'hb98: begin global_trig_src_mask[15:0] <= y_wr_data;                                end
        12'hb97: begin global_trig_rcv_mask[N_CHANNELS-1:16] <= y_wr_data[7:0];                end
        12'hb96: begin global_trig_rcv_mask[15:0] <= y_wr_data;                                end
	12'hb95: begin xdom_trig_en[23:16] <= y_wr_data[7:0];                                  end
	12'hb94: begin xdom_trig_en[15:0]  <= y_wr_data;                                       end
        12'hb93: begin lc_window_width <= y_wr_data;                                           end
	12'hb92: begin n_lc_thr <= y_wr_data;                                                  end
	12'hb91: begin lc_required <= y_wr_data[0];                                            end
	12'hb90: begin xdom_thermal_shutdown_temp <= y_wr_data[11:0];                          end
	default: begin                                                                         end
      endcase
end // always @ (posedge clk)

// AFE pulser trigger outputs
wire periodic_afe_trig;
periodic_trigger_gen AFE_TRIG_GEN(.clk(clk), .rst(rst),
                                  .period(afe_pulser_period),
                                  .trig(periodic_afe_trig));
assign pulser_trig_out = pulser_trig_single | ({6{periodic_afe_trig}} & periodic_pulser_enable);

// FPGA cal trigger output
wire periodic_cal_trig;
periodic_trigger_gen CAL_TRIG_GEN(.clk(clk), .rst(rst),
                                  .period(fpga_cal_trig_period),
                                  .trig(periodic_cal_trig));
assign fpga_cal_trig_trig = fpga_cal_trig_single || (periodic_cal_trig && fpga_cal_trig_periodic_en);

// wire [15:0] dpram_wr_data_a = 16'b0;
// wire        dpram_wr_a = 1'b0;
// wire [11:0] dpram_addr_a = 12'b0;

// DDR3 transfer dpram
wire[15:0] ddr3_dpram_xdom_out;
XDOM_DDR3_PG PG_DPRAM
(
  .clka(clk),
  .wea(y_wr && (y_adr[11]==0) && (dpram_sel == 0)),
  .addra(y_adr[10:0]),
  .dina(y_wr_data),
  .douta(ddr3_dpram_xdom_out),
  .clkb(ddr3_ui_clk),
  .web(ddr3_dpram_wren),
  .addrb(ddr3_dpram_addr),
  .dinb(ddr3_dpram_din),
  .doutb(ddr3_dpram_dout)
);

// direct readout DPRAM (rd only from xdom)
DIRECT_RDOUT_DPRAM RDOUT_DPRAM
(
  .clka(clk),
  .wea(rdout_dpram_wren),
  .addra(rdout_dpram_wr_addr),
  .dina(rdout_dpram_data),
  .clkb(clk),
  .addrb(y_adr[10:0]),
  .doutb(direct_rdout_dpram_data)
);

//
// place rbd logic here for now
//
always @(posedge clk) begin
  if (rst) begin
    dpram_busy <= 0;
    dpram_len <= 0;
  end

  else begin
    if (rdout_dpram_run) begin
      dpram_len <= dpram_len_in;
      dpram_busy <= 1;
    end

    else if (dpram_done) begin
      dpram_busy <= 0;
      dpram_len <= 0;
    end
  end
end

//
// DPRAM read mux
//
always @(*) begin
  case (dpram_sel)
    // 0: xdom_dpram_rd_data = dpram_rd_data_b;
    0: xdom_dpram_rd_data = ddr3_dpram_xdom_out;
    1: xdom_dpram_rd_data = direct_rdout_dpram_data;
    2: xdom_dpram_rd_data = direct_rdout_dpram_data;
    3: xdom_dpram_rd_data = direct_rdout_dpram_data;
    4: xdom_dpram_rd_data = direct_rdout_dpram_data;
    default: xdom_dpram_rd_data = direct_rdout_dpram_data;
  endcase
end

endmodule
