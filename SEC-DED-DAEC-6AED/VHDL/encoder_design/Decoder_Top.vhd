----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nkrumah Offonry
-- 
-- Create Date:    10:39:31 09/14/2017 
-- Design Name: 
-- Module Name:    Decoder_Top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Top module for decoder block for a SEC-DED-DAEC-TAEC code
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

entity Decoder_Top is
    Port ( decin : in  STD_LOGIC_VECTOR (73 downto 0);
	   error_type : out STD_LOGIC_VECTOR(2 downto 0);
           decout : out  STD_LOGIC_VECTOR (73 downto 0));
end Decoder_Top;

architecture Behavioral of Decoder_Top is

component Decoder
		Port(   data_in_dec : in  STD_LOGIC_VECTOR (73 downto 0);
			error_type : STD_LOGIC_VECTOR(2 downto 0);
          		data_out_dec : out  STD_LOGIC_VECTOR (73 downto 0));
end component;
begin
	Decode_inst : Decoder
	port map( error_type => error_type,
 	 	  data_in_dec => decin,
		  data_out_dec => decout
		);
		
end Behavioral;

