----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:44:22 10/24/2023 
-- Design Name: 
-- Module Name:    CRC_FSM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
-------------------------------------------port declaration-----------------------------------------
entity TX  is
port(
		rst,enable,clk_in    :in   std_logic;
		tx_out				:out  std_logic;
		Data          		:in  std_logic_vector (3 downto 0));
end TX  ;
------------------------------------------------------------------------------------------------------

architecture Behavioral of TX  is 
----------------------------------------encoding------------------------------------------------------
   type state_type is (st0,st1,st2,st3,st4,st5,st6); 
   signal state, next_state : state_type; 
	signal parity            :std_logic;
	signal clk 					:std_logic;
	signal r 					:integer;	
------------------------------------------------------------------------------------------------------
begin
parity <= data(0) xor data(1) xor data(2) xor data(3);
---------------------------------------sequential part------------------------------------------------
process(clk)
begin
      if rising_edge(clk) then
         if (rst = '1') then
            state <= st0;
    
         else
            state <= next_state;
         end if;        
      end if;
end process;
-------------------------------------------------------------------------------------------------------

-----------------------------------------combinational part--------------------------------------------
process(state,enable,parity,Data)
begin
	 case (state) is
         when st0 =>
            if enable = '1' then
               next_state <= st1;
					tx_out <= '0';
				else 
					next_state <= st0;
					tx_out <= '1';
            end if;
         when st1 =>
               next_state <= st2;
					tx_out <= data(0);
   
         when st2 =>
               next_state <= st3;
				   tx_out <= data(1);
         when st3 =>
               next_state <= st4;
				   tx_out <= data(2);
         when st4 =>
               next_state <= st5;
				   tx_out <= data(3);
         when st5 =>
               next_state <= st6;
				   tx_out <= parity;	
         when st6 =>
               next_state <= st0;
				   tx_out <= '1';					
         when others =>
            next_state <= st0;
      end case;      
end process;
-------------------------------------------------------------------------------------------------------
----------------------------------------clock divider--------------------------------------------------
process(clk_in)
begin
if rising_edge (clk_in) then 
if (r = 10000000) then
clk <= not clk;
r <= 0;
else
r <= r + 1 ;
end if ;
end if;
end process;
-------------------------------------------------------------------------------------------------------

end Behavioral;

