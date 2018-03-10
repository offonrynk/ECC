----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nkrumah Offonry
-- 
-- Create Date:    10:43:42 07/18/2017 
-- Design Name: 
-- Module Name:    Error_Injector - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This is the Error Injector module that injects single and double adjacent bit error(s).
--		Data and Checkbits from the encoder is fed into the Error Injector as input.
--		Error type shows which type of error was injected.
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.MATH_REAL.ALL;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Error_Injector is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (63 downto 0);
	   check_in : in STD_LOGIC_VECTOR(7 downto 0);
	   error_type : in STD_LOGIC_VECTOR (1 downto 0);
	   check_out : out STD_LOGIC_VECTOR(7 downto 0);
           data_out : out STD_LOGIC_VECTOR(63 downto 0));
end Error_Injector;

architecture Behavioral of Error_Injector is

signal position : integer :=0;
signal c: STD_LOGIC_VECTOR(71 downto 0) := X"000000000000000000";
signal d: unsigned(71 downto 0) := X"000000000000000001";
signal e, dae: STD_LOGIC_VECTOR(71 downto 0);

begin

-- Process to generate errors.
-- First we generate a random position n times
-- Then we set the bit(s) in the randomly generated position(s) to 1.

 rand: process(clk, rst) 
        variable seed1, seed2 : positive;
        variable rand : real;
        variable int_rand : integer range 0 to 71;
begin
   if rst = '0' then
	    position <= 0;
   elsif rising_edge(clk) then
            UNIFORM(seed1, seed2, rand);
            int_rand := INTEGER(rand*71.0);
            position <= int_rand;
   end if;
end process;

c <= STD_LOGIC_VECTOR( d SLL position );
e <= c SLL 1;
dae <= e or c;


Force_Error : process (clk, rst)
begin
	if rst = '0' then
			data_out<= (others=> '0');
			check_out <= (others => '0');
			
	elsif clk = '1' and clk'event then 		
	      case error_type is 
      		when "00" =>   -- no error
			data_out <= data_in xor x"0000000000000000";
			check_out <= check_in xor x"00";

     		 when "01" =>  -- 1 bit error 
			data_out <= data_in xor c(63 downto 0);
			check_out <= check_in xor c (71 downto 64);

      		when  "10" =>  -- Adjacent 2 bit error			
			data_out<= data_in xor dae(63 downto 0);
			check_out <= check_in xor dae (71 downto 64);

      		when others =>
			data_out<= data_in;
			check_out<= check_in;

      end case;  	
end if;
end process;

end Behavioral; 