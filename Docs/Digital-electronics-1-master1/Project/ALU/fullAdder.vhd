----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:05:22 04/28/2020 
-- Design Name: 
-- Module Name:    fullAdder - Behavioral 
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

entity fullAdder is
port(
        -- Inputs
		  C_i : in std_logic;		-- carry
		  B_i : in std_logic;
        A_i : in std_logic;     
       
       

        -- Outputs
		 
        C_o : out std_logic;    -- output carry
        Y_o : out std_logic
    );
end fullAdder;

architecture Behavioral of fullAdder is
 
    signal sig_s : std_logic;
    signal sig_c1 : std_logic;
    signal sig_c2 : std_logic;
    
      
begin
    
    ProcessHalfAdder0: entity work.halfAdder
        port map(B_i, A_i, sig_c1, sig_s);

    ProcessHalfAdder1: entity work.halfAdder
        port map(C_i, sig_s, sig_c2, Y_o);

        C_o <= sig_c1 or sig_c2;


end Behavioral;

