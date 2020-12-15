-- Copyright (C) 2017 Microelectronic Systems Design Research Group
-- _____ _   _       _  ___
--   |_   _| | | |     | |/ / |
--   | | | | | |_____| ' /| |
--   | | | |_| |_____| . \| |___
--   |_|  \___/      |_|\_\_____|
--
-- Microelectronic Systems Design Research Group
-- Department of Electrical Engineering
-- University of Kaiserslautern
-- Germany
--
-- @file  Encoder_Top.vhd
-- @brief  
-- @author Nkrumah offonry
-- @date   28/11/17

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;


entity Encoder_Top is
Port (     encin : in  STD_LOGIC_VECTOR (63 downto 0);
           chk_out_top : out STD_LOGIC_VECTOR(7 downto 0);
           encout : out  STD_LOGIC_VECTOR (63 downto 0)
           );
end Encoder_Top;

architecture Behavioral of Encoder_Top is

component Encoder
		Port (  data_in_enc : in  STD_LOGIC_VECTOR(63 downto 0);
           		checkbits_out : out STD_LOGIC_VECTOR(7 downto 0);
            	data_out_enc : out STD_LOGIC_VECTOR(63 downto 0));
end component;
begin
 Encoder_inst : Encoder
	port map( data_in_enc => encin,
 	 	checkbits_out => chk_out_top,
		data_out_enc => encout
		);
		
end Behavioral;