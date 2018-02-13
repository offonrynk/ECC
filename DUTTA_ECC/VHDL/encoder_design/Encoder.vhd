----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nkrumah Offonry
-- 
-- Create Date:    11:30:39 06/30/2017 
-- Design Name: 
-- Module Name:   Encoder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This module is the Encoder block that takes takes a 64 bit data word as
--		input, encodes it and outputs a 64 bit data word and an additional 
--		8 check(parity) bits.
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.MATH_REAL.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Encoder is
    Port ( data_in_enc : in  STD_LOGIC_VECTOR(63 downto 0);
           checkbits_out : out STD_LOGIC_VECTOR(7 downto 0);
	       data_out_enc : out STD_LOGIC_VECTOR(63 downto 0));
end Encoder; 

architecture Behavioral of Encoder is

signal enc_checkbits: STD_LOGIC_VECTOR(7 downto 0);
signal enc_in : STD_LOGIC_VECTOR(63 downto 0);

BEGIN
				enc_in <= data_in_enc;
				

--checkbit generator
enc_checkbits(0) <= xor(enc_in and "0101111011100111001010010110000101100010011001000110100001110000");
enc_checkbits(1) <= xor(enc_in and "0110101101101111000101001011000000110001001100100011010000111000");
enc_checkbits(2) <= xor(enc_in and "1110110011111101110010100101100010011000000110010001101000011100");
enc_checkbits(3) <= xor(enc_in and "1001011000111101101001010010110001001100100011000000110100001110");
enc_checkbits(4) <= xor(enc_in and "1111011001011001100100101001011000100110010001101000011000000111");
enc_checkbits(5) <= xor(enc_in and "0110101010111010110010010000101100010011001000110100001110000011");
enc_checkbits(6) <= xor(enc_in and "1011100110000010101001001000010110001001100100011010000111000001");
enc_checkbits(7) <= xor(enc_in and "1001010111010110010100100100001011000100110010001101000011100000");
	 
checkbits_out <= enc_checkbits;
data_out_enc<= enc_in;

END Behavioral;