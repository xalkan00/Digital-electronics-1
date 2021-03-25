----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:17:11 04/28/2020 
-- Design Name: 
-- Module Name:    increment - Behavioral 
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

entity increment is
  port(
        -- Inputs
        A_i : in std_logic_vector(4-1 downto 0);     
        C_i : in std_logic;
		  
        -- Outputs
        Y_o : out std_logic_vector(4-1 downto 0);    
        C_o : out std_logic
    );
end increment;

architecture Behavioral of increment is

begin
IncrementProcessAdder: entity work.fourAdder
    port map (
        -- Inputs
        A_i => A_i,
        B_i => "0001", -- Increment: Y_o=A+0001
        C_i => C_i, --carry
        
		  -- Outputs
        Y_o => Y_o,
        C_o => C_o
    );

end Behavioral;

