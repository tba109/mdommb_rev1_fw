/////////////////////////////////////////////////////////////////////////////////
// Tyler Anderson Fri 07/05/2019_12:16:45.36
// local_time_counter.v
//
// Adapted from D-Egg for mDOM
// Aaron Fienberg, Jan 2021
//
// "Local Time Counter"
//  A custom Verilog HDL module.
//  Generates the 48-bit local time word.
/////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module local_time_counter #(parameter P_LTC_WIDTH = 49)
  (
   input             clk, // clock
   input             rst, // active high reset
   // Local time
   (* max_fanout = 5 *) output reg [P_LTC_WIDTH-1:0] ltc=0, // the clock counter
   // Time word synchonization
   input [P_LTC_WIDTH-1:0]      ltc_wr_data,
   input             ltc_wr_req,
   output reg        ltc_wr_ack=0,
   // Local time readout
   output reg [P_LTC_WIDTH-1:0] ltc_rd_data=0,
   input             ltc_rd_req,
   output reg        ltc_rd_ack=0
   );

   wire              ltc_wr_req_pe;
   posedge_detector PEDGE_0(.clk(clk),.rst_n(!rst),.a(ltc_wr_req),.y(ltc_wr_req_pe));
   always @(posedge clk)
     begin
        if(rst)
          begin
             ltc <= 0;
             ltc_wr_ack <= 0;
          end
        else
          begin
             ltc_wr_ack <= ltc_wr_req;
             if(ltc_wr_req_pe)
               ltc <= ltc_wr_data;
             else
               ltc <= ltc + {{P_LTC_WIDTH-1{1'b0}}, 1'b1};
          end
     end // always @ (posedge clk or posedge rst)

   wire ltc_rd_req_pe;
   posedge_detector PEDGE_1(.clk(clk),.rst_n(!rst),.a(ltc_rd_req),.y(ltc_rd_req_pe));
   always @(posedge clk)
     if(rst)
       begin
          ltc_rd_data <= 0;
          ltc_rd_ack <= 0;
       end
     else
       begin
          ltc_rd_ack <= ltc_rd_req;
          if(ltc_rd_req_pe)
            ltc_rd_data <= ltc;
       end

endmodule
