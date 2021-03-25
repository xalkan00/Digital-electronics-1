----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:22:26 04/28/2020 
-- Design Name: 
-- Module Name:    decrement - Behavioral 
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

entity decrement is

port(
			-- Inputs
        A_i : in std_logic_vector(4-1 downto 0);     
        C_i : in std_logic;
        -- Outputs
        Y_o : out std_logic_vector(4-1 downto 0);    
        C_o : out std_logic
    );
end decrement;

architecture Behavioral of decrement is

begin

    DecrementProcessSubstraction: entity work.substraction
    port map (
        -- Inputs
        A_i => A_i,
        B_i =>"0001",  -- Decrement: Y_o = A- 0001
        C_i => C_i,
		  
        -- Outputs
        Y_o => Y_o,
        C_o => C_o

);
end Behavioral;

