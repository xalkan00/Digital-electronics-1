----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:39:01 04/28/2020 
-- Design Name: 
-- Module Name:    exDisjunction - Behavioral 
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

entity exDisjunction is
 port(
        -- Inputs
        A_i : in std_logic_vector(4-1 downto 0);     
        B_i : in std_logic_vector(4-1 downto 0); 
        -- Outputs
        Y_o : out std_logic_vector(3 downto 0)    
    );
end exDisjunction;

architecture Behavioral of exDisjunction is

begin
Y_o <= (A_i) xor (B_i);

end Behavioral;

