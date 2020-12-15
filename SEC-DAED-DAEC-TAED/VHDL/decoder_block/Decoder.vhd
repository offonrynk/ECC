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
-- Description: Decoder module that takes as input 64 bit data and 8 checkbits
--		Calculates syndrome and corrects single or double adjacent bit errors
--		Detects triple adjacent bit errors and random double bit errors
--		Outputs 64 bit data.
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

-- 00: NO ERROR
-- 01: SINGLE BIT ERROR 
-- 10: ADJACENT  DOUBLE BIT ERROR (correctable)
-- 11: UNCORRECTABLE ERROR (can be a triple adjacent bit error, double bit error or multiple bit error)

entity Decoder is
	Port(   data_in_dec : in  STD_LOGIC_VECTOR (63 downto 0);
		    checkbits_in :in STD_LOGIC_VECTOR(7 downto 0);
		    error_type : out STD_LOGIC_VECTOR(1 downto 0);
	     	data_out_dec : out  STD_LOGIC_VECTOR (63 downto 0));
end Decoder;

architecture Behavioral of Decoder is

signal syndrome, dec_checkbits, chk_reg : STD_LOGIC_VECTOR(7 downto 0);
signal dec_in, intermediate : STD_LOGIC_VECTOR(71 downto 0);     
BEGIN

--DECODER
				  
				dec_in(71 downto 0) <= data_in_dec(63 downto 49) & checkbits_in(7) & data_in_dec(48) & checkbits_in(5) & data_in_dec(47 downto 39) & checkbits_in(2) & data_in_dec(38 downto 33) & checkbits_in(1) & 
						               data_in_dec(32 downto 12) & checkbits_in(0) & data_in_dec(11 downto 8) & checkbits_in(4) &  data_in_dec(7 downto 5)  & checkbits_in(3) & data_in_dec(4) & checkbits_in(6) & data_in_dec(3 downto 0); 


					chk_reg<= checkbits_in;
-- Syndrome computation

syndrome <= chk_reg xor dec_checkbits;


dec_checkbits(0) <= dec_in(0) xor dec_in(2) xor dec_in(3) xor dec_in(5) xor dec_in(7) xor dec_in(17) xor dec_in(19) xor dec_in(22) xor dec_in(28) xor dec_in(33)
		    xor dec_in(35) xor dec_in(39) xor dec_in(41) xor dec_in(45) xor dec_in(46) xor dec_in(47) xor dec_in(48) xor dec_in(50) xor dec_in(51) xor dec_in(52)
		    xor dec_in(53) xor dec_in(55) xor dec_in(60) xor dec_in(61) xor dec_in(62) xor dec_in(64) xor dec_in(66) xor dec_in(67) xor dec_in(68);

dec_checkbits(1) <= dec_in(1) xor dec_in(7) xor dec_in(12) xor dec_in(13) xor dec_in(14) xor dec_in(21) xor dec_in(23) xor dec_in(27) xor dec_in(29) xor dec_in(30)
		    xor dec_in(32) xor dec_in(34) xor dec_in(40) xor dec_in(45) xor dec_in(47) xor dec_in(51) xor dec_in(52) xor dec_in(53) xor dec_in(57) xor dec_in(59)
		    xor dec_in(61) xor dec_in(63) xor dec_in(65) xor dec_in(66) xor dec_in(68) xor dec_in(69) xor dec_in(70) xor dec_in(71);

dec_checkbits(2) <= dec_in(0) xor dec_in(2) xor dec_in(7) xor dec_in(9) xor dec_in(11) xor dec_in(12) xor dec_in(14) xor dec_in(24) xor dec_in(25) xor dec_in(26) xor 
		    dec_in(31) xor dec_in(33) xor dec_in(34) xor dec_in(35) xor dec_in(40) xor dec_in(42) xor dec_in(46) xor dec_in(49) xor dec_in(55) xor dec_in(57) xor 
		    dec_in(58) xor dec_in(59) xor dec_in(60) xor dec_in(62) xor dec_in(67) xor dec_in(69) xor dec_in(71);

dec_checkbits(3) <= dec_in(8) xor dec_in(12) xor dec_in(13) xor dec_in(14) xor dec_in(16) xor dec_in(22) xor dec_in(24) xor dec_in(26) xor dec_in(30) xor dec_in(31) xor 
		    dec_in(32) xor dec_in(34) xor dec_in(36) xor dec_in(38) xor dec_in(39) xor dec_in(41) xor dec_in(43) xor dec_in(48) xor dec_in(50) xor dec_in(51) xor 
		    dec_in(53) xor dec_in(58) xor dec_in(60) xor dec_in(62) xor dec_in(63) xor dec_in(64) xor dec_in(65) xor dec_in(67) xor dec_in(70);

dec_checkbits(4) <= dec_in(1) xor dec_in(3) xor dec_in(5) xor dec_in(9) xor dec_in(11) xor dec_in(13) xor dec_in(18) xor dec_in(19) xor dec_in(20) xor dec_in(27) xor 
		    dec_in(29) xor dec_in(33) xor dec_in(35) xor dec_in(36) xor dec_in(38) xor dec_in(39) xor dec_in(41) xor dec_in(43) xor dec_in(46) xor dec_in(49) xor
		    dec_in(52) xor dec_in(57) xor dec_in(58) xor dec_in(59) xor dec_in(63) xor dec_in(64) xor dec_in(65) xor dec_in(66) xor dec_in(68);

dec_checkbits(5) <= dec_in(0) xor dec_in(3) xor dec_checkbits(3) xor dec_in(9) xor dec_in(12) xor dec_checkbits(0) xor dec_in(18) xor dec_in(21) xor dec_in(24) xor dec_in(27) xor dec_in(30) xor 
		    dec_in(33) xor dec_in(36) xor dec_in(39) xor dec_in(42) xor dec_in(45) xor dec_in(48) xor dec_in(51) xor dec_in(57) xor dec_in(60) xor 
		    dec_in(63) xor dec_in(66) xor dec_in(69);

dec_checkbits(6) <= dec_in(1) xor dec_in(7) xor dec_checkbits(4) xor dec_in(13) xor dec_in(16) xor dec_in(19) xor dec_in(22) xor dec_in(25) xor 
		    dec_in(28) xor dec_in(31) xor dec_in(34) xor dec_checkbits(1) xor dec_in(40) xor dec_in(43) xor dec_in(46) xor dec_in(49) xor dec_in(52) xor dec_in(55) xor dec_in(58) xor 
		    dec_in(61) xor dec_in(64) xor dec_in(67) xor dec_in(70);

dec_checkbits(7) <= dec_in(2) xor dec_in(5) xor dec_in(8) xor dec_in(11) xor dec_in(14) xor dec_in(17) xor dec_in(20) xor dec_in(23) xor dec_in(26) xor dec_in(29) xor 
		    dec_in(32) xor dec_in(35) xor dec_in(38) xor dec_in(41) xor dec_checkbits(2) xor dec_in(47) xor dec_in(50) xor dec_in(53) xor dec_in(59) xor 
		    dec_in(62) xor dec_in(65) xor dec_in(68) xor dec_in(71);


--Error Detection and Correction 
Correction_Detection: process (dec_in, syndrome)
variable d: std_logic_vector(71 downto 0) := X"000000000000000001";
variable e: std_logic_vector(71 downto 0) := X"000000000000000003";

begin
		case syndrome is	
						when "00000000"	=> intermediate <= dec_in ; error_type <= "00";	-- no error								 
								   
					--Single Bit Error
						when "10000101" => intermediate <= dec_in xor d sll 0; error_type <= "01"; -- 0								
						when "01010010" => intermediate <= dec_in xor d sll 1; error_type <= "01"; -- 1										
						when "00100101" => intermediate <= dec_in xor d sll 2; error_type <= "01"; -- 2			
						when "01010001" => intermediate <= dec_in xor d sll 3; error_type <= "01"; -- 3								
						when "01000000" => intermediate <= dec_in xor d sll 4; error_type <= "01"; -- 4
						when "11110001" => intermediate <= dec_in xor d sll 5; error_type <= "01"; -- 5
						when "00001000" => intermediate <= dec_in xor d sll 6; error_type <= "01"; -- 6
						when "10100111" => intermediate <= dec_in xor d sll 7; error_type <= "01"; -- 7
						when "10101000" => intermediate <= dec_in xor d sll 8; error_type <= "01"; -- 8
						when "11110100" => intermediate <= dec_in xor d sll 9; error_type <= "01"; -- 9

						when "00010000" => intermediate <= dec_in xor d sll 10; error_type <= "01"; -- 10
						when "01010100" => intermediate <= dec_in xor d sll 11; error_type <= "01"; -- 11
						when "11001110" => intermediate <= dec_in xor d sll 12; error_type <= "01"; -- 12
						when "01111010" => intermediate <= dec_in xor d sll 13; error_type <= "01"; -- 13
						when "01101110" => intermediate <= dec_in xor d sll 14; error_type <= "01"; -- 14
						when "00000001" => intermediate <= dec_in xor d sll 15; error_type <= "01"; -- 15						
						when "01101000" => intermediate <= dec_in xor d sll 16; error_type <= "01"; -- 16
						when "10100001" => intermediate <= dec_in xor d sll 17; error_type <= "01"; -- 17
						when "01110000" => intermediate <= dec_in xor d sll 18; error_type <= "01"; -- 18
						when "00110001" => intermediate <= dec_in xor d sll 19; error_type <= "01"; -- 19

						when "11010000" => intermediate <= dec_in xor d sll 20; error_type <= "01"; -- 20
						when "01100010" => intermediate <= dec_in xor d sll 21; error_type <= "01"; -- 21
						when "01001001" => intermediate <= dec_in xor d sll 22; error_type <= "01"; -- 22
						when "11000010" => intermediate <= dec_in xor d sll 23; error_type <= "01"; -- 23
						when "10001100" => intermediate <= dec_in xor d sll 24; error_type <= "01"; -- 24
						when "11000100" => intermediate <= dec_in xor d sll 25; error_type <= "01"; -- 25
						when "00101100" => intermediate <= dec_in xor d sll 26; error_type <= "01"; -- 26
						when "00110010" => intermediate <= dec_in xor d sll 27; error_type <= "01"; -- 27
						when "01100001" => intermediate <= dec_in xor d sll 28; error_type <= "01"; -- 28
						when "10010010" => intermediate <= dec_in xor d sll 29; error_type <= "01"; -- 29

						when "01001010" => intermediate <= dec_in xor d sll 30; error_type <= "01"; -- 30
						when "11101100" => intermediate <= dec_in xor d sll 31; error_type <= "01"; -- 31
						when "11101010" => intermediate <= dec_in xor d sll 32; error_type <= "01"; -- 32						
						when "11010101" => intermediate <= dec_in xor d sll 33; error_type <= "01"; -- 33
						when "10101110" => intermediate <= dec_in xor d sll 34; error_type <= "01"; -- 34
						when "01110101" => intermediate <= dec_in xor d sll 35; error_type <= "01"; -- 35
						when "01011000" => intermediate <= dec_in xor d sll 36; error_type <= "01"; -- 36
						when "00000010" => intermediate <= dec_in xor d sll 37; error_type <= "01"; -- 37
						when "11111000" => intermediate <= dec_in xor d sll 38; error_type <= "01"; -- 38
						when "01111001" => intermediate <= dec_in xor d sll 39; error_type <= "01"; -- 39

						when "10000110" => intermediate <= dec_in xor d sll 40; error_type <= "01"; -- 40
						when "11011001" => intermediate <= dec_in xor d sll 41; error_type <= "01"; -- 41
						when "10100100" => intermediate <= dec_in xor d sll 42; error_type <= "01"; -- 42
						when "00111000" => intermediate <= dec_in xor d sll 43; error_type <= "01"; -- 43
						when "00000100" => intermediate <= dec_in xor d sll 44; error_type <= "01"; -- 44
						when "01000011" => intermediate <= dec_in xor d sll 45; error_type <= "01"; -- 45
						when "10110101" => intermediate <= dec_in xor d sll 46; error_type <= "01"; -- 46
						when "11100011" => intermediate <= dec_in xor d sll 47; error_type <= "01"; -- 47
						when "00101001" => intermediate <= dec_in xor d sll 48; error_type <= "01"; -- 48
						when "10010100" => intermediate <= dec_in xor d sll 49; error_type <= "01"; -- 49

						when "10001001" => intermediate <= dec_in xor d sll 50; error_type <= "01"; -- 50
						when "01101011" => intermediate <= dec_in xor d sll 51; error_type <= "01"; -- 51
						when "01110011" => intermediate <= dec_in xor d sll 52; error_type <= "01"; -- 52
						when "11001011" => intermediate <= dec_in xor d sll 53; error_type <= "01"; -- 53
						when "00100000" => intermediate <= dec_in xor d sll 54; error_type <= "01"; -- 54
						when "11100101" => intermediate <= dec_in xor d sll 55; error_type <= "01"; -- 55
						when "10000000" => intermediate <= dec_in xor d sll 56; error_type <= "01"; -- 56
						when "10110110" => intermediate <= dec_in xor d sll 57; error_type <= "01"; -- 57
						when "10111100" => intermediate <= dec_in xor d sll 58; error_type <= "01"; -- 58
						when "00010110" => intermediate <= dec_in xor d sll 59; error_type <= "01"; -- 59

						when "10101101" => intermediate <= dec_in xor d sll 60; error_type <= "01"; -- 60
						when "00100011" => intermediate <= dec_in xor d sll 61; error_type <= "01"; -- 61
						when "00001101" => intermediate <= dec_in xor d sll 62; error_type <= "01"; -- 62
						when "00011010" => intermediate <= dec_in xor d sll 63; error_type <= "01"; -- 63		
						when "00011001" => intermediate <= dec_in xor d sll 64; error_type <= "01"; -- 64	
						when "10111010" => intermediate <= dec_in xor d sll 65; error_type <= "01"; -- 65	
						when "00010011" => intermediate <= dec_in xor d sll 66; error_type <= "01"; -- 66	
						when "11001101" => intermediate <= dec_in xor d sll 67; error_type <= "01"; -- 67
						when "10110011" => intermediate <= dec_in xor d sll 68; error_type <= "01"; -- 68	
						when "11100110" => intermediate <= dec_in xor d sll 69; error_type <= "01"; -- 69	

						when "00101010" => intermediate <= dec_in xor d sll 70; error_type <= "01"; -- 70	
						when "01000110" => intermediate <= dec_in xor d sll 71; error_type <= "01"; -- 71
				
				-- Double Adjacent Error
						when "11010111" => intermediate <= dec_in xor e sll 00; error_type <= "10"; -- 0 & 1
						when "01110111" => intermediate <= dec_in xor e sll 01; error_type <= "10"; -- 1 & 2
						when "01110100" => intermediate <= dec_in xor e sll 02; error_type <= "10"; -- 2 & 3
						when "00010001" => intermediate <= dec_in xor e sll 03; error_type <= "10"; -- 3 & 4
						when "10110001" => intermediate <= dec_in xor e sll 04; error_type <= "10"; -- 4 & 5
						when "11111001" => intermediate <= dec_in xor e sll 05; error_type <= "10"; -- 5 & 6
						when "10101111" => intermediate <= dec_in xor e sll 06; error_type <= "10"; -- 6 & 7
						when "00001111" => intermediate <= dec_in xor e sll 07; error_type <= "10"; -- 7 & 8
						when "01011100" => intermediate <= dec_in xor e sll 08; error_type <= "10"; -- 8 & 9
						when "11100100" => intermediate <= dec_in xor e sll 09; error_type <= "10"; -- 9 & 10
						
						when "01000100" => intermediate <= dec_in xor e sll 10; error_type <= "10"; -- 10 & 11
						when "10011010" => intermediate <= dec_in xor e sll 11; error_type <= "10"; -- 11 & 12
						when "10110100" => intermediate <= dec_in xor e sll 12; error_type <= "10"; -- 12 & 13
						when "00010100" => intermediate <= dec_in xor e sll 13; error_type <= "10"; -- 13 & 14
						when "01101111" => intermediate <= dec_in xor e sll 14; error_type <= "10"; -- 14 & 15
						when "01101001" => intermediate <= dec_in xor e sll 15; error_type <= "10"; -- 15 & 16
						when "11001001" => intermediate <= dec_in xor e sll 16; error_type <= "10"; -- 16 & 17
						when "11010001" => intermediate <= dec_in xor e sll 17; error_type <= "10"; -- 17 & 18
						when "01000001" => intermediate <= dec_in xor e sll 18; error_type <= "10"; -- 18 & 19
						when "11100001" => intermediate <= dec_in xor e sll 19; error_type <= "10"; -- 19 & 20
						
						when "10110010" => intermediate <= dec_in xor e sll 20; error_type <= "10"; -- 20 & 21
						when "00101011" => intermediate <= dec_in xor e sll 21; error_type <= "10"; -- 21 & 22
						when "10001011" => intermediate <= dec_in xor e sll 22; error_type <= "10"; -- 22 & 23
						when "01001110" => intermediate <= dec_in xor e sll 23; error_type <= "10"; -- 23 & 24
						when "01001000" => intermediate <= dec_in xor e sll 24; error_type <= "10"; -- 24 & 25
						when "11101000" => intermediate <= dec_in xor e sll 25; error_type <= "10"; -- 25 & 26
						when "00011110" => intermediate <= dec_in xor e sll 26; error_type <= "10"; -- 26 & 27
						when "01010011" => intermediate <= dec_in xor e sll 27; error_type <= "10"; -- 27 & 28
						when "11110011" => intermediate <= dec_in xor e sll 28; error_type <= "10"; -- 28 & 29
						when "11011000" => intermediate <= dec_in xor e sll 29; error_type <= "10"; -- 29 & 30
						
						when "10100110" => intermediate <= dec_in xor e sll 30; error_type <= "10"; -- 30 & 31
						when "00000110" => intermediate <= dec_in xor e sll 31; error_type <= "10"; -- 31 & 32
						when "00111111" => intermediate <= dec_in xor e sll 32; error_type <= "10"; -- 32 & 33
						when "01111011" => intermediate <= dec_in xor e sll 33; error_type <= "10"; -- 33 & 34
						when "11011011" => intermediate <= dec_in xor e sll 34; error_type <= "10"; -- 34 & 35
						when "00101101" => intermediate <= dec_in xor e sll 35; error_type <= "10"; -- 35 & 36
						when "01011010" => intermediate <= dec_in xor e sll 36; error_type <= "10"; -- 36 & 37
						when "11111010" => intermediate <= dec_in xor e sll 37; error_type <= "10"; -- 37 & 38
						when "10000001" => intermediate <= dec_in xor e sll 38; error_type <= "10"; -- 38 & 39
						when "11111111" => intermediate <= dec_in xor e sll 39; error_type <= "10"; -- 39 & 40
						
						when "01011111" => intermediate <= dec_in xor e sll 40; error_type <= "10"; -- 40 & 41
						when "01111101" => intermediate <= dec_in xor e sll 41; error_type <= "10"; -- 41 & 42
						when "10011100" => intermediate <= dec_in xor e sll 42; error_type <= "10"; -- 42 & 43
						when "00111100" => intermediate <= dec_in xor e sll 43; error_type <= "10"; -- 43 & 44
						when "01000111" => intermediate <= dec_in xor e sll 44; error_type <= "10"; -- 44 & 45
						when "11110110" => intermediate <= dec_in xor e sll 45; error_type <= "10"; -- 45 & 46
						when "01010110" => intermediate <= dec_in xor e sll 46; error_type <= "10"; -- 46 & 47
						when "11001010" => intermediate <= dec_in xor e sll 47; error_type <= "10"; -- 47 & 48
						when "10111101" => intermediate <= dec_in xor e sll 48; error_type <= "10"; -- 48 & 49
						when "00011101" => intermediate <= dec_in xor e sll 49; error_type <= "10"; -- 49 & 50
						
						when "11100010" => intermediate <= dec_in xor e sll 50; error_type <= "10"; -- 50 & 51
						when "00011000" => intermediate <= dec_in xor e sll 51; error_type <= "10"; -- 51 & 52
						when "10111000" => intermediate <= dec_in xor e sll 52; error_type <= "10"; -- 52 & 53
						when "11101011" => intermediate <= dec_in xor e sll 53; error_type <= "10"; -- 53 & 54
						when "11000101" => intermediate <= dec_in xor e sll 54; error_type <= "10"; -- 54 & 55
						when "01100101" => intermediate <= dec_in xor e sll 55; error_type <= "10"; -- 55 & 56						
						when "00110110" => intermediate <= dec_in xor e sll 56; error_type <= "10"; -- 56 & 57
						when "00001010" => intermediate <= dec_in xor e sll 57; error_type <= "10"; -- 57 & 58
						when "10101010" => intermediate <= dec_in xor e sll 58; error_type <= "10"; -- 58 & 59
						when "10111011" => intermediate <= dec_in xor e sll 59; error_type <= "10"; -- 59 & 60
						
						when "10001110" => intermediate <= dec_in xor e sll 60; error_type <= "10"; -- 60 & 61
						when "00101110" => intermediate <= dec_in xor e sll 61; error_type <= "10"; -- 61 & 62
						when "00010111" => intermediate <= dec_in xor e sll 62; error_type <= "10"; -- 62 & 63
						when "00000011" => intermediate <= dec_in xor e sll 63; error_type <= "10"; -- 63 & 64
						when "10100011" => intermediate <= dec_in xor e sll 64; error_type <= "10"; -- 64 & 65
						when "10101001" => intermediate <= dec_in xor e sll 65; error_type <= "10"; -- 65 & 66
						when "11011110" => intermediate <= dec_in xor e sll 66; error_type <= "10"; -- 66 & 67
						when "01111110" => intermediate <= dec_in xor e sll 67; error_type <= "10"; -- 67 & 68
						when "01010101" => intermediate <= dec_in xor e sll 68; error_type <= "10"; -- 68 & 69
						when "11001100" => intermediate <= dec_in xor e sll 69; error_type <= "10"; -- 69 & 70
						when "01101100" => intermediate <= dec_in xor e sll 70; error_type <= "10"; -- 70 & 71
							
					-- Triple adj. bit error, double bit error or multiple bit error detected					
						when  others 	=> intermediate <= dec_in;  error_type <= "11";
								 
				end case;	
		
end process;

data_out_dec <= (intermediate(71 downto 57) & intermediate(55) & intermediate(53 downto 45) & intermediate(43 downto 38) & intermediate(36 downto 16) & intermediate(14 downto 11) & intermediate(9 downto 7) & intermediate (5) & intermediate(3 downto 0));

END Behavioral; 