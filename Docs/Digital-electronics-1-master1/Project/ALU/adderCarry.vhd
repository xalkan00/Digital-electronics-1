----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:50:31 04/28/2020 
-- Design Name: 
-- Module Name:    adderCarry - Behavioral 
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

entity adderCarry is
port(
        -- Inputs	  
			A_i : in std_logic_vector(4-1 downto 0);
			B_i : in std_logic_vector(4-1 downto 0);
			C_i : in std_logic;
			
        -- Outputs
		  Y_o : out std_logic_vector(4-1 downto 0) ;
		  C_o : out std_logic
    );
end adderCarry;

architecture Behavioral of adderCarry is

begin
AdderCProsess: entity work.fourAdder
	  port map(A_i,B_i,C_i,Y_o,C_o);

end Behavioral;

