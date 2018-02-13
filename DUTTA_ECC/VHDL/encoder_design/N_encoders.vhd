----------------------------------------------------------------------------------
-- Company: Microelectronic Systems Design Research Group
-- Engineer: Nkrumah Offonry
-- 
-- Create Date:    12:34:03 07/27/2017 
-- Design Name: 
-- Module Name:    N_encoders - Behavioral 
-- Project Name: 
-- Target Devices: Kintex-7 FPGA Family, Zynq Ultrascale & Ultrascale+
-- Tool versions: 
-- Description: Module to instatiate n Encoders. 
--		For DIMM-based memory archictectures, Burst_length of 8 (64 bits p/burst)
-- 		Thus, 512 bits of data written to memory p/clk
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

entity N_encoders is
    Port ( n_encin : in  STD_LOGIC_VECTOR (511 downto 0);
           n_chk_out : out STD_LOGIC_VECTOR(63 downto 0);
           n_encout : out  STD_LOGIC_VECTOR (511 downto 0));         
end N_encoders;

architecture Behavioral of N_encoders is

component Encoder_Top is
    Port ( encin : in  STD_LOGIC_VECTOR (63 downto 0);
           parout  : out STD_LOGIC_VECTOR (7 downto 0);
           encout : out  STD_LOGIC_VECTOR (63 downto 0));
end component Encoder_Top;


begin

	Encoder1 : Encoder_Top Port map ( 
					 encin => n_encin(63 downto 0), 
					 parout => n_chk_out(7 downto 0),
					 encout => n_encout(63 downto 0) 
					 );
	
	Encoder2 : Encoder_Top Port map ( 
   					 encin => n_encin(127 downto 64), 
   					 parout => n_chk_out(15 downto 8),
    			    		 encout => n_encout(127 downto 64) 
                    			 );
   
	Encoder3 : Encoder_Top Port map (
     					 encin => n_encin(191 downto 128), 
     					 parout => n_chk_out(23 downto 16),
     					 encout => n_encout(191 downto 128) 
     					 );

        Encoder4 : Encoder_Top Port map ( 
     					encin => n_encin(255 downto 192), 
     					parout => n_chk_out(31 downto 24),
      				 	encout => n_encout(255 downto 192) 
  				 	);

	Encoder5 : Encoder_Top Port map (
					 encin => n_encin(319 downto 256), 
					 parout => n_chk_out(39 downto 32),
					 encout => n_encout(319 downto 256) 
					 );

	Encoder6 : Encoder_Top Port map (
   					 encin => n_encin(383 downto 320), 
   					 parout => n_chk_out(47 downto 40),
    				 	 encout => n_encout(383 downto 320) 
    					);

        Encoder7 : Encoder_Top Port map (
    		       			encin => n_encin(447 downto 384), 
    		       			parout => n_chk_out(55 downto 48),
                     			encout => n_encout(447 downto 384) 
   					);
     
	Encoder8 : Encoder_Top Port map (
     				 	encin => n_encin(511 downto 448), 
    				 	parout => n_chk_out(63 downto 56),
   					encout => n_encout(511 downto 448) 
   					);

end Behavioral;

