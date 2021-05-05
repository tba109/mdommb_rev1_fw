// Aaron Fienberg
// May 2021
//
// takes the FPGA temperature reading synchronous to the DDR3 UI clk
// and outputs a temperature reading synchronous to the main logic clk

module fpga_temp_sync (
  input lclk,
  input lclk_rst,

  input ddr3_clk,
  input ddr3_clk_rst,

  input[11:0] device_temp_in,
  output reg[11:0] device_temp_out = 0
);

reg transfer_req = 0;
wire transfer_req_s;
sync REQ_SYNC(.clk(lclk), .rst_n(!lclk_rst), 
              .a(transfer_req), .y(transfer_req_s));

reg transfer_ack = 0;
wire transfer_ack_s;
sync ACK_SYNC(.clk(ddr3_clk), .rst_n(!ddr3_clk_rst), 
              .a(transfer_ack), .y(transfer_ack_s));

// 
// DDR3 clock process
// 
reg[11:0] i_device_temp = 0;
always @(posedge ddr3_clk) begin
  if (ddr3_clk_rst) begin
    transfer_req <= 0;
    i_device_temp <= 0;
  end else begin
    i_device_temp <= i_device_temp;

    if (!transfer_req && !transfer_ack_s) begin
      i_device_temp <= device_temp_in;
      transfer_req <= 1;
    end else if (transfer_req && transfer_ack_s) begin
      transfer_req <= 0;
    end
  end
end

// 
// logic clock process
// 

reg[15:0] wait_cnt = 0;
localparam MAX_WAIT_CNT = 16'd2;

always @(posedge lclk) begin
  if (lclk_rst) begin
    transfer_ack <= 0;
    device_temp_out <= 0;
    wait_cnt <= 0;
  end else begin    
    wait_cnt <= 0;
    device_temp_out <= device_temp_out;
    
    if (transfer_req_s && !transfer_ack) begin
      wait_cnt <= wait_cnt + 1;
      
      if (wait_cnt == MAX_WAIT_CNT) begin
        device_temp_out <= i_device_temp;
        wait_cnt <= 0;
        transfer_ack <= 1;
      end

    end else if (!transfer_req_s && transfer_ack) begin
      transfer_ack <= 0;
    end
  end
end

endmodule