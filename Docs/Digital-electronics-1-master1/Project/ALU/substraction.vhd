----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:30:18 04/28/2020 
-- Design Name: 
-- Module Name:    substraction - Behavioral 
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

entity substraction is
 port(
        -- Inputs
        A_i : in std_logic_vector(4-1 downto 0); 
        B_i : in std_logic_vector(4-1 downto 0);
        C_i : in std_logic;

        -- Outputs
        Y_o : out std_logic_vector(4-1 downto 0);
        C_o : out std_logic
    );
end substraction;

architecture Behavioral of substraction is
		--	Signals
	 signal sig_1 : std_logic_vector(4-1 downto 0);     
    signal sig_2 : std_logic_vector(4-1 downto 0);
    signal sig_3 : std_logic_vector(2-1 downto 0);
           
begin


SubstractProcessSubstractionPart0: entity work.negation
	  port map(B_i, sig_1);                             -- NEG B

SubstractProcessSubstractionPart1: entity work.fourAdder
	  port map(sig_1,"0001",'0',sig_2,sig_3(0));       

SubstractProcessSubstractionPart2: entity work.fourAdder
	  port map(sig_2,A_i,'0',Y_o,sig_3(1));            
	  
C_o <= sig_3(0) nor sig_3(1);                           
	  
	  
	  
end Behavioral;

