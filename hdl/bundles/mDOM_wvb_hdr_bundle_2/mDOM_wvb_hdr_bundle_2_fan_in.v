module mDOM_wvb_hdr_bundle_2_fan_in
  (
   bundle,
   evt_ltc,
   start_addr,
   stop_addr,
   trig_src,
   cnst_run,
   pre_conf
  );

`include "mDOM_wvb_hdr_bundle_2_inc.v"

   output [78:0] bundle;
   input [48:0] evt_ltc;
   input [10:0] start_addr;
   input [10:0] stop_addr;
   input [1:0] trig_src;
   input [0:0] cnst_run;
   input [4:0] pre_conf;

assign bundle[48:0] = evt_ltc;
assign bundle[59:49] = start_addr;
assign bundle[70:60] = stop_addr;
assign bundle[72:71] = trig_src;
assign bundle[73:73] = cnst_run;
assign bundle[78:74] = pre_conf;


endmodule
