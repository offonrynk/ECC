----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:53:10 06/29/2017 
-- Design Name: 
-- Module Name:    Encoder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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
entity PRNG is
    Port ( clk : in STD_LOGIC;
           random_num : out STD_LOGIC_VECTOR (63 downto 0));
end PRNG;

architecture Behavioral of PRNG is

signal feedback : std_logic := '0';
signal q_out : std_logic_vector(63 downto 0):=(63 => '1', others => '0');
begin

process (clk)
begin
    if (rising_edge(clk)) then
			feedback <= not (q_out(63) xor q_out(62) xor q_out(60) xor q_out(59));
			q_out <= q_out(62 downto 0) & feedback;
    end if;
end process;
random_num <= q_out(63 downto 0);

end Behavioral;