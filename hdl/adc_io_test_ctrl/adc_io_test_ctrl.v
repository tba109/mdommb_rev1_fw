// 
// Power down the ADC chips via SPI, verify they are off, 
// then begin toggling the output
// 

module adc_io_test_ctrl #(parameter TOGGLE_PERIOD = 1000,
                          parameter WAIT_PERIOD = 10,
                          parameter RESET_PERIOD = 10) (
  input clk,
  input rst,

  output reg spi_req = 0,
  output reg[23:0] adc_spi_wr_data = 0,
  input spi_ack,
  input[7:0] adc_spi_rd_data,

  output reg adc_reset = 0,

  output[3:0] state,
  output reg toggle = 0
);

// ADC3424 power down register: 0x15
// want to write 0x04 (global power down)
localparam[7:0] PDN_REG_ADDR = 8'h15; 
localparam[7:0] PDN_REG_DATA = 8'h04;
localparam[23:0] PDN_WR = {1'b0, 1'b1, 6'b0, PDN_REG_ADDR, PDN_REG_DATA};
localparam[23:0] PDN_RD = {1'b1, 1'b1, 6'b0, PDN_REG_ADDR, 8'b0};

// states
localparam
  S_IDLE = 0,
  S_WAIT = 1,
  S_PULSE_RESET = 2,
  S_POST_RESET = 3,
  S_WR_REQ = 4,
  S_WR_ACK_WAIT = 5,
  S_RD_REQ = 6,
  S_RD_ACK_WAIT = 7,
  S_TOGGLE = 8,
  S_SPI_ACK_FAILURE = 9,
  S_RD_DATA_FAILURE = 10;

reg[3:0] fsm = S_IDLE;
reg[3:0] ret = S_IDLE;

assign state = fsm;

reg[31:0] cnt = 0;
always @(posedge clk) begin
  if (rst) begin
    fsm <= S_IDLE;
    cnt <= 0;
    toggle <= 0;
    spi_req <= 0;
    adc_spi_wr_data <= 0;
    adc_reset <= 0;
  end else begin
    spi_req <= 0;
    toggle <= 0;
    adc_reset <= 0;
    case (fsm)
      S_IDLE: begin
        fsm <= S_WAIT;
        ret <= S_PULSE_RESET;
        cnt <= 0;
      end

      S_WAIT: begin
        cnt <= cnt + 1;
        if (cnt == WAIT_PERIOD - 1) begin
          cnt <= 0;
          fsm <= ret;
        end
      end

      S_PULSE_RESET: begin
        cnt <= cnt + 1;
        adc_reset <= 1;
        if (cnt == RESET_PERIOD - 1) begin
          cnt <= 0;
          adc_reset <= 0;
          fsm <= S_POST_RESET;
        end
      end
          
      S_POST_RESET: begin
        cnt <= cnt + 1;
        if (cnt == WAIT_PERIOD - 1) begin
          cnt <= 0;
          fsm <= spi_ack == 0 ? S_WR_REQ : S_SPI_ACK_FAILURE;      
        end
      end

      S_WR_REQ: begin
        spi_req <= 1;
        adc_spi_wr_data <= PDN_WR;
        if (spi_ack) begin
          spi_req <= 0;
          fsm <= S_WR_ACK_WAIT;
        end
      end

      S_WR_ACK_WAIT: begin
        if (spi_ack == 0) begin
          cnt <= 0;
          fsm <= S_WAIT;
          ret <= S_RD_REQ;
        end
      end

      S_RD_REQ: begin
        spi_req <= 1;
        adc_spi_wr_data <= PDN_RD;
        if (spi_ack) begin
          spi_req <= 0;
          fsm <= adc_spi_rd_data == PDN_REG_DATA ? S_RD_ACK_WAIT : S_RD_DATA_FAILURE;
        end
      end

      S_RD_ACK_WAIT: begin
        if (spi_ack == 0) begin
          cnt <= 0;
          fsm <= S_TOGGLE;
        end
      end

      S_TOGGLE: begin
        cnt <= cnt + 1;

        if (cnt >= TOGGLE_PERIOD - 1)  begin
          cnt <= 0;
          toggle <= ~toggle;
        end else begin
          toggle <= toggle;
        end
      end

      S_SPI_ACK_FAILURE: begin
        fsm <= S_SPI_ACK_FAILURE;
      end

      S_RD_DATA_FAILURE: begin
        fsm <= S_RD_DATA_FAILURE;
      end

      default: begin
        fsm <= S_IDLE;
      end

    endcase
  end
end


endmodule