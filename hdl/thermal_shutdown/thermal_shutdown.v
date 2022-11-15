// T. Anderson Mon 11/14/2022_16:57:38.62
// Generate a thermal shutdown if we exceed the thermal shutdown
//    temperature for more than 1 second.
module thermal_shutdown
  (
   input 	clk,
   input device_temp_rdy, 
   input [11:0] device_temp,
   input [11:0] thermal_shutdown_temp,
   output reg 	thermal_shutdown = 1'b0
   );

   // Synchronize
   reg [1:0] i_device_temp_rdy = 2'b00;
   always @(posedge clk) i_device_temp_rdy <= {i_device_temp_rdy[0],device_temp_rdy}; 
   
   localparam I_CNT_MAX = 28'd20000000; // 1 second for a 20MHz clock 
   reg [27:0] i_cnt = 0;
   always @(posedge clk)
     if((device_temp > thermal_shutdown_temp) && i_device_temp_rdy[1])
       i_cnt <= i_cnt + 1;
     else
       i_cnt <= 0;

   always @(posedge clk)
     if(i_cnt >= I_CNT_MAX)
       thermal_shutdown <= 1'b1; 

   
endmodule
