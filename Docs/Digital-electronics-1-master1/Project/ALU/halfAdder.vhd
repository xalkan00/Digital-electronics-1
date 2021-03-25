----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:07:46 04/28/2020 
-- Design Name: 
-- Module Name:    halfAdder - Behavioral 
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

entity halfAdder is
port(
        -- Inputs
        B_i : in std_logic;
        A_i : in std_logic;

        -- Outputs
        C_o : out std_logic;    -- carry
        Y_o : out std_logic
    );
end halfAdder;

architecture Behavioral of halfAdder is

begin
   Y_o <= B_i xor A_i;
   C_o <= B_i and A_i;

end Behavioral;

