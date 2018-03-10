----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nkrumah Offonry
-- 
-- Create Date:    11:52:56 09/14/2017 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Decoder module that takes as input 74 bit codeword that consists of data (64) and checkbits(10)
--		Calculates syndrome and corrects single or triple adjacent bit errors
--		Detects upto 6 adjacent bit errors and random double bit errors
--		Outputs 74 bit codeword.
-- Dependdecies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- 000: NO ERROR
-- 001: SINGLE BIT ERROR (correctable)
-- 100: ADJACENT TRIPLE BIT ERROR (correctable)
-- 111: UNCORRECTABLE ERROR (can be any adjacent bit error upto 6 adjacent bits, double bit error or multiple bit error)

entity Decoder is
	Port(   data_in_dec : in  STD_LOGIC_VECTOR (73 downto 0);
		error_type : out STD_LOGIC_VECTOR(2 downto 0);
	     	data_out_dec : out  STD_LOGIC_VECTOR (73 downto 0));
end Decoder;

architecture Behavioral of Decoder is

signal syndrome, dec_checkbits, checkbits_in : STD_LOGIC_VECTOR(9 downto 0);
signal dec_in : STD_LOGIC_VECTOR(73 downto 0);

BEGIN

--DECODER
				dec_in <= data_in_dec;   
				checkbits_in <= (data_in_dec(4) & data_in_dec(8) & data_in_dec(2) & data_in_dec(6) & data_in_dec(0) & data_in_dec(59) & data_in_dec(13) & data_in_dec(42) & data_in_dec(36) & data_in_dec(35));
-- Syndrome computation

syndrome <= checkbits_in xor dec_checkbits;



dec_checkbits(0) <= dec_in(1) xor dec_in(3) xor dec_in(25) xor dec_in(27) xor dec_in(29) xor dec_in(31) xor dec_in(33) xor dec_in(37) xor dec_in(39) xor dec_in(45)
		    xor dec_in(47) xor dec_in(49) xor dec_in(61) xor dec_in(63) xor dec_in(65) xor dec_in(66) xor dec_in(67) xor dec_in(68) xor dec_in(69) xor dec_in(70)
		    xor dec_in(71) xor dec_in(72) xor dec_in(73);

dec_checkbits(1) <= dec_in(5) xor dec_in(7) xor dec_in(9) xor dec_in(10) xor dec_in(12) xor dec_in(14) xor dec_in(16) xor dec_in(18) xor dec_in(20) xor dec_in(22)
		    xor dec_in(24) xor dec_in(25) xor dec_in(27) xor dec_in(29) xor dec_in(31) xor dec_in(33) xor dec_in(38) xor dec_in(41) xor dec_in(43) xor dec_in(50)
		    xor dec_in(51) xor dec_in(52) xor dec_in(53) xor dec_in(54);

dec_checkbits(2) <= dec_in(10) xor dec_in(12) xor dec_in(14) xor dec_in(21) xor dec_in(23) xor dec_in(40) xor dec_in(44) xor dec_in(46) xor dec_in(48) xor dec_in(51) xor dec_in(53)
		    xor dec_in(60) xor dec_in(61) xor dec_in(62) xor dec_in(63) xor dec_in(64) xor dec_in(65) xor dec_in(67) xor dec_in(69);

dec_checkbits(3) <= dec_in(1) xor dec_in(3) xor dec_in(5) xor dec_in(7) xor dec_in(9) xor dec_in(11) xor dec_in(15) xor dec_in(16) xor dec_in(17) xor dec_in(18) xor 
		    dec_in(19) xor dec_in(30) xor dec_in(32) xor dec_in(34) xor dec_in(45) xor dec_in(47) xor dec_in(49) xor dec_in(56) xor dec_in(58);

dec_checkbits(4) <= dec_in(15) xor dec_in(17) xor dec_in(19) xor dec_in(26) xor dec_in(28) xor dec_in(41) xor dec_in(43) xor dec_in(46) xor dec_in(48) xor dec_in(50) xor 
		    dec_in(52) xor dec_in(54) xor dec_in(55) xor dec_in(56) xor dec_in(57) xor dec_in(58) xor dec_in(60) xor dec_in(62) xor dec_in(64) xor dec_in(70) xor dec_in(71) xor
		    dec_in(72) xor dec_in(73);

dec_checkbits(5) <= dec_in(5) xor dec_in(10) xor dec_in(15) xor dec_in(20) xor dec_in(25) xor dec_in(30) xor dec_checkbits(0) xor dec_in(40) xor dec_in(45) xor 
		    dec_in(50) xor dec_in(55) xor dec_in(60) xor dec_in(65) xor dec_in(70);

dec_checkbits(6) <= dec_in(1) xor dec_in(11) xor dec_in(16) xor dec_in(21) xor dec_in(26) xor dec_in(31) xor dec_checkbits(1) xor dec_in(41) xor dec_in(46) xor dec_in(51) xor 
		    dec_in(56) xor dec_in(61) xor dec_in(66) xor dec_in(71);

dec_checkbits(7) <= dec_in(7)  xor dec_in(12) xor dec_in(17) xor dec_in(22) xor dec_in(27) xor dec_in(32) xor dec_in(37) xor dec_checkbits(2) xor dec_in(47) xor 
		    dec_in(52) xor dec_in(57) xor dec_in(62) xor dec_in(67) xor dec_in(72);

dec_checkbits(8) <= dec_in(3) xor dec_checkbits(3) xor dec_in(18) xor dec_in(23) xor dec_in(28) xor dec_in(33) xor dec_in(38) xor dec_in(43) xor dec_in(48) xor 
		    dec_in(53) xor dec_in(58) xor dec_in(63) xor dec_in(68) xor dec_in(73);

dec_checkbits(9) <= dec_in(9) xor dec_in(14) xor dec_in(19) xor dec_in(24) xor dec_in(29) xor dec_in(34) xor dec_in(39) xor dec_in(44) xor dec_in(49) xor dec_in(54) xor dec_checkbits(4) xor dec_in(64) xor dec_in(69);

--Error Detection and Correction 
Correction_Detection: process (dec_in, syndrome)
variable se: std_logic_vector(73 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000001"; -- single error correctable
variable tae: std_logic_vector(73 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000111"; -- triple adjacent error correctable

begin
		case syndrome is	
						when "0000000000" => data_out_dec <= dec_in ; error_type <= "000";	-- no error								 
								   
					--Single Bit Error
						when "0000100000" => data_out_dec <= dec_in xor se sll 0; error_type <= "001"; -- 0								
						when "0101101001" => data_out_dec <= dec_in xor se sll 1; error_type <= "001"; -- 1										
						when "0010000000" => data_out_dec <= dec_in xor se sll 2; error_type <= "001"; -- 2			
						when "0000101001" => data_out_dec <= dec_in xor se sll 3; error_type <= "001"; -- 3								
						when "1000000000" => data_out_dec <= dec_in xor se sll 4; error_type <= "001"; -- 4
						when "0101101010" => data_out_dec <= dec_in xor se sll 5; error_type <= "001"; -- 5
						when "0001000000" => data_out_dec <= dec_in xor se sll 6; error_type <= "001"; -- 6
						when "0111001010" => data_out_dec <= dec_in xor se sll 7; error_type <= "001"; -- 7
						when "0100000000" => data_out_dec <= dec_in xor se sll 8; error_type <= "001"; -- 8
						when "1101001010" => data_out_dec <= dec_in xor se sll 9; error_type <= "001"; -- 9

						when "0011100110" => data_out_dec <= dec_in xor se sll 10; error_type <= "001"; -- 10
						when "0101001000" => data_out_dec <= dec_in xor se sll 11; error_type <= "001"; -- 11
						when "0001000110" => data_out_dec <= dec_in xor se sll 12; error_type <= "001"; -- 12
						when "0000001000" => data_out_dec <= dec_in xor se sll 13; error_type <= "001"; -- 13
						when "1011000110" => data_out_dec <= dec_in xor se sll 14; error_type <= "001"; -- 14
						when "1100111000" => data_out_dec <= dec_in xor se sll 15; error_type <= "001"; -- 15						
						when "0100001010" => data_out_dec <= dec_in xor se sll 16; error_type <= "001"; -- 16
						when "1110011000" => data_out_dec <= dec_in xor se sll 17; error_type <= "001"; -- 17
						when "0001001010" => data_out_dec <= dec_in xor se sll 18; error_type <= "001"; -- 18
						when "0100011000" => data_out_dec <= dec_in xor se sll 19; error_type <= "001"; -- 19

						when "0001100010" => data_out_dec <= dec_in xor se sll 20; error_type <= "001"; -- 20
						when "0011000100" => data_out_dec <= dec_in xor se sll 21; error_type <= "001"; -- 21
						when "0011000010" => data_out_dec <= dec_in xor se sll 22; error_type <= "001"; -- 22
						when "0110000100" => data_out_dec <= dec_in xor se sll 23; error_type <= "001"; -- 23
						when "1001000010" => data_out_dec <= dec_in xor se sll 24; error_type <= "001"; -- 24
						when "0001000011" => data_out_dec <= dec_in xor se sll 25; error_type <= "001"; -- 25
						when "1001010000" => data_out_dec <= dec_in xor se sll 26; error_type <= "001"; -- 26
						when "0011100011" => data_out_dec <= dec_in xor se sll 27; error_type <= "001"; -- 27
						when "1100010000" => data_out_dec <= dec_in xor se sll 28; error_type <= "001"; -- 28
						when "1001100011" => data_out_dec <= dec_in xor se sll 29; error_type <= "001"; -- 29

						when "0100101000" => data_out_dec <= dec_in xor se sll 30; error_type <= "001"; -- 30
						when "0000100011" => data_out_dec <= dec_in xor se sll 31; error_type <= "001"; -- 31
						when "0110001000" => data_out_dec <= dec_in xor se sll 32; error_type <= "001"; -- 32						
						when "0101100011" => data_out_dec <= dec_in xor se sll 33; error_type <= "001"; -- 33
						when "1100001000" => data_out_dec <= dec_in xor se sll 34; error_type <= "001"; -- 34
						when "0000000001" => data_out_dec <= dec_in xor se sll 35; error_type <= "001"; -- 35
						when "0000000010" => data_out_dec <= dec_in xor se sll 36; error_type <= "001"; -- 36
						when "0010100001" => data_out_dec <= dec_in xor se sll 37; error_type <= "001"; -- 37
						when "0101000010" => data_out_dec <= dec_in xor se sll 38; error_type <= "001"; -- 38
						when "1000100001" => data_out_dec <= dec_in xor se sll 39; error_type <= "001"; -- 39

						when "0010100100" => data_out_dec <= dec_in xor se sll 40; error_type <= "001"; -- 40
						when "1000010010" => data_out_dec <= dec_in xor se sll 41; error_type <= "001"; -- 41
						when "0000000100" => data_out_dec <= dec_in xor se sll 42; error_type <= "001"; -- 42
						when "1101010010" => data_out_dec <= dec_in xor se sll 43; error_type <= "001"; -- 43
						when "1010000100" => data_out_dec <= dec_in xor se sll 44; error_type <= "001"; -- 44
						when "0100001001" => data_out_dec <= dec_in xor se sll 45; error_type <= "001"; -- 45
						when "1011010100" => data_out_dec <= dec_in xor se sll 46; error_type <= "001"; -- 46
						when "0110101001" => data_out_dec <= dec_in xor se sll 47; error_type <= "001"; -- 47
						when "1110010100" => data_out_dec <= dec_in xor se sll 48; error_type <= "001"; -- 48
						when "1100101001" => data_out_dec <= dec_in xor se sll 49; error_type <= "001"; -- 49

						when "1001110010" => data_out_dec <= dec_in xor se sll 50; error_type <= "001"; -- 50
						when "0010000110" => data_out_dec <= dec_in xor se sll 51; error_type <= "001"; -- 51
						when "1011010010" => data_out_dec <= dec_in xor se sll 52; error_type <= "001"; -- 52
						when "0111000110" => data_out_dec <= dec_in xor se sll 53; error_type <= "001"; -- 53
						when "0001010010" => data_out_dec <= dec_in xor se sll 54; error_type <= "001"; -- 54
						when "1000110000" => data_out_dec <= dec_in xor se sll 55; error_type <= "001"; -- 55
						when "1101011000" => data_out_dec <= dec_in xor se sll 56; error_type <= "001"; -- 56
						when "1010010000" => data_out_dec <= dec_in xor se sll 57; error_type <= "001"; -- 57
						when "1000011000" => data_out_dec <= dec_in xor se sll 58; error_type <= "001"; -- 58
						when "0000010000" => data_out_dec <= dec_in xor se sll 59; error_type <= "001"; -- 59

						when "1010110100" => data_out_dec <= dec_in xor se sll 60; error_type <= "001"; -- 60
						when "0011100101" => data_out_dec <= dec_in xor se sll 61; error_type <= "001"; -- 61
						when "1000010100" => data_out_dec <= dec_in xor se sll 62; error_type <= "001"; -- 62
						when "0110100101" => data_out_dec <= dec_in xor se sll 63; error_type <= "001"; -- 63		
						when "0010010100" => data_out_dec <= dec_in xor se sll 64; error_type <= "001"; -- 64	
						when "0010000101" => data_out_dec <= dec_in xor se sll 65; error_type <= "001"; -- 65	
						when "0001100001" => data_out_dec <= dec_in xor se sll 66; error_type <= "001"; -- 66	
						when "0000100101" => data_out_dec <= dec_in xor se sll 67; error_type <= "001"; -- 67
						when "0100100001" => data_out_dec <= dec_in xor se sll 68; error_type <= "001"; -- 68	
						when "1010100101" => data_out_dec <= dec_in xor se sll 69; error_type <= "001"; -- 69	

						when "1000010001" => data_out_dec <= dec_in xor se sll 70; error_type <= "001"; -- 70	
						when "1001110001" => data_out_dec <= dec_in xor se sll 71; error_type <= "001"; -- 71
						when "1010110001" => data_out_dec <= dec_in xor se sll 72; error_type <= "001"; -- 72
						when "1100110001" => data_out_dec <= dec_in xor se sll 73; error_type <= "001"; -- 73

				-- Triple Adjacent Error
						
						when "0111001001" => data_out_dec <= dec_in xor tae sll 00; error_type <= "100"; -- 0 & 1 & 2
						when "0111000000" => data_out_dec <= dec_in xor tae sll 01; error_type <= "100"; -- 1 & 2 & 3
						when "1010101001" => data_out_dec <= dec_in xor tae sll 02; error_type <= "100"; -- 2 & 3 & 4
						when "1101000011" => data_out_dec <= dec_in xor tae sll 03; error_type <= "100"; -- 3 & 4 & 5
						when "1100101010" => data_out_dec <= dec_in xor tae sll 04; error_type <= "100"; -- 4 & 5 & 6
						when "0011100000" => data_out_dec <= dec_in xor tae sll 05; error_type <= "100"; -- 5 & 6 & 7
						when "0010001010" => data_out_dec <= dec_in xor tae sll 06; error_type <= "100"; -- 6 & 7 & 8
						when "1110000000" => data_out_dec <= dec_in xor tae sll 07; error_type <= "100"; -- 7 & 8 & 9
						when "1010101100" => data_out_dec <= dec_in xor tae sll 08; error_type <= "100"; -- 8 & 9 & 10
						when "1011100100" => data_out_dec <= dec_in xor tae sll 09; error_type <= "100"; -- 9 & 10 & 11
						 
						when "0111101000" => data_out_dec <= dec_in xor tae sll 10; error_type <= "100"; -- 10 & 11 & 12
						when "0100000110" => data_out_dec <= dec_in xor tae sll 11; error_type <= "100"; -- 11 & 12 & 13
						when "1010001000" => data_out_dec <= dec_in xor tae sll 12; error_type <= "100"; -- 12 & 13 & 14
						when "0111110110" => data_out_dec <= dec_in xor tae sll 13; error_type <= "100"; -- 13 & 14 & 15
						when "0011110100" => data_out_dec <= dec_in xor tae sll 14; error_type <= "100"; -- 14 & 15 & 16
						when "0110101010" => data_out_dec <= dec_in xor tae sll 15; error_type <= "100"; -- 15 & 16 & 17
						when "1011011000" => data_out_dec <= dec_in xor tae sll 16; error_type <= "100"; -- 16 & 17 & 18
						when "1011001010" => data_out_dec <= dec_in xor tae sll 17; error_type <= "100"; -- 17 & 18 & 19
						when "0100110000" => data_out_dec <= dec_in xor tae sll 18; error_type <= "100"; -- 18 & 19 & 20
						when "0110111110" => data_out_dec <= dec_in xor tae sll 19; error_type <= "100"; -- 19 & 20 & 21
						
						when "0001100100" => data_out_dec <= dec_in xor tae sll 20; error_type <= "100"; -- 20 & 21 & 22
						when "0110000010" => data_out_dec <= dec_in xor tae sll 21; error_type <= "100"; -- 21 & 22 & 23
						when "1100000100" => data_out_dec <= dec_in xor tae sll 22; error_type <= "100"; -- 22 & 23 & 24
						when "1110000101" => data_out_dec <= dec_in xor tae sll 23; error_type <= "100"; -- 23 & 24 & 25
						when "0001010001" => data_out_dec <= dec_in xor tae sll 24; error_type <= "100"; -- 24 & 25 & 26
						when "1011110000" => data_out_dec <= dec_in xor tae sll 25; error_type <= "100"; -- 25 & 26 & 27
						when "0110100011" => data_out_dec <= dec_in xor tae sll 26; error_type <= "100"; -- 26 & 27 & 28
						when "0110010000" => data_out_dec <= dec_in xor tae sll 27; error_type <= "100"; -- 27 & 28 & 29
						when "0001011011" => data_out_dec <= dec_in xor tae sll 28; error_type <= "100"; -- 28 & 29 & 30
						when "1101101000" => data_out_dec <= dec_in xor tae sll 29; error_type <= "100"; -- 29 & 30 & 31
						
						when "0010000011" => data_out_dec <= dec_in xor tae sll 30; error_type <= "100"; -- 30 & 31 & 32
						when "0011001000" => data_out_dec <= dec_in xor tae sll 31; error_type <= "100"; -- 31 & 32 & 33
						when "1111100011" => data_out_dec <= dec_in xor tae sll 32; error_type <= "100"; -- 32 & 33 & 34
						when "1001101010" => data_out_dec <= dec_in xor tae sll 33; error_type <= "100"; -- 33 & 34 & 35
						when "1100001011" => data_out_dec <= dec_in xor tae sll 34; error_type <= "100"; -- 34 & 35 & 36
						when "0010100010" => data_out_dec <= dec_in xor tae sll 35; error_type <= "100"; -- 35 & 36 & 37
						when "0111100001" => data_out_dec <= dec_in xor tae sll 36; error_type <= "100"; -- 36 & 37 & 38
						when "1111000010" => data_out_dec <= dec_in xor tae sll 37; error_type <= "100"; -- 37 & 38 & 38
						when "1111000111" => data_out_dec <= dec_in xor tae sll 38; error_type <= "100"; -- 38 & 39 & 40
						when "0010010111" => data_out_dec <= dec_in xor tae sll 39; error_type <= "100"; -- 39 & 40 & 41
						
						when "1010110010" => data_out_dec <= dec_in xor tae sll 40; error_type <= "100"; -- 40 & 41 & 42
						when "0101000100" => data_out_dec <= dec_in xor tae sll 41; error_type <= "100"; -- 41 & 42 & 43
						when "0111010010" => data_out_dec <= dec_in xor tae sll 42; error_type <= "100"; -- 42 & 43 & 44
						when "0011011111" => data_out_dec <= dec_in xor tae sll 43; error_type <= "100"; -- 43 & 44 & 45
						when "0101011001" => data_out_dec <= dec_in xor tae sll 44; error_type <= "100"; -- 44 & 45 & 46
						when "1001110100" => data_out_dec <= dec_in xor tae sll 45; error_type <= "100"; -- 45 & 46 & 47
						when "0011101001" => data_out_dec <= dec_in xor tae sll 46; error_type <= "100"; -- 46 & 47 & 48
						when "0100010100" => data_out_dec <= dec_in xor tae sll 47; error_type <= "100"; -- 47 & 48 & 49
						when "1011001111" => data_out_dec <= dec_in xor tae sll 48; error_type <= "100"; -- 48 & 49 & 50
						when "0111011101" => data_out_dec <= dec_in xor tae sll 49; error_type <= "100"; -- 49 & 50 & 51
						
						when "0000100110" => data_out_dec <= dec_in xor tae sll 50; error_type <= "100"; -- 50 & 51 & 52
						when "1110010010" => data_out_dec <= dec_in xor tae sll 51; error_type <= "100"; -- 51 & 52 & 53
						when "1101000110" => data_out_dec <= dec_in xor tae sll 52; error_type <= "100"; -- 52 & 53 & 54
						when "1110100100" => data_out_dec <= dec_in xor tae sll 53; error_type <= "100"; -- 53 & 54 & 55
						when "0100111010" => data_out_dec <= dec_in xor tae sll 54; error_type <= "100"; -- 54 & 55 & 56
						when "1111111000" => data_out_dec <= dec_in xor tae sll 55; error_type <= "100"; -- 55 & 56 & 57						
						when "1111010000" => data_out_dec <= dec_in xor tae sll 56; error_type <= "100"; -- 56 & 57 & 58
						when "0010011000" => data_out_dec <= dec_in xor tae sll 57; error_type <= "100"; -- 57 & 58 & 59
						when "0010111100" => data_out_dec <= dec_in xor tae sll 58; error_type <= "100"; -- 58 & 59 & 60
						when "1001000001" => data_out_dec <= dec_in xor tae sll 59; error_type <= "100"; -- 59 & 60 & 61
						
						when "0001000101" => data_out_dec <= dec_in xor tae sll 60; error_type <= "100"; -- 60 & 61 & 62
						when "1101010100" => data_out_dec <= dec_in xor tae sll 61; error_type <= "100"; -- 61 & 62 & 63
						when "1100100101" => data_out_dec <= dec_in xor tae sll 62; error_type <= "100"; -- 62 & 63 & 64
						when "0110110100" => data_out_dec <= dec_in xor tae sll 63; error_type <= "100"; -- 63 & 64 & 65
						when "0001110000" => data_out_dec <= dec_in xor tae sll 64; error_type <= "100"; -- 64 & 65 & 66
						when "0011000001" => data_out_dec <= dec_in xor tae sll 65; error_type <= "100"; -- 65 & 66 & 67
						when "0101100101" => data_out_dec <= dec_in xor tae sll 66; error_type <= "100"; -- 66 & 67 & 68
						when "1110100001" => data_out_dec <= dec_in xor tae sll 67; error_type <= "100"; -- 67 & 68 & 69
						when "0110010101" => data_out_dec <= dec_in xor tae sll 68; error_type <= "100"; -- 68 & 69 & 70
						when "1011000101" => data_out_dec <= dec_in xor tae sll 69; error_type <= "100"; -- 69 & 70 & 71

						when "1011010001" => data_out_dec <= dec_in xor tae sll 70; error_type <= "100"; -- 70 & 71 & 72
						when "1111110001" => data_out_dec <= dec_in xor tae sll 70; error_type <= "100"; -- 71 & 72 & 73
 					
				--  Adjacent bit error(s) upto 6 bits, double bit error or multiple bit error detected	

						when others => data_out_dec <= dec_in; error_type <= "111"; 
						 
				end case;	
		
end process;

END Behavioral; 