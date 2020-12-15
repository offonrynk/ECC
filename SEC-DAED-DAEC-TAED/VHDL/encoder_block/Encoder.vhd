----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nkrumah Offonry
-- 
-- Create Date:    11:30:39 08/30/2017 
-- Design Name: 
-- Module Name:   Encoder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This module is the Encoder block that takes takes a 64 bit data word as
--		input, encodes it and outputs a 72 bit codeword that consists of 64 data bits and 8 check bits
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
signal enc_in: STD_LOGIC_VECTOR(63 downto 0);
signal intermediate: STD_LOGIC_VECTOR(71 downto 0); -- represents the intermediate codeword. That is, data and checkbits.

BEGIN
--Encoding Process
 			enc_in <= data_in_enc;
			--intermediate(71 downto 0) <= enc_in(63 downto 49) & enc_checkbits(7) & enc_in(48) & enc_checkbits(5) & enc_in(47 downto 39) & enc_checkbits(2) & enc_in(38 downto 33) & enc_checkbits(1) & 
				--		     enc_in(32 downto 12) & enc_checkbits(0) & enc_in(11 downto 8) & enc_checkbits(4) &  enc_in(7 downto 5)  & enc_checkbits(3) & enc_in(4) & enc_checkbits(6) & enc_in(3 downto 0); 

--checkbit generation
-- the first 5 checkbits represent the top portion of the G matrix and represent just data bits
-- the last 3 [enc_checkbits(7 downto 5)] checkbits represent the bottom portion of the G matrix and represent both data and checkbits.


enc_checkbits(0) <= enc_in(0) xor enc_in(2) xor enc_in(3) xor enc_in(4) xor enc_in(5) xor enc_in(13) xor enc_in(15) xor enc_in(18) xor enc_in(24) xor enc_in(29)
		    xor enc_in(31) xor enc_in(34) xor enc_in(36) xor enc_in(39) xor enc_in(40) xor enc_in(41) xor enc_in(42) xor enc_in(44) xor enc_in(45) xor enc_in(46)
		    xor enc_in(47) xor enc_in(48) xor enc_in(52) xor enc_in(53) xor enc_in(54) xor enc_in(56) xor enc_in(58) xor enc_in(59) xor enc_in(60);

enc_checkbits(1) <= enc_in(1) xor enc_in(5) xor enc_in(9) xor enc_in(10) xor enc_in(11) xor enc_in(17) xor enc_in(19) xor enc_in(23) xor enc_in(25) xor enc_in(26)
		    xor enc_in(28) xor enc_in(30) xor enc_in(35) xor enc_in(39) xor enc_in(41) xor enc_in(45) xor enc_in(46) xor enc_in(47) xor enc_in(49) xor enc_in(51)
		    xor enc_in(53) xor enc_in(55) xor enc_in(57) xor enc_in(58) xor enc_in(60) xor enc_in(61) xor enc_in(62) xor enc_in(63);

enc_checkbits(2) <= enc_in(0) xor enc_in(2) xor enc_in(5) xor enc_in(7) xor enc_in(8) xor enc_in(9) xor enc_in(11) xor enc_in(20) xor enc_in(21) xor enc_in(22) xor 
		    enc_in(27) xor enc_in(29) xor enc_in(30) xor enc_in(31) xor enc_in(35) xor enc_in(37) xor enc_in(40) xor enc_in(43) xor enc_in(48) xor enc_in(49) xor 
		    enc_in(50) xor enc_in(51) xor enc_in(52) xor enc_in(54) xor enc_in(59) xor enc_in(61) xor enc_in(63);

enc_checkbits(3) <= enc_in(6) xor enc_in(9) xor enc_in(10) xor enc_in(11) xor enc_in(12) xor enc_in(18) xor enc_in(20) xor enc_in(22) xor enc_in(26) xor enc_in(27) xor 
		    enc_in(28) xor enc_in(30) xor enc_in(32) xor enc_in(33) xor enc_in(34) xor enc_in(36) xor enc_in(38) xor enc_in(42) xor enc_in(44) xor enc_in(45) xor 
		    enc_in(47) xor enc_in(50) xor enc_in(52) xor enc_in(54) xor enc_in(55) xor enc_in(56) xor enc_in(57) xor enc_in(59) xor enc_in(62);

enc_checkbits(4) <= enc_in(1) xor enc_in(3) xor enc_in(4) xor enc_in(7) xor enc_in(8) xor enc_in(10) xor enc_in(14) xor enc_in(15) xor enc_in(16) xor enc_in(23) xor 
		    enc_in(25) xor enc_in(29) xor enc_in(31) xor enc_in(32) xor enc_in(33) xor enc_in(34) xor enc_in(36) xor enc_in(38) xor enc_in(40) xor enc_in(41) xor
		    enc_in(46) xor enc_in(49) xor enc_in(50) xor enc_in(51) xor enc_in(55) xor enc_in(56) xor enc_in(57) xor enc_in(58) xor enc_in(60);

enc_checkbits(5) <= enc_in(0) xor enc_in(3) xor enc_checkbits(3) xor enc_in(7) xor enc_in(9) xor enc_checkbits(0) xor enc_in(14) xor enc_in(17) xor enc_in(20) xor enc_in(23) xor enc_in(26) xor 
		    enc_in(29) xor enc_in(32) xor enc_in(34) xor enc_in(37) xor enc_in(39) xor enc_in(42) xor enc_in(45) xor enc_in(49) xor enc_in(52) xor 
		    enc_in(55) xor enc_in(58) xor enc_in(61);

enc_checkbits(6) <= enc_in(1) xor enc_in(5) xor enc_checkbits(4) xor enc_in(10) xor enc_in(12) xor enc_in(15) xor enc_in(18) xor enc_in(21) xor enc_in(24) xor 
		    enc_in(27) xor enc_in(30) xor enc_checkbits(1) xor enc_in(35) xor enc_in(38) xor enc_in(40) xor enc_in(43) xor enc_in(46) xor enc_in(48) xor enc_in(50) xor 
		    enc_in(53) xor enc_in(56) xor enc_in(59) xor enc_in(62);

enc_checkbits(7) <= enc_in(2) xor enc_in(4) xor enc_in(6) xor enc_in(8) xor enc_in(11) xor enc_in(13) xor enc_in(16) xor enc_in(19) xor enc_in(22) xor enc_in(25) xor 
		    enc_in(28) xor enc_in(31) xor enc_in(33) xor enc_in(36) xor enc_checkbits(2) xor enc_in(41) xor enc_in(44) xor enc_in(47) xor enc_in(51) xor 
		    enc_in(54) xor enc_in(57) xor enc_in(60) xor enc_in(63);


		   data_out_enc <= enc_in;              -- data out is the  actual data 
		   checkbits_out <= enc_checkbits;           -- checkbits out is the checkbit generated with corresponding algorithm
	  
END Behavioral;