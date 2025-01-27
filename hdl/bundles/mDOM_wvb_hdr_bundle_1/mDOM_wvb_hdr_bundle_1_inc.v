// Widths
localparam
  L_WIDTH_MDOM_WVB_HDR_BUNDLE_1_EVT_LTC         = 48,
  L_WIDTH_MDOM_WVB_HDR_BUNDLE_1_START_ADDR      = 10,
  L_WIDTH_MDOM_WVB_HDR_BUNDLE_1_STOP_ADDR       = 10,
  L_WIDTH_MDOM_WVB_HDR_BUNDLE_1_TRIG_SRC        = 2,
  L_WIDTH_MDOM_WVB_HDR_BUNDLE_1_CNST_RUN        = 1;

// Start position = Previous start + Width
localparam 
  L_START_POS_MDOM_WVB_HDR_BUNDLE_1_EVT_LTC         = 0,
  L_START_POS_MDOM_WVB_HDR_BUNDLE_1_START_ADDR      = 48,
  L_START_POS_MDOM_WVB_HDR_BUNDLE_1_STOP_ADDR       = 58,
  L_START_POS_MDOM_WVB_HDR_BUNDLE_1_TRIG_SRC        = 68,
  L_START_POS_MDOM_WVB_HDR_BUNDLE_1_CNST_RUN        = 70;

// Start position = Previous start + Width
localparam 
  L_STOP_POS_MDOM_WVB_HDR_BUNDLE_1_EVT_LTC         = 47,
  L_STOP_POS_MDOM_WVB_HDR_BUNDLE_1_START_ADDR      = 57,
  L_STOP_POS_MDOM_WVB_HDR_BUNDLE_1_STOP_ADDR       = 67,
  L_STOP_POS_MDOM_WVB_HDR_BUNDLE_1_TRIG_SRC        = 69,
  L_STOP_POS_MDOM_WVB_HDR_BUNDLE_1_CNST_RUN        = 70;

// Zero pad width and bundle width
localparam L_WIDTH_MDOM_WVB_HDR_BUNDLE_1_ZERO_PAD = 0;
localparam L_WIDTH_MDOM_WVB_HDR_BUNDLE_1 = 71;
