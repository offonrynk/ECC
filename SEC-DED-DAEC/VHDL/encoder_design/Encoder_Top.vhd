----------------------------------------------------------------------------------
-- Company:  Microelectronic Systems Design Research Group
-- Engineer: Nkrumah Offonry
-- 
-- Create Date:    11:26:34 07/26/2017 
-- Module Name:    Encoder_Top - Behavioral 
-- Project Name: 
-- Target Devices: Kintex-7 FPGA Family, Zynq Ultrascale & Ultrascale+
-- Tool versions: 
-- Description: Top File for Dutta Encoder Module
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

entity Encoder_Top is
    Port ( encin : in  STD_LOGIC_VECTOR(63 downto 0);
           parout  : out STD_LOGIC_VECTOR (7 downto 0);
           encout : out  STD_LOGIC_VECTOR(63 downto 0));
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
		  checkbits_out => parout,
		  data_out_enc => encout        
		);
end Behavioral;
