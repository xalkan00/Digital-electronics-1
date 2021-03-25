----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:02:37 04/28/2020 
-- Design Name: 
-- Module Name:    fourAdder - Behavioral 
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

entity fourAdder is
port(
        -- Inputs
			A_i : in std_logic_vector(4-1 downto 0);
			B_i : in std_logic_vector(4-1 downto 0);
			C_i : in std_logic;

        -- Outputs
		  Y_o : out std_logic_vector(4-1 downto 0) ;
		  C_o : out std_logic
    );
end fourAdder;


architecture Behavioral of fourAdder is
    signal s_c0, s_c1, s_c2 : std_logic;  -- internal signals
begin

    AdderProcessFullAdder0: entity work.fullAdder
        port map(C_i, B_i(0), A_i(0), s_c0, Y_o(0));        
    
	 AdderProcessFullAdder1: entity work.fullAdder
        port map(s_c0, B_i(1), A_i(1), s_c1, Y_o(1));       
    
	 AdderProcessFullAdder2: entity work.fullAdder
        port map(s_c1, B_i(2), A_i(2), s_c2, Y_o(2));       
    
	 AdderProcessFullAdder3: entity work.fullAdder
        port map(s_c2, B_i(3), A_i(3), C_o, Y_o(3));       



end Behavioral;

