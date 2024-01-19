--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : top_drc.vhf
-- /___/   /\     Timestamp : 10/30/2023 15:34:44
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\unwrapped\sch2hdl.exe -intstyle ise -family spartan3e -flat -suppress -vhdl top_drc.vhf -w G:/TX_RX_final/TX_RX/top.sch
--Design Name: top
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity top is
   port ( data_in  : in    std_logic_vector (3 downto 0); 
          enable   : in    std_logic; 
          rst      : in    std_logic; 
          XLXN_4   : in    std_logic; 
          data_out : out   std_logic_vector (5 downto 0));
end top;

architecture BEHAVIORAL of top is
   signal XLXN_2   : std_logic;
   component TX
      port ( rst    : in    std_logic; 
             enable : in    std_logic; 
             clk_in : in    std_logic; 
             Data   : in    std_logic_vector (3 downto 0); 
             tx_out : out   std_logic);
   end component;
   
   component Rx
      port ( rst      : in    std_logic; 
             clk_in   : in    std_logic; 
             tx_out   : in    std_logic; 
             Data_out : out   std_logic_vector (5 downto 0));
   end component;
   
begin
   XLXI_1 : TX
      port map (clk_in=>XLXN_4,
                Data(3 downto 0)=>data_in(3 downto 0),
                enable=>enable,
                rst=>rst,
                tx_out=>XLXN_2);
   
   XLXI_2 : Rx
      port map (clk_in=>XLXN_4,
                rst=>rst,
                tx_out=>XLXN_2,
                Data_out(5 downto 0)=>data_out(5 downto 0));
   
end BEHAVIORAL;


