module mDOM_wvb_hdr_bundle_2_fan_out
  (
   bundle,
   evt_ltc,
   start_addr,
   stop_addr,
   trig_src,
   cnst_run,
   pre_conf,
   sync_rdy
  );

`include "mDOM_wvb_hdr_bundle_2_inc.v"

   input [79:0] bundle;
   output [48:0] evt_ltc;
   output [10:0] start_addr;
   output [10:0] stop_addr;
   output [1:0] trig_src;
   output [0:0] cnst_run;
   output [4:0] pre_conf;
   output [0:0] sync_rdy;

assign evt_ltc = bundle[48:0];
assign start_addr = bundle[59:49];
assign stop_addr = bundle[70:60];
assign trig_src = bundle[72:71];
assign cnst_run = bundle[73:73];
assign pre_conf = bundle[78:74];
assign sync_rdy = bundle[79:79];

endmodule
