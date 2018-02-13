----------------------------------------------------------------------------------
-- Company: Microelectronic Systems Design Research Group
-- Engineer: Nkrumah Offonry
-- Create Date:    10:39:31 07/27/2017 
-- Module Name:    Decode_Top - Behavioral 
-- Target Devices: Kintex-7 FPGA Family, Zynq Ultrascale & Ultrascale+
-- Description: Top File for Decoder Module
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

entity Decoder_Top is
    Port ( decin : in STD_LOGIC_VECTOR(63 downto 0);
	   parin : in STD_LOGIC_VECTOR(7 downto 0);
           decout : out STD_LOGIC_VECTOR (63 downto 0));
end Decoder_Top;

architecture Behavioral of Decoder_Top is

component Decoder
	    Port( data_in_dec : in  STD_LOGIC_VECTOR (63 downto 0);
             	  checkbits_in : in STD_LOGIC_VECTOR (7 downto 0);
                  data_out_dec : out  STD_LOGIC_VECTOR (63 downto 0));
end component;
begin
	Decoder_inst : Decoder
	port map( data_in_dec => decin,
		  checkbits_in => parin,
		  data_out_dec => decout
		);
    end Behavioral;

