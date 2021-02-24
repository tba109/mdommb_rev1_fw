-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Feb 22 13:22:51 2021
-- Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/atfie/IceCube/mDOMDevelopment/mdommb_rev1_fw/mDOM_mb_rev1.srcs/sources_1/ip/DIST_BUFFER_128_12/DIST_BUFFER_128_12_stub.vhdl
-- Design      : DIST_BUFFER_128_12
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7s100fgga676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DIST_BUFFER_128_12 is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 6 downto 0 );
    d : in STD_LOGIC_VECTOR ( 11 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 6 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    qdpo_clk : in STD_LOGIC;
    dpo : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );

end DIST_BUFFER_128_12;

architecture stub of DIST_BUFFER_128_12 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[6:0],d[11:0],dpra[6:0],clk,we,qdpo_clk,dpo[11:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_13,Vivado 2019.1";
begin
end;
