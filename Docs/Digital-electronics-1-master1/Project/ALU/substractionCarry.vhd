----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:22:06 04/28/2020 
-- Design Name: 
-- Module Name:    substractionCarry - Behavioral 
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

entity substractionCarry is
port(
        -- Inputs
			A_i : in std_logic_vector(4-1 downto 0);
			B_i : in std_logic_vector(4-1 downto 0);
			C_i : in std_logic;
	
        -- Outputs
		  Y_o : out std_logic_vector(4-1 downto 0) ;
		  C_o : out std_logic
    );
end substractionCarry;

architecture Behavioral of substractionCarry is
    signal sig_1   : std_logic_vector(4-1 downto 0);
    signal sig_2   : std_logic_vector(2-1 downto 0);
    signal carry_s : std_logic_vector(4-1 downto 0);
begin

SubstractionCProcessSubstraction0: entity work.substraction
    port map (A_i,B_i,'0',sig_1,sig_2(0));              
    
SubstractionCProcessSubstraction1: entity work.substraction
    port map (sig_1, carry_s,'0',Y_o,sig_2(1));         
    
c_o <= sig_2(0) or sig_2(1);                          
carry_s(3 downto 1) <= "000";                           
carry_s(0) <= C_i;                                      
 
end Behavioral;

