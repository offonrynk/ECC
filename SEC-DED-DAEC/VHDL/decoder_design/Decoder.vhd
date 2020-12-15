----------------------------------------------------------------------------------
-- Company: Microelectronic Systems Design Research Group
-- Engineer: Nkrumah Offonry
-- Create Date:    11:52:56 07/03/2017 
-- Module Name:    Decoder - Behavioral 
-- Project Name: 
-- Target Devices: Kintex-7 FPGA Family, Zynq Ultrascale & Ultrascale+
-- Tool versions: 
-- Description: Decoder module that takes as input 64 data bits and 8 check bits 
--		Calculates syndrome and corrects single and/or double adjacent bit errors
--		Outputs 64 bit data word
--
-- Additional Comments: Decoder module is combinational
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

entity Decoder is
	Port(  data_in_dec : in  STD_LOGIC_VECTOR (63 downto 0);
               checkbits_in : in STD_LOGIC_VECTOR (7 downto 0);
               error_type : out STD_LOGIC_VECTOR(1 downto 0);
               data_out_dec : out  STD_LOGIC_VECTOR (63 downto 0));
end Decoder;

architecture Behavioral of Decoder is
signal parin, syndrome, dec_checkbits : STD_LOGIC_VECTOR(7 downto 0);
signal dec_in : STD_LOGIC_VECTOR(63 downto 0);


BEGIN

--DECODER
dec_in <= data_in_dec;
parin <= checkbits_in;

-- syndrome computation
syndrome <= dec_checkbits xor parin;

dec_checkbits(0) <= xor(dec_in and "0101111011100111001010010110000101100010011001000110100001110000");
dec_checkbits(1) <= xor(dec_in and "0110101101101111000101001011000000110001001100100011010000111000");
dec_checkbits(2) <= xor(dec_in and "1110110011111101110010100101100010011000000110010001101000011100");
dec_checkbits(3) <= xor(dec_in and "1001011000111101101001010010110001001100100011000000110100001110");
dec_checkbits(4) <= xor(dec_in and "1111011001011001100100101001011000100110010001101000011000000111");
dec_checkbits(5) <= xor(dec_in and "0110101010111010110010010000101100010011001000110100001110000011");
dec_checkbits(6) <= xor(dec_in and "1011100110000010101001001000010110001001100100011010000111000001");
dec_checkbits(7) <= xor(dec_in and "1001010111010110010100100100001011000100110010001101000011100000");

--Error Detection and Correction 
Correction_Detection: process (dec_in, syndrome)
variable d: std_logic_vector(63 downto 0) := X"0000000000000001";
variable e: std_logic_vector(63 downto 0) := X"0000000000000003";

begin
		case syndrome is	
						when "00000000"	=> data_out_dec <= dec_in;-- no error
							
					--Single Bit Error
						when "01110000" => data_out_dec <= (dec_in xor (d sll 0));   -- 0
						when "00111000" => data_out_dec <= (dec_in xor (d sll 1));   -- 1			
						when "00011100" => data_out_dec <= (dec_in xor (d sll 2));   -- 2			
						when "00001110" => data_out_dec <= (dec_in xor (d sll 3));   -- 3								
						when "00000111" => data_out_dec <= (dec_in xor (d sll 4));   -- 4
						when "10000011" => data_out_dec <= (dec_in xor (d sll 5));   -- 5
						when "11000001" => data_out_dec <= (dec_in xor (d sll 6));   -- 6
						when "11100000" => data_out_dec <= (dec_in xor (d sll 7));   -- 7
						when "01101000" => data_out_dec <= (dec_in xor (d sll 8));   -- 8
						when "00110100" => data_out_dec <= (dec_in xor (d sll 9));   -- 9

						when "00011010" => data_out_dec <= (dec_in xor (d sll 10));   -- 10
						when "00001101" => data_out_dec <= (dec_in xor (d sll 11));   -- 11
						when "10000110" => data_out_dec <= (dec_in xor (d sll 12));   -- 12
						when "01000011" => data_out_dec <= (dec_in xor (d sll 13));   -- 13
						when "10100001" => data_out_dec <= (dec_in xor (d sll 14));   -- 14
						when "11010000" => data_out_dec <= (dec_in xor (d sll 15));   -- 15
						when "01100100" => data_out_dec <= (dec_in xor (d sll 16));   -- 16
						when "00110010" => data_out_dec <= (dec_in xor (d sll 17));   -- 17
						when "00011001" => data_out_dec <= (dec_in xor (d sll 18));   -- 18
						when "10001100" => data_out_dec <= (dec_in xor (d sll 19));   -- 19

						when "01000110" => data_out_dec <= (dec_in xor (d sll 20));   -- 20
						when "00100011" => data_out_dec <= (dec_in xor (d sll 21));   -- 21
						when "10010001" => data_out_dec <= (dec_in xor (d sll 22));   -- 22
						when "11001000" => data_out_dec <= (dec_in xor (d sll 23));   -- 23
						when "01100010" => data_out_dec <= (dec_in xor (d sll 24));   -- 24
						when "00110001" => data_out_dec <= (dec_in xor (d sll 25));   -- 25
						when "10011000" => data_out_dec <= (dec_in xor (d sll 26));   -- 26
						when "01001100" => data_out_dec <= (dec_in xor (d sll 27));   -- 27
						when "00100110" => data_out_dec <= (dec_in xor (d sll 28));   -- 28
						when "00010011" => data_out_dec <= (dec_in xor (d sll 29));   -- 29

						when "10001001" => data_out_dec <= (dec_in xor (d sll 30));   -- 30
						when "11000100" => data_out_dec <= (dec_in xor (d sll 31));   -- 31
						when "01100001" => data_out_dec <= (dec_in xor (d sll 32));   -- 32
						when "10110000" => data_out_dec <= (dec_in xor (d sll 33));   -- 33						
						when "01011000" => data_out_dec <= (dec_in xor (d sll 34));   -- 34
						when "00101100" => data_out_dec <= (dec_in xor (d sll 35));   -- 35
						when "00010110" => data_out_dec <= (dec_in xor (d sll 36));   -- 36
						when "00001011" => data_out_dec <= (dec_in xor (d sll 37));   -- 37
						when "10000101" => data_out_dec <= (dec_in xor (d sll 38));   -- 38
						when "01010010" => data_out_dec <= (dec_in xor (d sll 39));   -- 39

						when "00101001" => data_out_dec <= (dec_in xor (d sll 40));   -- 40
						when "10010100" => data_out_dec <= (dec_in xor (d sll 41));   -- 41
						when "01001010" => data_out_dec <= (dec_in xor (d sll 42));   -- 42
						when "00100101" => data_out_dec <= (dec_in xor (d sll 43));   -- 43
						when "10010010" => data_out_dec <= (dec_in xor (d sll 44));   -- 44
						when "01001001" => data_out_dec <= (dec_in xor (d sll 45));   -- 45
						when "10100100" => data_out_dec <= (dec_in xor (d sll 46));   -- 46
						when "01111100" => data_out_dec <= (dec_in xor (d sll 47));   -- 47
						when "00011111" => data_out_dec <= (dec_in xor (d sll 48));   -- 48
						when "11100011" => data_out_dec <= (dec_in xor (d sll 49));   -- 49

						when "10001111" => data_out_dec <= (dec_in xor (d sll 50));   -- 50
						when "00111110" => data_out_dec <= (dec_in xor (d sll 51));   -- 51
						when "10111100" => data_out_dec <= (dec_in xor (d sll 52));   -- 52
						when "00101111" => data_out_dec <= (dec_in xor (d sll 53));   -- 53
						when "10010111" => data_out_dec <= (dec_in xor (d sll 54));   -- 54
						when "11100101" => data_out_dec <= (dec_in xor (d sll 55));   -- 55
						when "11000010" => data_out_dec <= (dec_in xor (d sll 56));   -- 56
						when "00111011" => data_out_dec <= (dec_in xor (d sll 57));   -- 57
						when "10011101" => data_out_dec <= (dec_in xor (d sll 58));   -- 58
						when "01100111" => data_out_dec <= (dec_in xor (d sll 59));   -- 59

						when "11011001" => data_out_dec <= (dec_in xor (d sll 60));   -- 60
						when "01110110" => data_out_dec <= (dec_in xor (d sll 61));   -- 61
						when "00110111" => data_out_dec <= (dec_in xor (d sll 62));   -- 62
						when "11011100" => data_out_dec <= (dec_in xor (d sll 63));   -- 63	
										
				-- Double Adjacent Error
						when "01001000" => data_out_dec <= (dec_in xor (e sll 00));   -- 0 & 1
						when "00100100" => data_out_dec <= (dec_in xor (e sll 01));   -- 1 & 2
						when "00010010" => data_out_dec <= (dec_in xor (e sll 02));   -- 2 & 3
						when "00001001" => data_out_dec <= (dec_in xor (e sll 03));   -- 3 & 4
						when "10000100" => data_out_dec <= (dec_in xor (e sll 04));   -- 4 & 5
						when "01000010" => data_out_dec <= (dec_in xor (e sll 05));   -- 5 & 6
						when "00100001" => data_out_dec <= (dec_in xor (e sll 06));   -- 6 & 7
						when "10001000" => data_out_dec <= (dec_in xor (e sll 07));   -- 7 & 8
						when "01011100" => data_out_dec <= (dec_in xor (e sll 08));   -- 8 & 9
						when "00101110" => data_out_dec <= (dec_in xor (e sll 09));   -- 9 & 10
						
						when "00010111" => data_out_dec <= (dec_in xor (e sll 10));   -- 10 & 11
						when "10001011" => data_out_dec <= (dec_in xor (e sll 11));   -- 11 & 12
						when "11000101" => data_out_dec <= (dec_in xor (e sll 12));   -- 12 & 13
						when "11100010" => data_out_dec <= (dec_in xor (e sll 13));   -- 13 & 14
						when "01110001" => data_out_dec <= (dec_in xor (e sll 14));   -- 14 & 15
						when "10110100" => data_out_dec <= (dec_in xor (e sll 15));   -- 15 & 16
						when "01010110" => data_out_dec <= (dec_in xor (e sll 16));   -- 16 & 17
						when "00101011" => data_out_dec <= (dec_in xor (e sll 17));   -- 17 & 18
						when "10010101" => data_out_dec <= (dec_in xor (e sll 18));   -- 18 & 19
						when "11001010" => data_out_dec <= (dec_in xor (e sll 19));   -- 19 & 20
						
						when "01100101" => data_out_dec <= (dec_in xor (e sll 20));   -- 20 & 21
						when "10110010" => data_out_dec <= (dec_in xor (e sll 21));   -- 21 & 22
						when "01011001" => data_out_dec <= (dec_in xor (e sll 22));   -- 22 & 23
						when "10101010" => data_out_dec <= (dec_in xor (e sll 23));   -- 23 & 24
						when "01010011" => data_out_dec <= (dec_in xor (e sll 24));   -- 24 & 25
						when "10101001" => data_out_dec <= (dec_in xor (e sll 25));   -- 25 & 26
						when "11010100" => data_out_dec <= (dec_in xor (e sll 26));   -- 26 & 27
						when "01101010" => data_out_dec <= (dec_in xor (e sll 27));   -- 27 & 28
						when "00110101" => data_out_dec <= (dec_in xor (e sll 28));   -- 28 & 29
						when "10011010" => data_out_dec <= (dec_in xor (e sll 29));   -- 29 & 30
						
						when "01001101" => data_out_dec <= (dec_in xor (e sll 30));   -- 30 & 31
						when "10100101" => data_out_dec <= (dec_in xor (e sll 31));   -- 31 & 32
						when "11010001" => data_out_dec <= (dec_in xor (e sll 32));   -- 32 & 33
						when "11101000" => data_out_dec <= (dec_in xor (e sll 33));   -- 33 & 34
						when "01110100" => data_out_dec <= (dec_in xor (e sll 34));   -- 34 & 35
						when "00111010" => data_out_dec <= (dec_in xor (e sll 35));   -- 35 & 36
						when "00011101" => data_out_dec <= (dec_in xor (e sll 36));   -- 36 & 37
						when "10001110" => data_out_dec <= (dec_in xor (e sll 37));   -- 37 & 38
						when "11010111" => data_out_dec <= (dec_in xor (e sll 38));   -- 38 & 39
						when "01111011" => data_out_dec <= (dec_in xor (e sll 39));   -- 39 & 40
						
						when "10111101" => data_out_dec <= (dec_in xor (e sll 40));   -- 40 & 41
						when "11011110" => data_out_dec <= (dec_in xor (e sll 41));   -- 41 & 42
						when "01101111" => data_out_dec <= (dec_in xor (e sll 42));   -- 42 & 43
						when "10110111" => data_out_dec <= (dec_in xor (e sll 43));   -- 43 & 44
						when "11011011" => data_out_dec <= (dec_in xor (e sll 44));   -- 44 & 45
						when "11101101" => data_out_dec <= (dec_in xor (e sll 45));   -- 45 & 46
						when "11011000" => data_out_dec <= (dec_in xor (e sll 46));   -- 46 & 47
						when "01100011" => data_out_dec <= (dec_in xor (e sll 47));   -- 47 & 48
						when "11111100" => data_out_dec <= (dec_in xor (e sll 48));   -- 48 & 49
						when "01101100" => data_out_dec <= (dec_in xor (e sll 49));   -- 49 & 50
						
						when "10110001" => data_out_dec <= (dec_in xor (e sll 50));   -- 50 & 51
						when "10000010" => data_out_dec <= (dec_in xor (e sll 51));   -- 51 & 52
						when "10010011" => data_out_dec <= (dec_in xor (e sll 52));   -- 52 & 53
						when "10111000" => data_out_dec <= (dec_in xor (e sll 53));   -- 53 & 54
						when "01110010" => data_out_dec <= (dec_in xor (e sll 54));   -- 54 & 55
						when "00100111" => data_out_dec <= (dec_in xor (e sll 55));   -- 55 & 56						
						when "11111001" => data_out_dec <= (dec_in xor (e sll 56));   -- 56 & 57
						when "10100110" => data_out_dec <= (dec_in xor (e sll 57));   -- 57 & 58
						when "11111010" => data_out_dec <= (dec_in xor (e sll 58));   -- 58 & 59
						when "10111110" => data_out_dec <= (dec_in xor (e sll 59));   -- 59 & 60
						
						when "10101111" => data_out_dec <= (dec_in xor (e sll 60));   -- 61 & 62
						when "01000001" => data_out_dec <= (dec_in xor (e sll 61));   -- 62 & 63
						when "11101011" => data_out_dec <= (dec_in xor (e sll 62));   -- 63 & 64
						
						when  others 	 => data_out_dec <= dec_in;	
					
				end case;			
end process;

END Behavioral; 
