----------------------------------------------------------------------------------
-- Company: Microelectronic Systems Design Research Group
-- Engineer: Nkrumah Offonry
-- Create Date:    13:45:39 07/27/2017 
-- Module Name:    N_Decoders - Behavioral
-- Target Devices: Kintex-7 FPGA Family, Zynq Ultrascale & Ultrascale+
-- Description: Module to instantiate n decoders
-- Additional Comments: For this design, Burst_length of 8 (64 bits p/burst)
-- 			Thus, 512 bits of data read from memory 
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

entity N_decoders is
    Port ( n_decin : in  STD_LOGIC_VECTOR (511 downto 0);
           n_chk_in : in STD_LOGIC_VECTOR (63 downto 0);
           n_decout : out STD_LOGIC_VECTOR (511 downto 0));
end N_decoders;

architecture Behavioral of N_decoders is

component Decoder_Top 
	     Port( decin : in STD_LOGIC_VECTOR(63 downto 0);
	   	   parin : in STD_LOGIC_VECTOR(7 downto 0);
          	   decout : out STD_LOGIC_VECTOR (63 downto 0));
end component Decoder_Top;

begin
	Decoder1 : Decoder_Top Port map ( decin => n_decin(63 downto 0), 
					 parin => n_chk_in(7 downto 0),
					 decout => n_decout(63 downto 0)
					 );

	Decoder2 : Decoder_Top Port map ( 
    					 decin => n_decin(127 downto 64), 
    				 	 parin => n_chk_in(15 downto 8),
    				 	 decout => n_decout(127 downto 64)
 					);

        Decoder3 : Decoder_Top Port map ( 
    					 decin => n_decin(191 downto 128), 
    				 	 parin => n_chk_in(23 downto 16),
   	   				 decout => n_decout(191 downto 128)
     				 	);

     	Decoder4 : Decoder_Top Port map (
					 decin => n_decin(255 downto 192),
      				 	 parin => n_chk_in(31 downto 24), 
    				 	 decout => n_decout(255 downto 192)
                     			);

	Decoder5 : Decoder_Top Port map (
					 decin => n_decin(319 downto 256), 
					 parin => n_chk_in(39 downto 32),
					 decout => n_decout(319 downto 256) 
					 );

	Decoder6 : Decoder_Top Port map (
  					 decin => n_decin(383 downto 320), 
  					 parin => n_chk_in(47 downto 40),
  					 decout => n_decout(383 downto 320)
                     			);
       
	Decoder7 : Decoder_Top Port map (
     		     			 decin => n_decin(447 downto 384), 
     				 	 parin => n_chk_in(55 downto 48),
   				    	 decout => n_decout(447 downto 384)   				      
 				        );

        Decoder8 : Decoder_Top Port map (
    				 	decin => n_decin(511 downto 448), 
    				 	parin => n_chk_in(63 downto 56),
    				 	decout => n_decout(511 downto 448)
   					);

end Behavioral;

