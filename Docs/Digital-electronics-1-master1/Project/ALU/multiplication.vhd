----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:37:06 04/28/2020 
-- Design Name: 
-- Module Name:    multiplication - Behavioral 
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

entity multiplication is
 port(
        -- Inputs
        A_i : in std_logic_vector(4-1 downto 0);     
        B_i : in std_logic_vector(4-1 downto 0); 
		  
        -- Outputs
        Y_o : out std_logic_vector(4-1 downto 0);
        C_o : out std_logic    
    );
end multiplication;

architecture Behavioral of multiplication is
	 signal sig_1 : std_logic_vector(4-1 downto 0); -- 1×
    signal sig_2 : std_logic_vector(4-1 downto 0);	-- 2×
	 signal sig_3 : std_logic_vector(4-1 downto 0); -- 3×
	 signal sig_4 : std_logic_vector(4-1 downto 0); -- 4×
	 signal sig_5 : std_logic_vector(4-1 downto 0); -- sig_1 + sig_2
	 signal sig_6 : std_logic_vector(4-1 downto 0); -- sig_3 + sig_4
	 signal sig_7 : std_logic_vector(4-1 downto 0); -- carry bits
	 signal sig_2_p : std_logic_vector(4-1 downto 0); -- 1× moved
	 signal sig_3_p : std_logic_vector(4-1 downto 0); -- 1× moved
	 signal sig_4_p : std_logic_vector(4-1 downto 0); -- 1× moved
	 signal sig_7_p : std_logic_vector(2-1 downto 0); -- carry 

begin
sig_1 <= A_i AND (B_i(0)&B_i(0)&B_i(0)&B_i(0));         -- A × B(0)
sig_2 <= A_i AND (B_i(1)&B_i(1)&B_i(1)&B_i(1));         -- A × B(1)
sig_3 <= A_i AND (B_i(2)&B_i(2)&B_i(2)&B_i(2));         -- A × B(3)
sig_4 <= A_i AND (B_i(3)&B_i(3)&B_i(3)&B_i(3));         -- A × B(4)

sig_2_p(3 downto 1) <= sig_2(2 downto 0);               -- move bite by 1
sig_2_p(0) <= '0';                                      -- 0 position 0

sig_3_p(3 downto 2) <= sig_3(1 downto 0);               -- move bite by 2
sig_3_p(1 downto 0) <= "00";                            -- 0 on position 0,1

sig_4_p(3 downto 3) <= sig_4(0 downto 0);               -- move bite by 3
sig_4_p(2 downto 0) <= "000";                           -- 0 on position 0,1,2

sig_7_p(1) <= (sig_7(0) OR sig_7(1));                   -- carry bit summ

sig_7_p(0) <= sig_7(2) or sig_2(3) or sig_3(2) or sig_3(3) or sig_4(1) or sig_4(2) or sig_4(3);     -- SUM of carry and unused

C_o <= sig_7_p(0);                                     --carry to output

ProcessMultiplicationPart1: entity work.fourAdder                             -- sig_1 + sig_2
    port map (
        -- Inputs
        A_i => sig_1,
        B_i => sig_2_p,
        C_i => '0',
        -- Outputs
        Y_o => sig_5,
        C_o => sig_7(0)
);

ProcessMultiplicationPart2: entity work.fourAdder                             -- sig_3_p + sig_4_p
    port map (
        -- Inputs
        A_i => sig_3_p,
        B_i => sig_4_p,
        C_i => '0',
        -- Outputs
        Y_o => sig_6,
        C_o => sig_7(1)
);

ProcessMultiplicationPart3: entity work.fourAdder                             -- MultiplicationPart1+MultiplicationPart2
    port map (
        -- Inputs
        A_i => sig_5,
        B_i => sig_6,
        C_i => '0',
        -- Outputs
        Y_o => Y_o,
        C_o => sig_7(2)
);



end Behavioral;

