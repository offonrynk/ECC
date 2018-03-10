----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Nkrumah Offonry
-- 
-- Create Date:    13:45:39 09/14/2017 
-- Design Name: 
-- Module Name:    N_Decoders - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Module to instantiate n decoders for a SEC-DED-TAED code
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

entity N_decoders is
    Port ( n_decin : in  STD_LOGIC_VECTOR (591 downto 0);
	   error_type : out STD_LOGIC_VECTOR(2 downto 0);
           n_decout : out  STD_LOGIC_VECTOR (591 downto 0));
end N_decoders;

architecture Behavioral of N_decoders is

component Decoder_Top 
	     Port( error_type : out STD_LOGIC_VECTOR(2 downto 0);
	   	   decin : in STD_LOGIC_VECTOR(73 downto 0);
          	   decout : out  STD_LOGIC_VECTOR (73 downto 0));
end component Decoder_Top;

begin
	Decoder1 : Decoder_Top Port map (error_type => error_type,
					 decin => n_decin(73 downto 0), 
					 decout => n_decout(73 downto 0) 
					 );

	Decoder2 : Decoder_Top Port map (error_type => error_type,					 
    					 decin => n_decin(147 downto 74), 
    					 decout => n_decout(147 downto 74) 
 					 );

        Decoder3 : Decoder_Top Port map (error_type => error_type,					 
    					 decin => n_decin(221 downto 148), 
   	    				 decout => n_decout(221 downto 148) 
     					 );

     	Decoder4 : Decoder_Top Port map (error_type => error_type,					 
      					 decin => n_decin(295 downto 222), 
    					 decout => n_decout(295 downto 222) 
  					 );

	Decoder5 : Decoder_Top Port map (error_type => error_type,
					 
					 decin => n_decin(369 downto 296), 
					 decout => n_decout(369 downto 296) 
					 );

	Decoder6 : Decoder_Top Port map (error_type => error_type,					 
  					 decin => n_decin(443 downto 370), 
  					 decout => n_decout(443 downto 370) 
  					 );
       
	Decoder7 : Decoder_Top Port map (error_type => error_type,				         
     					 decin => n_decin(517 downto 444), 
   					 decout => n_decout(517 downto 444) 
 					 );

        Decoder8 : Decoder_Top Port map (error_type => error_type,				
    					 decin => n_decin(591 downto 518), 
    					 decout => n_decout(591 downto 518) 
   					 );

end Behavioral;

