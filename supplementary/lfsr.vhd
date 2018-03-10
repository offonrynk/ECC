----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nkrumah Offonry
-- 
-- Create Date:    02:18:18 07/16/2017 
-- Design Name: 
-- Module Name:    lfsr - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This module implements an LFSR that generates pseudo random numbers of
--		64 bits that is fed into an encoder block.
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

entity lfsr is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (63 downto 0));
end lfsr;

architecture Behavioral of lfsr is
signal fb :std_logic;
signal q_out : std_logic_vector (63 downto 0):="0000000000000000000000000000000000000000000000000000000000000000";

begin
fb <= not (q_out(63) xor q_out(62) xor q_out(60) xor q_out(59));
process (clk, rst)
begin
	if rst = '0' then 
		q_out(63 downto 0) <= "0000000000000000000000000000000000000000000000000000000000000000";
	elsif clk = '1' and clk'event then
		q_out(63 downto 0) <= q_out(62 downto 0) & fb;
	end if;
	q <= q_out(63 downto 0);
end process;
end Behavioral;

