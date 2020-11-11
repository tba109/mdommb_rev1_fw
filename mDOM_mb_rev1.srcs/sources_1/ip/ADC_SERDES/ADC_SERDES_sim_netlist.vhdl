-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Tue Nov 10 17:30:52 2020
-- Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/atfie/IceCube/mDOMDevelopment/mdommb_rev1_fw/mDOM_mb_rev1.srcs/sources_1/ip/ADC_SERDES/ADC_SERDES_sim_netlist.vhdl
-- Design      : ADC_SERDES
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7s100fgga676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ADC_SERDES_ADC_SERDES_selectio_wiz is
  port (
    data_in_from_pins_p : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_in_from_pins_n : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_in_to_device : out STD_LOGIC_VECTOR ( 5 downto 0 );
    in_delay_reset : in STD_LOGIC;
    in_delay_data_ce : in STD_LOGIC_VECTOR ( 0 to 0 );
    in_delay_data_inc : in STD_LOGIC_VECTOR ( 0 to 0 );
    in_delay_tap_in : in STD_LOGIC_VECTOR ( 4 downto 0 );
    in_delay_tap_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    bitslip : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk_in : in STD_LOGIC;
    clk_div_in : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );
  attribute DEV_W : integer;
  attribute DEV_W of ADC_SERDES_ADC_SERDES_selectio_wiz : entity is 6;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of ADC_SERDES_ADC_SERDES_selectio_wiz : entity is "ADC_SERDES_selectio_wiz";
  attribute SYS_W : integer;
  attribute SYS_W of ADC_SERDES_ADC_SERDES_selectio_wiz : entity is 1;
  attribute num_serial_bits : integer;
  attribute num_serial_bits of ADC_SERDES_ADC_SERDES_selectio_wiz : entity is 6;
end ADC_SERDES_ADC_SERDES_selectio_wiz;

architecture STRUCTURE of ADC_SERDES_ADC_SERDES_selectio_wiz is
  signal data_in_from_pins_delay : STD_LOGIC;
  signal data_in_from_pins_int : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_Q7_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \pins[0].ibufds_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of \pins[0].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of \pins[0].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of \pins[0].ibufds_inst\ : label is "AUTO";
  attribute BOX_TYPE of \pins[0].idelaye2_bus\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D : integer;
  attribute SIM_DELAY_D of \pins[0].idelaye2_bus\ : label is 0;
  attribute BOX_TYPE of \pins[0].iserdese2_master\ : label is "PRIMITIVE";
  attribute OPT_MODIFIED : string;
  attribute OPT_MODIFIED of \pins[0].iserdese2_master\ : label is "MLO";
begin
\pins[0].ibufds_inst\: unisim.vcomponents.IBUFDS
     port map (
      I => data_in_from_pins_p(0),
      IB => data_in_from_pins_n(0),
      O => data_in_from_pins_int
    );
\pins[0].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "VAR_LOAD",
      IDELAY_VALUE => 0,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
        port map (
      C => clk_div_in,
      CE => in_delay_data_ce(0),
      CINVCTRL => '0',
      CNTVALUEIN(4 downto 0) => in_delay_tap_in(4 downto 0),
      CNTVALUEOUT(4 downto 0) => in_delay_tap_out(4 downto 0),
      DATAIN => '0',
      DATAOUT => data_in_from_pins_delay,
      IDATAIN => data_in_from_pins_int,
      INC => in_delay_data_inc(0),
      LD => in_delay_reset,
      LDPIPEEN => '0',
      REGRST => io_reset
    );
\pins[0].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "DDR",
      DATA_WIDTH => 6,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
        port map (
      BITSLIP => bitslip(0),
      CE1 => '1',
      CE2 => '1',
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => '0',
      D => '0',
      DDLY => data_in_from_pins_delay,
      DYNCLKDIVSEL => '0',
      DYNCLKSEL => '0',
      O => \NLW_pins[0].iserdese2_master_O_UNCONNECTED\,
      OCLK => '0',
      OCLKB => '0',
      OFB => '0',
      Q1 => data_in_to_device(5),
      Q2 => data_in_to_device(4),
      Q3 => data_in_to_device(3),
      Q4 => data_in_to_device(2),
      Q5 => data_in_to_device(1),
      Q6 => data_in_to_device(0),
      Q7 => \NLW_pins[0].iserdese2_master_Q7_UNCONNECTED\,
      Q8 => \NLW_pins[0].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => '0',
      SHIFTIN2 => '0',
      SHIFTOUT1 => \NLW_pins[0].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[0].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ADC_SERDES is
  port (
    data_in_from_pins_p : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_in_from_pins_n : in STD_LOGIC_VECTOR ( 0 to 0 );
    data_in_to_device : out STD_LOGIC_VECTOR ( 5 downto 0 );
    in_delay_reset : in STD_LOGIC;
    in_delay_data_ce : in STD_LOGIC_VECTOR ( 0 to 0 );
    in_delay_data_inc : in STD_LOGIC_VECTOR ( 0 to 0 );
    in_delay_tap_in : in STD_LOGIC_VECTOR ( 4 downto 0 );
    in_delay_tap_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    bitslip : in STD_LOGIC_VECTOR ( 0 to 0 );
    clk_in : in STD_LOGIC;
    clk_div_in : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ADC_SERDES : entity is true;
  attribute DEV_W : integer;
  attribute DEV_W of ADC_SERDES : entity is 6;
  attribute SYS_W : integer;
  attribute SYS_W of ADC_SERDES : entity is 1;
end ADC_SERDES;

architecture STRUCTURE of ADC_SERDES is
  attribute DEV_W of inst : label is 6;
  attribute SYS_W of inst : label is 1;
  attribute num_serial_bits : integer;
  attribute num_serial_bits of inst : label is 6;
begin
inst: entity work.ADC_SERDES_ADC_SERDES_selectio_wiz
     port map (
      bitslip(0) => bitslip(0),
      clk_div_in => clk_div_in,
      clk_in => clk_in,
      data_in_from_pins_n(0) => data_in_from_pins_n(0),
      data_in_from_pins_p(0) => data_in_from_pins_p(0),
      data_in_to_device(5 downto 0) => data_in_to_device(5 downto 0),
      in_delay_data_ce(0) => in_delay_data_ce(0),
      in_delay_data_inc(0) => in_delay_data_inc(0),
      in_delay_reset => in_delay_reset,
      in_delay_tap_in(4 downto 0) => in_delay_tap_in(4 downto 0),
      in_delay_tap_out(4 downto 0) => in_delay_tap_out(4 downto 0),
      io_reset => io_reset
    );
end STRUCTURE;
