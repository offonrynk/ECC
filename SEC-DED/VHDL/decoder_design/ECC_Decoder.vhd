----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nkrumah Offonry
-- 
-- Create Date:    11:52:56 11/28/2017 
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

-- 00 = no error
-- 01 = single bit error
-- 10 = double bit error
-- 11 = uncorrectable error

entity Decoder is
	Port(   data_in_dec : in  STD_LOGIC_VECTOR (63 downto 0);
		    checkbits_in :in STD_LOGIC_VECTOR(7 downto 0);
		    error_type : out STD_LOGIC_VECTOR(1 downto 0);
	     	data_out_dec : out  STD_LOGIC_VECTOR (63 downto 0));
end Decoder;

architecture Behavioral of Decoder is

signal syndrome, dec_checkbits, chk_in : STD_LOGIC_VECTOR(7 downto 0);
signal dec_in, mask : STD_LOGIC_VECTOR(63 downto 0);     
BEGIN

--DECODER
				  
				dec_in <= data_in_dec;
				chk_in <= checkbits_in;
				
				data_out_dec <= dec_in xor mask; 
-- Syndrome computation

syndrome <= chk_in xor dec_checkbits;

dec_checkbits(0) 
<= dec_in(0) xor dec_in(1) xor dec_in(3) xor dec_in(4) xor dec_in(6) xor dec_in(8) xor dec_in(10) xor dec_in(11)
xor dec_in(13) xor dec_in(15) xor dec_in(17) xor dec_in(19) xor dec_in(21) xor dec_in(23) xor dec_in(25) xor dec_in(26)
xor dec_in(28) xor dec_in(30) xor dec_in(32) xor dec_in(34) xor dec_in(36) xor dec_in(38) xor dec_in(40) xor dec_in(42)
xor dec_in(44) xor dec_in(46) xor dec_in(48) xor dec_in(50) xor dec_in(52) xor dec_in(54) xor dec_in(56) xor dec_in(57)
xor dec_in(59) xor dec_in(61) xor dec_in(63);

dec_checkbits(1) 
<= dec_in(0) xor dec_in(2) xor dec_in(3) xor dec_in(5) xor dec_in(6) xor dec_in(9) xor dec_in(10) xor dec_in(12)
xor dec_in(13) xor dec_in(16) xor dec_in(17) xor dec_in(20) xor dec_in(21) xor dec_in(24) xor dec_in(25) xor dec_in(27)
xor dec_in(28) xor dec_in(31) xor dec_in(32) xor dec_in(35) xor dec_in(36) xor dec_in(39) xor dec_in(40) xor dec_in(43)
xor dec_in(44) xor dec_in(47) xor dec_in(48) xor dec_in(51) xor dec_in(52) xor dec_in(55) xor dec_in(56) xor dec_in(58)
xor dec_in(59) xor dec_in(62) xor dec_in(63);

dec_checkbits(2) 
<= dec_in(1) xor dec_in(2) xor dec_in(3) xor dec_in(7) xor dec_in(8) xor dec_in(9) xor dec_in(10) xor dec_in(14)
xor dec_in(15) xor dec_in(16) xor dec_in(17) xor dec_in(22) xor dec_in(23) xor dec_in(24) xor dec_in(25) xor dec_in(29)
xor dec_in(30) xor dec_in(31) xor dec_in(32) xor dec_in(37) xor dec_in(38) xor dec_in(39) xor dec_in(40) xor dec_in(45)
xor dec_in(46) xor dec_in(47) xor dec_in(48) xor dec_in(53) xor dec_in(54) xor dec_in(55) xor dec_in(56) xor dec_in(60)
xor dec_in(61) xor dec_in(62) xor dec_in(63);

dec_checkbits(3) 
<= dec_in(4) xor dec_in(5) xor dec_in(6) xor dec_in(7) xor dec_in(8) xor dec_in(9) xor dec_in(10) xor dec_in(18)
xor dec_in(19) xor dec_in(20) xor dec_in(21) xor dec_in(22) xor dec_in(23) xor dec_in(24) xor dec_in(25) xor dec_in(33)
xor dec_in(34) xor dec_in(35) xor dec_in(36) xor dec_in(37) xor dec_in(38) xor dec_in(39) xor dec_in(40) xor dec_in(49)
xor dec_in(50) xor dec_in(51) xor dec_in(52) xor dec_in(53) xor dec_in(54) xor dec_in(55) xor dec_in(56);

dec_checkbits(4) 
<=  dec_in(11) xor dec_in(12) xor dec_in(13) xor dec_in(14) xor dec_in(15) xor dec_in(16) xor dec_in(17) xor dec_in(18)
xor dec_in(19) xor dec_in(20) xor dec_in(21) xor dec_in(22) xor dec_in(23) xor dec_in(24) xor dec_in(25) xor dec_in(41)
xor dec_in(42) xor dec_in(43) xor dec_in(44) xor dec_in(45) xor dec_in(46) xor dec_in(47) xor dec_in(48) xor dec_in(49)
xor dec_in(50) xor dec_in(51) xor dec_in(52) xor dec_in(53) xor dec_in(54) xor dec_in(55) xor dec_in(56);

dec_checkbits(5)
<=  dec_in(26) xor dec_in(27) xor dec_in(28) xor dec_in(29) xor dec_in(30) xor dec_in(31) xor dec_in(32) xor dec_in(33)
xor dec_in(34) xor dec_in(35) xor dec_in(36) xor dec_in(37) xor dec_in(38) xor dec_in(39) xor dec_in(40) xor dec_in(41) 
xor dec_in(42) xor dec_in(43) xor dec_in(44) xor dec_in(45) xor dec_in(46) xor dec_in(47) xor dec_in(48) xor dec_in(49) 
xor dec_in(50) xor dec_in(51) xor dec_in(52) xor dec_in(53) xor dec_in(54) xor dec_in(55) xor dec_in(56);

dec_checkbits(6)
<= dec_in(57) xor dec_in(58) xor dec_in(59) xor dec_in(60) xor dec_in(61) xor dec_in(62) xor dec_in(63);

dec_checkbits(7)
<=  dec_in(0)  xor dec_in(1)  xor dec_in(2)  xor dec_in(3)  xor dec_in(4)  xor dec_in(5)  xor dec_in(6)  xor dec_in(7)  
xor dec_in(8)  xor dec_in(9)  xor dec_in(10) xor dec_in(11) xor dec_in(12) xor dec_in(13) xor dec_in(14) xor dec_in(15) 
xor dec_in(16) xor dec_in(17) xor dec_in(18) xor dec_in(19) xor dec_in(20) xor dec_in(21) xor dec_in(22) xor dec_in(23) 
xor dec_in(24) xor dec_in(25) xor dec_in(26) xor dec_in(27) xor dec_in(28) xor dec_in(29) xor dec_in(30) xor dec_in(31) 
xor dec_in(32) xor dec_in(33) xor dec_in(34) xor dec_in(35) xor dec_in(36) xor dec_in(37) xor dec_in(38) xor dec_in(39) 
xor dec_in(40) xor dec_in(41) xor dec_in(42) xor dec_in(43) xor dec_in(44) xor dec_in(45) xor dec_in(46) xor dec_in(47) 
xor dec_in(48) xor dec_in(49) xor dec_in(50) xor dec_in(51) xor dec_in(52) xor dec_in(53) xor dec_in(54) xor dec_in(55) 
xor dec_in(56) xor dec_in(57) xor dec_in(58) xor dec_in(59) xor dec_in(60) xor dec_in(61) xor dec_in(62) xor dec_in(63)
xor chk_in(6) xor chk_in(5) xor chk_in(4) xor chk_in(3) xor chk_in(2) xor chk_in(1) xor chk_in(0);

--Error Detection and Correction 
Correction_Detection: process (dec_in, syndrome)

begin
		case syndrome is	
					           when "00000000"	=> mask <= X"0000000000000000"; -- no error								 
								   
					--Single Bit Error
						        when "10000011" => mask <= X"0000000000000001"; -- 0
                                when "10000101" => mask <= X"0000000000000002"; -- 1            
                                when "10000110" => mask <= X"0000000000000004"; -- 2            
                                when "10000111" => mask <= X"0000000000000008"; -- 3
                                when "10001001" => mask <= X"0000000000000010"; -- 4
                                when "10001010" => mask <= X"0000000000000020"; -- 5
                                when "10001011" => mask <= X"0000000000000040"; -- 6
                                when "10001100" => mask <= X"0000000000000080"; -- 7
                                when "10001101" => mask <= X"0000000000000100"; -- 8
                                when "10001110" => mask <= X"0000000000000200"; -- 9
                    
                                when "10001111" => mask <= X"0000000000000400"; -- 10
                                when "10010001" => mask <= X"0000000000000800"; -- 11
                                when "10010010" => mask <= X"0000000000001000"; -- 12
                                when "10010011" => mask <= X"0000000000002000"; -- 13
                                when "10010100" => mask <= X"0000000000004000"; -- 14
                                when "10010101" => mask <= X"0000000000008000"; -- 15
                                when "10010110" => mask <= X"0000000000010000"; -- 16
                                when "10010111" => mask <= X"0000000000020000"; -- 17
                                when "10011000" => mask <= X"0000000000040000"; -- 18
                                when "10011001" => mask <= X"0000000000080000"; -- 19
                    
                                when "10011010" => mask <= X"0000000000100000"; -- 20
                                when "10011011" => mask <= X"0000000000200000"; -- 21
                                when "10011100" => mask <= X"0000000000400000"; -- 22
                                when "10011101" => mask <= X"0000000000800000"; -- 23
                                when "10011110" => mask <= X"0000000001000000"; -- 24
                                when "10011111" => mask <= X"0000000002000000"; -- 25
                                when "10100001" => mask <= X"0000000004000000"; -- 26
                                when "10100010" => mask <= X"0000000008000000"; -- 27
                                when "10100011" => mask <= X"0000000010000000"; -- 28
                                when "10100100" => mask <= X"0000000020000000"; -- 29
                    
                                when "10100101" => mask <= X"0000000040000000"; -- 30
                                when "10100110" => mask <= X"0000000080000000"; -- 31
                                when "10100111" => mask <= X"0000000100000000"; -- 32
                                when "10101000" => mask <= X"0000000200000000"; -- 33
                                when "10101001" => mask <= X"0000000400000000"; -- 34
                                when "10101010" => mask <= X"0000000800000000"; -- 35
                                when "10101011" => mask <= X"0000001000000000"; -- 36
                                when "10101100" => mask <= X"0000002000000000"; -- 37
                                when "10101101" => mask <= X"0000004000000000"; -- 38
                                when "10101110" => mask <= X"0000008000000000"; -- 39
                    
                                when "10101111" => mask <= X"0000010000000000"; -- 40
                                when "10110000" => mask <= X"0000020000000000"; -- 41
                                when "10110001" => mask <= X"0000040000000000"; -- 42
                                when "10110010" => mask <= X"0000080000000000"; -- 43
                                when "10110011" => mask <= X"0000100000000000"; -- 44
                                when "10110100" => mask <= X"0000200000000000"; -- 45
                                when "10110101" => mask <= X"0000400000000000"; -- 46
                                when "10110110" => mask <= X"0000800000000000"; -- 47
                                when "10110111" => mask <= X"0001000000000000"; -- 48
                                when "10111000" => mask <= X"0002000000000000"; -- 49
                    
                                when "10111001" => mask <= X"0004000000000000"; -- 50
                                when "10111010" => mask <= X"0008000000000000"; -- 51
                                when "10111011" => mask <= X"0010000000000000"; -- 52
                                when "10111100" => mask <= X"0020000000000000"; -- 53
                                when "10111101" => mask <= X"0040000000000000"; -- 54
                                when "10111110" => mask <= X"0080000000000000"; -- 55
                                when "10111111" => mask <= X"0100000000000000"; -- 56
                                when "11000001" => mask <= X"0200000000000000"; -- 57
                                when "11000010" => mask <= X"0400000000000000"; -- 58
                                when "11000011" => mask <= X"0800000000000000"; -- 59
                    
                                when "11000100" => mask <= X"1000000000000000"; -- 60
                                when "11000101" => mask <= X"2000000000000000"; -- 61
                                when "11000110" => mask <= X"4000000000000000"; -- 62
                                when "11000111" => mask <= X"8000000000000000"; -- 63    
                               
                                when  others     =>mask <= X"0000000000000000";
                            end case;
                        
end process;


error : PROCESS (syndrome)
begin
		case syndrome(7) is
			when '0' => 
				case syndrome(6 downto 0) is
					when "0000000" => error_type <= "00"; -- no error 
					when others    => error_type <= "10"; -- double error
				end case;
			when '1' => 
				case syndrome(6 downto 3) is
					when "1001" => error_type <= "11"; -- detect multiple errors
					when "1010" => error_type <= "11";
					when "1011" => error_type <= "11";
					when "1100" => error_type <= "11";
					when "1101" => error_type <= "11";
					when "1110" => error_type <= "11";
					when "1111" => error_type <= "11";																																		
					when others => error_type <= "01";  -- single error
				end case;
			when others => error_type <= "11";
		end case;

END PROCESS;
END Behavioral; 