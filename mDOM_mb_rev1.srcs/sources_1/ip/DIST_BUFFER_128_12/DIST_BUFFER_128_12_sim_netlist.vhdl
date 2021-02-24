-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Feb 22 13:22:51 2021
-- Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/atfie/IceCube/mDOMDevelopment/mdommb_rev1_fw/mDOM_mb_rev1.srcs/sources_1/ip/DIST_BUFFER_128_12/DIST_BUFFER_128_12_sim_netlist.vhdl
-- Design      : DIST_BUFFER_128_12
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7s100fgga676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity DIST_BUFFER_128_12_sdpram is
  port (
    dpo : out STD_LOGIC_VECTOR ( 11 downto 0 );
    a : in STD_LOGIC_VECTOR ( 6 downto 0 );
    clk : in STD_LOGIC;
    d : in STD_LOGIC_VECTOR ( 11 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 6 downto 0 );
    qdpo_clk : in STD_LOGIC;
    we : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of DIST_BUFFER_128_12_sdpram : entity is "sdpram";
end DIST_BUFFER_128_12_sdpram;

architecture STRUCTURE of DIST_BUFFER_128_12_sdpram is
  signal a_reg : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal d_reg : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal \^dpo\ : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal qsdpo_int : STD_LOGIC_VECTOR ( 11 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of qsdpo_int : signal is "true";
  signal ram_reg_0_63_0_2_i_1_n_0 : STD_LOGIC;
  signal ram_reg_0_63_0_2_n_0 : STD_LOGIC;
  signal ram_reg_0_63_0_2_n_1 : STD_LOGIC;
  signal ram_reg_0_63_0_2_n_2 : STD_LOGIC;
  signal ram_reg_0_63_3_5_n_0 : STD_LOGIC;
  signal ram_reg_0_63_3_5_n_1 : STD_LOGIC;
  signal ram_reg_0_63_3_5_n_2 : STD_LOGIC;
  signal ram_reg_0_63_6_8_n_0 : STD_LOGIC;
  signal ram_reg_0_63_6_8_n_1 : STD_LOGIC;
  signal ram_reg_0_63_6_8_n_2 : STD_LOGIC;
  signal ram_reg_0_63_9_11_n_0 : STD_LOGIC;
  signal ram_reg_0_63_9_11_n_1 : STD_LOGIC;
  signal ram_reg_0_63_9_11_n_2 : STD_LOGIC;
  signal ram_reg_64_127_0_2_i_1_n_0 : STD_LOGIC;
  signal ram_reg_64_127_0_2_n_0 : STD_LOGIC;
  signal ram_reg_64_127_0_2_n_1 : STD_LOGIC;
  signal ram_reg_64_127_0_2_n_2 : STD_LOGIC;
  signal ram_reg_64_127_3_5_n_0 : STD_LOGIC;
  signal ram_reg_64_127_3_5_n_1 : STD_LOGIC;
  signal ram_reg_64_127_3_5_n_2 : STD_LOGIC;
  signal ram_reg_64_127_6_8_n_0 : STD_LOGIC;
  signal ram_reg_64_127_6_8_n_1 : STD_LOGIC;
  signal ram_reg_64_127_6_8_n_2 : STD_LOGIC;
  signal ram_reg_64_127_9_11_n_0 : STD_LOGIC;
  signal ram_reg_64_127_9_11_n_1 : STD_LOGIC;
  signal ram_reg_64_127_9_11_n_2 : STD_LOGIC;
  signal sdpra_reg : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal we_reg : STD_LOGIC;
  signal NLW_ram_reg_0_63_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_0_63_9_11_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_64_127_0_2_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_64_127_3_5_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_64_127_6_8_DOD_UNCONNECTED : STD_LOGIC;
  signal NLW_ram_reg_64_127_9_11_DOD_UNCONNECTED : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \dpo[0]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \dpo[10]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \dpo[11]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \dpo[1]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \dpo[2]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \dpo[3]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \dpo[4]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \dpo[5]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \dpo[6]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \dpo[7]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \dpo[8]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \dpo[9]_INST_0\ : label is "soft_lutpair4";
  attribute KEEP : string;
  attribute KEEP of \qsdpo_int_reg[0]\ : label is "yes";
  attribute equivalent_register_removal : string;
  attribute equivalent_register_removal of \qsdpo_int_reg[0]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[10]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[10]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[11]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[11]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[1]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[1]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[2]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[2]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[3]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[3]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[4]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[4]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[5]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[5]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[6]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[6]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[7]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[7]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[8]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[8]\ : label is "no";
  attribute KEEP of \qsdpo_int_reg[9]\ : label is "yes";
  attribute equivalent_register_removal of \qsdpo_int_reg[9]\ : label is "no";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of ram_reg_0_63_0_2 : label is "";
  attribute RTL_RAM_BITS : integer;
  attribute RTL_RAM_BITS of ram_reg_0_63_0_2 : label is 1536;
  attribute RTL_RAM_NAME : string;
  attribute RTL_RAM_NAME of ram_reg_0_63_0_2 : label is "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram";
  attribute ram_addr_begin : integer;
  attribute ram_addr_begin of ram_reg_0_63_0_2 : label is 0;
  attribute ram_addr_end : integer;
  attribute ram_addr_end of ram_reg_0_63_0_2 : label is 63;
  attribute ram_offset : integer;
  attribute ram_offset of ram_reg_0_63_0_2 : label is 0;
  attribute ram_slice_begin : integer;
  attribute ram_slice_begin of ram_reg_0_63_0_2 : label is 0;
  attribute ram_slice_end : integer;
  attribute ram_slice_end of ram_reg_0_63_0_2 : label is 2;
  attribute METHODOLOGY_DRC_VIOS of ram_reg_0_63_3_5 : label is "";
  attribute RTL_RAM_BITS of ram_reg_0_63_3_5 : label is 1536;
  attribute RTL_RAM_NAME of ram_reg_0_63_3_5 : label is "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram";
  attribute ram_addr_begin of ram_reg_0_63_3_5 : label is 0;
  attribute ram_addr_end of ram_reg_0_63_3_5 : label is 63;
  attribute ram_offset of ram_reg_0_63_3_5 : label is 0;
  attribute ram_slice_begin of ram_reg_0_63_3_5 : label is 3;
  attribute ram_slice_end of ram_reg_0_63_3_5 : label is 5;
  attribute METHODOLOGY_DRC_VIOS of ram_reg_0_63_6_8 : label is "";
  attribute RTL_RAM_BITS of ram_reg_0_63_6_8 : label is 1536;
  attribute RTL_RAM_NAME of ram_reg_0_63_6_8 : label is "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram";
  attribute ram_addr_begin of ram_reg_0_63_6_8 : label is 0;
  attribute ram_addr_end of ram_reg_0_63_6_8 : label is 63;
  attribute ram_offset of ram_reg_0_63_6_8 : label is 0;
  attribute ram_slice_begin of ram_reg_0_63_6_8 : label is 6;
  attribute ram_slice_end of ram_reg_0_63_6_8 : label is 8;
  attribute METHODOLOGY_DRC_VIOS of ram_reg_0_63_9_11 : label is "";
  attribute RTL_RAM_BITS of ram_reg_0_63_9_11 : label is 1536;
  attribute RTL_RAM_NAME of ram_reg_0_63_9_11 : label is "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram";
  attribute ram_addr_begin of ram_reg_0_63_9_11 : label is 0;
  attribute ram_addr_end of ram_reg_0_63_9_11 : label is 63;
  attribute ram_offset of ram_reg_0_63_9_11 : label is 0;
  attribute ram_slice_begin of ram_reg_0_63_9_11 : label is 9;
  attribute ram_slice_end of ram_reg_0_63_9_11 : label is 11;
  attribute METHODOLOGY_DRC_VIOS of ram_reg_64_127_0_2 : label is "";
  attribute RTL_RAM_BITS of ram_reg_64_127_0_2 : label is 1536;
  attribute RTL_RAM_NAME of ram_reg_64_127_0_2 : label is "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram";
  attribute ram_addr_begin of ram_reg_64_127_0_2 : label is 64;
  attribute ram_addr_end of ram_reg_64_127_0_2 : label is 127;
  attribute ram_offset of ram_reg_64_127_0_2 : label is 0;
  attribute ram_slice_begin of ram_reg_64_127_0_2 : label is 0;
  attribute ram_slice_end of ram_reg_64_127_0_2 : label is 2;
  attribute METHODOLOGY_DRC_VIOS of ram_reg_64_127_3_5 : label is "";
  attribute RTL_RAM_BITS of ram_reg_64_127_3_5 : label is 1536;
  attribute RTL_RAM_NAME of ram_reg_64_127_3_5 : label is "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram";
  attribute ram_addr_begin of ram_reg_64_127_3_5 : label is 64;
  attribute ram_addr_end of ram_reg_64_127_3_5 : label is 127;
  attribute ram_offset of ram_reg_64_127_3_5 : label is 0;
  attribute ram_slice_begin of ram_reg_64_127_3_5 : label is 3;
  attribute ram_slice_end of ram_reg_64_127_3_5 : label is 5;
  attribute METHODOLOGY_DRC_VIOS of ram_reg_64_127_6_8 : label is "";
  attribute RTL_RAM_BITS of ram_reg_64_127_6_8 : label is 1536;
  attribute RTL_RAM_NAME of ram_reg_64_127_6_8 : label is "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram";
  attribute ram_addr_begin of ram_reg_64_127_6_8 : label is 64;
  attribute ram_addr_end of ram_reg_64_127_6_8 : label is 127;
  attribute ram_offset of ram_reg_64_127_6_8 : label is 0;
  attribute ram_slice_begin of ram_reg_64_127_6_8 : label is 6;
  attribute ram_slice_end of ram_reg_64_127_6_8 : label is 8;
  attribute METHODOLOGY_DRC_VIOS of ram_reg_64_127_9_11 : label is "";
  attribute RTL_RAM_BITS of ram_reg_64_127_9_11 : label is 1536;
  attribute RTL_RAM_NAME of ram_reg_64_127_9_11 : label is "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram";
  attribute ram_addr_begin of ram_reg_64_127_9_11 : label is 64;
  attribute ram_addr_end of ram_reg_64_127_9_11 : label is 127;
  attribute ram_offset of ram_reg_64_127_9_11 : label is 0;
  attribute ram_slice_begin of ram_reg_64_127_9_11 : label is 9;
  attribute ram_slice_end of ram_reg_64_127_9_11 : label is 11;
begin
  dpo(11 downto 0) <= \^dpo\(11 downto 0);
\a_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(0),
      Q => a_reg(0),
      R => '0'
    );
\a_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(1),
      Q => a_reg(1),
      R => '0'
    );
\a_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(2),
      Q => a_reg(2),
      R => '0'
    );
\a_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(3),
      Q => a_reg(3),
      R => '0'
    );
\a_reg_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(4),
      Q => a_reg(4),
      R => '0'
    );
\a_reg_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(5),
      Q => a_reg(5),
      R => '0'
    );
\a_reg_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk,
      CE => '1',
      D => a(6),
      Q => a_reg(6),
      R => '0'
    );
\d_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(0),
      Q => d_reg(0),
      R => '0'
    );
\d_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(10),
      Q => d_reg(10),
      R => '0'
    );
\d_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(11),
      Q => d_reg(11),
      R => '0'
    );
\d_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(1),
      Q => d_reg(1),
      R => '0'
    );
\d_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(2),
      Q => d_reg(2),
      R => '0'
    );
\d_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(3),
      Q => d_reg(3),
      R => '0'
    );
\d_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(4),
      Q => d_reg(4),
      R => '0'
    );
\d_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(5),
      Q => d_reg(5),
      R => '0'
    );
\d_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(6),
      Q => d_reg(6),
      R => '0'
    );
\d_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(7),
      Q => d_reg(7),
      R => '0'
    );
\d_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(8),
      Q => d_reg(8),
      R => '0'
    );
\d_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => d(9),
      Q => d_reg(9),
      R => '0'
    );
\dpo[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_0_2_n_0,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_0_2_n_0,
      O => \^dpo\(0)
    );
\dpo[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_9_11_n_1,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_9_11_n_1,
      O => \^dpo\(10)
    );
\dpo[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_9_11_n_2,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_9_11_n_2,
      O => \^dpo\(11)
    );
\dpo[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_0_2_n_1,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_0_2_n_1,
      O => \^dpo\(1)
    );
\dpo[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_0_2_n_2,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_0_2_n_2,
      O => \^dpo\(2)
    );
\dpo[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_3_5_n_0,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_3_5_n_0,
      O => \^dpo\(3)
    );
\dpo[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_3_5_n_1,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_3_5_n_1,
      O => \^dpo\(4)
    );
\dpo[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_3_5_n_2,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_3_5_n_2,
      O => \^dpo\(5)
    );
\dpo[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_6_8_n_0,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_6_8_n_0,
      O => \^dpo\(6)
    );
\dpo[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_6_8_n_1,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_6_8_n_1,
      O => \^dpo\(7)
    );
\dpo[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_6_8_n_2,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_6_8_n_2,
      O => \^dpo\(8)
    );
\dpo[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ram_reg_64_127_9_11_n_0,
      I1 => sdpra_reg(6),
      I2 => ram_reg_0_63_9_11_n_0,
      O => \^dpo\(9)
    );
\qsdpo_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(0),
      Q => qsdpo_int(0),
      R => '0'
    );
\qsdpo_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(10),
      Q => qsdpo_int(10),
      R => '0'
    );
\qsdpo_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(11),
      Q => qsdpo_int(11),
      R => '0'
    );
\qsdpo_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(1),
      Q => qsdpo_int(1),
      R => '0'
    );
\qsdpo_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(2),
      Q => qsdpo_int(2),
      R => '0'
    );
\qsdpo_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(3),
      Q => qsdpo_int(3),
      R => '0'
    );
\qsdpo_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(4),
      Q => qsdpo_int(4),
      R => '0'
    );
\qsdpo_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(5),
      Q => qsdpo_int(5),
      R => '0'
    );
\qsdpo_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(6),
      Q => qsdpo_int(6),
      R => '0'
    );
\qsdpo_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(7),
      Q => qsdpo_int(7),
      R => '0'
    );
\qsdpo_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(8),
      Q => qsdpo_int(8),
      R => '0'
    );
\qsdpo_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => \^dpo\(9),
      Q => qsdpo_int(9),
      R => '0'
    );
ram_reg_0_63_0_2: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRB(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRC(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRD(5 downto 0) => a_reg(5 downto 0),
      DIA => d_reg(0),
      DIB => d_reg(1),
      DIC => d_reg(2),
      DID => '0',
      DOA => ram_reg_0_63_0_2_n_0,
      DOB => ram_reg_0_63_0_2_n_1,
      DOC => ram_reg_0_63_0_2_n_2,
      DOD => NLW_ram_reg_0_63_0_2_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_reg_0_63_0_2_i_1_n_0
    );
ram_reg_0_63_0_2_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => we_reg,
      I1 => a_reg(6),
      O => ram_reg_0_63_0_2_i_1_n_0
    );
ram_reg_0_63_3_5: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRB(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRC(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRD(5 downto 0) => a_reg(5 downto 0),
      DIA => d_reg(3),
      DIB => d_reg(4),
      DIC => d_reg(5),
      DID => '0',
      DOA => ram_reg_0_63_3_5_n_0,
      DOB => ram_reg_0_63_3_5_n_1,
      DOC => ram_reg_0_63_3_5_n_2,
      DOD => NLW_ram_reg_0_63_3_5_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_reg_0_63_0_2_i_1_n_0
    );
ram_reg_0_63_6_8: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRB(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRC(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRD(5 downto 0) => a_reg(5 downto 0),
      DIA => d_reg(6),
      DIB => d_reg(7),
      DIC => d_reg(8),
      DID => '0',
      DOA => ram_reg_0_63_6_8_n_0,
      DOB => ram_reg_0_63_6_8_n_1,
      DOC => ram_reg_0_63_6_8_n_2,
      DOD => NLW_ram_reg_0_63_6_8_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_reg_0_63_0_2_i_1_n_0
    );
ram_reg_0_63_9_11: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRB(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRC(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRD(5 downto 0) => a_reg(5 downto 0),
      DIA => d_reg(9),
      DIB => d_reg(10),
      DIC => d_reg(11),
      DID => '0',
      DOA => ram_reg_0_63_9_11_n_0,
      DOB => ram_reg_0_63_9_11_n_1,
      DOC => ram_reg_0_63_9_11_n_2,
      DOD => NLW_ram_reg_0_63_9_11_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_reg_0_63_0_2_i_1_n_0
    );
ram_reg_64_127_0_2: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRB(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRC(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRD(5 downto 0) => a_reg(5 downto 0),
      DIA => d_reg(0),
      DIB => d_reg(1),
      DIC => d_reg(2),
      DID => '0',
      DOA => ram_reg_64_127_0_2_n_0,
      DOB => ram_reg_64_127_0_2_n_1,
      DOC => ram_reg_64_127_0_2_n_2,
      DOD => NLW_ram_reg_64_127_0_2_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_reg_64_127_0_2_i_1_n_0
    );
ram_reg_64_127_0_2_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => we_reg,
      I1 => a_reg(6),
      O => ram_reg_64_127_0_2_i_1_n_0
    );
ram_reg_64_127_3_5: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRB(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRC(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRD(5 downto 0) => a_reg(5 downto 0),
      DIA => d_reg(3),
      DIB => d_reg(4),
      DIC => d_reg(5),
      DID => '0',
      DOA => ram_reg_64_127_3_5_n_0,
      DOB => ram_reg_64_127_3_5_n_1,
      DOC => ram_reg_64_127_3_5_n_2,
      DOD => NLW_ram_reg_64_127_3_5_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_reg_64_127_0_2_i_1_n_0
    );
ram_reg_64_127_6_8: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRB(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRC(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRD(5 downto 0) => a_reg(5 downto 0),
      DIA => d_reg(6),
      DIB => d_reg(7),
      DIC => d_reg(8),
      DID => '0',
      DOA => ram_reg_64_127_6_8_n_0,
      DOB => ram_reg_64_127_6_8_n_1,
      DOC => ram_reg_64_127_6_8_n_2,
      DOD => NLW_ram_reg_64_127_6_8_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_reg_64_127_0_2_i_1_n_0
    );
ram_reg_64_127_9_11: unisim.vcomponents.RAM64M
    generic map(
      INIT_A => X"0000000000000000",
      INIT_B => X"0000000000000000",
      INIT_C => X"0000000000000000",
      INIT_D => X"0000000000000000"
    )
        port map (
      ADDRA(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRB(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRC(5 downto 0) => sdpra_reg(5 downto 0),
      ADDRD(5 downto 0) => a_reg(5 downto 0),
      DIA => d_reg(9),
      DIB => d_reg(10),
      DIC => d_reg(11),
      DID => '0',
      DOA => ram_reg_64_127_9_11_n_0,
      DOB => ram_reg_64_127_9_11_n_1,
      DOC => ram_reg_64_127_9_11_n_2,
      DOD => NLW_ram_reg_64_127_9_11_DOD_UNCONNECTED,
      WCLK => clk,
      WE => ram_reg_64_127_0_2_i_1_n_0
    );
\sdpra_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => dpra(0),
      Q => sdpra_reg(0),
      R => '0'
    );
\sdpra_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => dpra(1),
      Q => sdpra_reg(1),
      R => '0'
    );
\sdpra_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => dpra(2),
      Q => sdpra_reg(2),
      R => '0'
    );
\sdpra_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => dpra(3),
      Q => sdpra_reg(3),
      R => '0'
    );
\sdpra_reg_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => dpra(4),
      Q => sdpra_reg(4),
      R => '0'
    );
\sdpra_reg_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => dpra(5),
      Q => sdpra_reg(5),
      R => '0'
    );
\sdpra_reg_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => qdpo_clk,
      CE => '1',
      D => dpra(6),
      Q => sdpra_reg(6),
      R => '0'
    );
we_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => we,
      Q => we_reg,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity DIST_BUFFER_128_12_dist_mem_gen_v8_0_13_synth is
  port (
    dpo : out STD_LOGIC_VECTOR ( 11 downto 0 );
    a : in STD_LOGIC_VECTOR ( 6 downto 0 );
    clk : in STD_LOGIC;
    d : in STD_LOGIC_VECTOR ( 11 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 6 downto 0 );
    qdpo_clk : in STD_LOGIC;
    we : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13_synth : entity is "dist_mem_gen_v8_0_13_synth";
end DIST_BUFFER_128_12_dist_mem_gen_v8_0_13_synth;

architecture STRUCTURE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13_synth is
begin
\gen_sdp_ram.sdpram_inst\: entity work.DIST_BUFFER_128_12_sdpram
     port map (
      a(6 downto 0) => a(6 downto 0),
      clk => clk,
      d(11 downto 0) => d(11 downto 0),
      dpo(11 downto 0) => dpo(11 downto 0),
      dpra(6 downto 0) => dpra(6 downto 0),
      qdpo_clk => qdpo_clk,
      we => we
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 is
  port (
    a : in STD_LOGIC_VECTOR ( 6 downto 0 );
    d : in STD_LOGIC_VECTOR ( 11 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 6 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    i_ce : in STD_LOGIC;
    qspo_ce : in STD_LOGIC;
    qdpo_ce : in STD_LOGIC;
    qdpo_clk : in STD_LOGIC;
    qspo_rst : in STD_LOGIC;
    qdpo_rst : in STD_LOGIC;
    qspo_srst : in STD_LOGIC;
    qdpo_srst : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 11 downto 0 );
    dpo : out STD_LOGIC_VECTOR ( 11 downto 0 );
    qspo : out STD_LOGIC_VECTOR ( 11 downto 0 );
    qdpo : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute C_ADDR_WIDTH : integer;
  attribute C_ADDR_WIDTH of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 7;
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is "0";
  attribute C_DEPTH : integer;
  attribute C_DEPTH of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 128;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is "./";
  attribute C_FAMILY : string;
  attribute C_FAMILY of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is "spartan7";
  attribute C_HAS_CLK : integer;
  attribute C_HAS_CLK of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_HAS_D : integer;
  attribute C_HAS_D of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_HAS_I_CE : integer;
  attribute C_HAS_I_CE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO : integer;
  attribute C_HAS_QSPO of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_CE : integer;
  attribute C_HAS_QSPO_CE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_RST : integer;
  attribute C_HAS_QSPO_RST of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_QSPO_SRST : integer;
  attribute C_HAS_QSPO_SRST of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_SPO : integer;
  attribute C_HAS_SPO of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_MEM_INIT_FILE : string;
  attribute C_MEM_INIT_FILE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is "no_coe_file_loaded";
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 4;
  attribute C_PARSER_TYPE : integer;
  attribute C_PARSER_TYPE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_PIPELINE_STAGES : integer;
  attribute C_PIPELINE_STAGES of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_QCE_JOINED : integer;
  attribute C_QCE_JOINED of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_QUALIFY_WE : integer;
  attribute C_QUALIFY_WE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_READ_MIF : integer;
  attribute C_READ_MIF of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 0;
  attribute C_REG_A_D_INPUTS : integer;
  attribute C_REG_A_D_INPUTS of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_SYNC_ENABLE : integer;
  attribute C_SYNC_ENABLE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 1;
  attribute C_WIDTH : integer;
  attribute C_WIDTH of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is 12;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 : entity is "dist_mem_gen_v8_0_13";
end DIST_BUFFER_128_12_dist_mem_gen_v8_0_13;

architecture STRUCTURE of DIST_BUFFER_128_12_dist_mem_gen_v8_0_13 is
  signal \<const0>\ : STD_LOGIC;
begin
  qdpo(11) <= \<const0>\;
  qdpo(10) <= \<const0>\;
  qdpo(9) <= \<const0>\;
  qdpo(8) <= \<const0>\;
  qdpo(7) <= \<const0>\;
  qdpo(6) <= \<const0>\;
  qdpo(5) <= \<const0>\;
  qdpo(4) <= \<const0>\;
  qdpo(3) <= \<const0>\;
  qdpo(2) <= \<const0>\;
  qdpo(1) <= \<const0>\;
  qdpo(0) <= \<const0>\;
  qspo(11) <= \<const0>\;
  qspo(10) <= \<const0>\;
  qspo(9) <= \<const0>\;
  qspo(8) <= \<const0>\;
  qspo(7) <= \<const0>\;
  qspo(6) <= \<const0>\;
  qspo(5) <= \<const0>\;
  qspo(4) <= \<const0>\;
  qspo(3) <= \<const0>\;
  qspo(2) <= \<const0>\;
  qspo(1) <= \<const0>\;
  qspo(0) <= \<const0>\;
  spo(11) <= \<const0>\;
  spo(10) <= \<const0>\;
  spo(9) <= \<const0>\;
  spo(8) <= \<const0>\;
  spo(7) <= \<const0>\;
  spo(6) <= \<const0>\;
  spo(5) <= \<const0>\;
  spo(4) <= \<const0>\;
  spo(3) <= \<const0>\;
  spo(2) <= \<const0>\;
  spo(1) <= \<const0>\;
  spo(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\synth_options.dist_mem_inst\: entity work.DIST_BUFFER_128_12_dist_mem_gen_v8_0_13_synth
     port map (
      a(6 downto 0) => a(6 downto 0),
      clk => clk,
      d(11 downto 0) => d(11 downto 0),
      dpo(11 downto 0) => dpo(11 downto 0),
      dpra(6 downto 0) => dpra(6 downto 0),
      qdpo_clk => qdpo_clk,
      we => we
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity DIST_BUFFER_128_12 is
  port (
    a : in STD_LOGIC_VECTOR ( 6 downto 0 );
    d : in STD_LOGIC_VECTOR ( 11 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 6 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    qdpo_clk : in STD_LOGIC;
    dpo : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of DIST_BUFFER_128_12 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of DIST_BUFFER_128_12 : entity is "DIST_BUFFER_128_12,dist_mem_gen_v8_0_13,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of DIST_BUFFER_128_12 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of DIST_BUFFER_128_12 : entity is "dist_mem_gen_v8_0_13,Vivado 2019.1";
end DIST_BUFFER_128_12;

architecture STRUCTURE of DIST_BUFFER_128_12 is
  signal NLW_U0_qdpo_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_U0_qspo_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_U0_spo_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "spartan7";
  attribute C_HAS_CLK : integer;
  attribute C_HAS_CLK of U0 : label is 1;
  attribute C_HAS_D : integer;
  attribute C_HAS_D of U0 : label is 1;
  attribute C_HAS_DPO : integer;
  attribute C_HAS_DPO of U0 : label is 1;
  attribute C_HAS_DPRA : integer;
  attribute C_HAS_DPRA of U0 : label is 1;
  attribute C_HAS_QDPO : integer;
  attribute C_HAS_QDPO of U0 : label is 0;
  attribute C_HAS_QDPO_CE : integer;
  attribute C_HAS_QDPO_CE of U0 : label is 0;
  attribute C_HAS_QDPO_CLK : integer;
  attribute C_HAS_QDPO_CLK of U0 : label is 1;
  attribute C_HAS_QDPO_RST : integer;
  attribute C_HAS_QDPO_RST of U0 : label is 0;
  attribute C_HAS_QDPO_SRST : integer;
  attribute C_HAS_QDPO_SRST of U0 : label is 0;
  attribute C_HAS_QSPO : integer;
  attribute C_HAS_QSPO of U0 : label is 0;
  attribute C_HAS_QSPO_RST : integer;
  attribute C_HAS_QSPO_RST of U0 : label is 0;
  attribute C_HAS_QSPO_SRST : integer;
  attribute C_HAS_QSPO_SRST of U0 : label is 0;
  attribute C_HAS_SPO : integer;
  attribute C_HAS_SPO of U0 : label is 0;
  attribute C_HAS_WE : integer;
  attribute C_HAS_WE of U0 : label is 1;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 4;
  attribute C_REG_DPRA_INPUT : integer;
  attribute C_REG_DPRA_INPUT of U0 : label is 1;
  attribute c_addr_width : integer;
  attribute c_addr_width of U0 : label is 7;
  attribute c_default_data : string;
  attribute c_default_data of U0 : label is "0";
  attribute c_depth : integer;
  attribute c_depth of U0 : label is 128;
  attribute c_elaboration_dir : string;
  attribute c_elaboration_dir of U0 : label is "./";
  attribute c_has_i_ce : integer;
  attribute c_has_i_ce of U0 : label is 0;
  attribute c_has_qspo_ce : integer;
  attribute c_has_qspo_ce of U0 : label is 0;
  attribute c_mem_init_file : string;
  attribute c_mem_init_file of U0 : label is "no_coe_file_loaded";
  attribute c_parser_type : integer;
  attribute c_parser_type of U0 : label is 1;
  attribute c_pipeline_stages : integer;
  attribute c_pipeline_stages of U0 : label is 0;
  attribute c_qce_joined : integer;
  attribute c_qce_joined of U0 : label is 0;
  attribute c_qualify_we : integer;
  attribute c_qualify_we of U0 : label is 0;
  attribute c_read_mif : integer;
  attribute c_read_mif of U0 : label is 0;
  attribute c_reg_a_d_inputs : integer;
  attribute c_reg_a_d_inputs of U0 : label is 1;
  attribute c_sync_enable : integer;
  attribute c_sync_enable of U0 : label is 1;
  attribute c_width : integer;
  attribute c_width of U0 : label is 12;
begin
U0: entity work.DIST_BUFFER_128_12_dist_mem_gen_v8_0_13
     port map (
      a(6 downto 0) => a(6 downto 0),
      clk => clk,
      d(11 downto 0) => d(11 downto 0),
      dpo(11 downto 0) => dpo(11 downto 0),
      dpra(6 downto 0) => dpra(6 downto 0),
      i_ce => '1',
      qdpo(11 downto 0) => NLW_U0_qdpo_UNCONNECTED(11 downto 0),
      qdpo_ce => '1',
      qdpo_clk => qdpo_clk,
      qdpo_rst => '0',
      qdpo_srst => '0',
      qspo(11 downto 0) => NLW_U0_qspo_UNCONNECTED(11 downto 0),
      qspo_ce => '1',
      qspo_rst => '0',
      qspo_srst => '0',
      spo(11 downto 0) => NLW_U0_spo_UNCONNECTED(11 downto 0),
      we => we
    );
end STRUCTURE;
