# Lab 2: Combinational logic



| |**B[1:0]**|**A[1:0]**|**B>A**|**B=A**|**B<A**|
| :-: | :-: | :-: | :-: | :-: | :-: |
|0| 0 0 | 0 0 | 0 | 1 | 0 | 
|1| 0 0 | 0 1 | 0 | 0 | 1 | 
|2| 0 0 | 1 0 | 0 | 0 | 1 | 
|3| 0 0 | 1 1 | 0 | 0 | 1 | 
|4| 0 1 | 0 0 | 1 | 0 | 0 | 
|5| 0 1 | 0 1 | 0 | 1 | 0 | 
|6| 0 1 | 1 0 | 0 | 0 | 1 | 
|7| 0 1 | 1 1 | 0 | 0 | 1 | 
|8| 1 0 | 0 0 | 1 | 0 | 0 | 
|9| 1 0 | 0 1 | 1 | 0 | 0 | 
|10| 1 0 | 1 0 | 0 | 1 | 0 | 
|11| 1 0 | 1 1 | 0 | 0 | 1 | 
|12| 1 1 | 0 0 | 1 | 0 | 0 |
|13| 1 1 | 0 1 | 1 | 0 | 0 | 
|14| 1 1 | 1 0 | 1 | 0 | 0 | 
|15| 1 1 | 1 1 | 0 | 1 | 0 |   

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/02-logic/image/Sop-Pos.png" />

## K-Map (B is greater than A)
| **B[1:0]\A[1:0]** | **00** | **01** | **11** | **10** |
| :-: | :-: | :-: | :-: | :-: |
| 00 |  |  |  |  |
| 01 | 1 |  |  |  |
| 11 | 1 | 1 |  | 1 |
| 10 | 1 | 1 |  |  |

## K-Map (B is less than A)
| **B[1:0]\A[1:0]** | **00** | **01** | **11** | **10** |
| :-: | :-: | :-: | :-: | :-: |
| 00 |  | 1 | 1 | 1 |
| 01 |  | 1 | 1 |  |
| 11 |  |  |  |  |
| 10 |  |  | 1 |  |

## K-Map (B equals A)
| **B[1:0]\A[1:0]** | **00** | **01** | **11** | **10** |
| :-: | :-: | :-: | :-: | :-: |
| 00 | 1 |  |  |  |
| 01 |  | 1 |  |  |
| 11 |  |  | 1 |  |
| 10 |  |  |  | 1 |

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/02-logic/image/K-map.png" />

## VHDL code (design.vhd).
``` VHDL
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for 2-bit binary comparator
------------------------------------------------------------------------
entity comparator_2bit is
    port(
    						-- vstupy
        a_i           : in  std_logic_vector(4 - 1 downto 0);
        b_i           : in  std_logic_vector(4 - 1 downto 0);

							-- vystupy
              
        B_greater_A_o : out std_logic;  --B vetši než A
        B_equals_A_o  : out std_logic;  --B se rovna A
        B_less_A_o    : out std_logic   --B menší než A
    );
end entity comparator_2bit;

------------------------------------------------------------------------
-- Architecture body for 2-bit binary comparator
------------------------------------------------------------------------
architecture Behavioral of comparator_2bit is
begin
    B_greater_A_o   <= '1' when (b_i > a_i) else '0';
    B_equals_A_o   <= '1' when (b_i = a_i) else '0';
    B_less_A_o   <= '1' when (b_i < a_i) else '0';

  
end architecture Behavioral;

```
## VHDL testbench (testbench.vhd.

``` VHDL
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_comparator_2bit is
    -- Entity of testbench is always empty
end entity tb_comparator_2bit;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_comparator_2bit is

    -- Local signals
    signal s_a       : std_logic_vector(4 - 1 downto 0);
    signal s_b       : std_logic_vector(4 - 1 downto 0);
    signal s_B_greater_A : std_logic;
    signal s_B_equals_A  : std_logic;
    signal s_B_less_A    : std_logic;

begin
    -- Connecting testbench signals with comparator_2bit entity (Unit Under Test)
    uut_comparator_2bit : entity work.comparator_2bit
        port map(
            a_i           => s_a,
            b_i           => s_b,
            B_greater_A_o => s_B_greater_A,
            B_equals_A_o  => s_B_equals_A,
            B_less_A_o    => s_B_less_A
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;
        
        --tady mame prvni 20 kombinaci 
        
        --0--
		s_b <= "0000"; s_a <= "0000"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
		report "Test failed for input combination: 0000, 0000" severity error;
        
        --1--
		s_b <= "0000"; s_a <= "0001"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0001" severity error;
        
        --2--
		s_b <= "0000"; s_a <= "0010"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0010" severity error;
        
        --3--
		s_b <= "0000"; s_a <= "0011"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0011" severity error;
		
        --4--
		s_b <= "0000"; s_a <= "0100"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0100" severity error;
		
        --5--
		s_b <= "0000"; s_a <= "0101"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0101" severity error;
		
        --6--
		s_b <= "0000"; s_a <= "0110"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0110" severity error;
		
        --7--
		s_b <= "0000"; s_a <= "0111"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 0111" severity error;

	--8--
		s_b <= "0000"; s_a <= "1000"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 1000" severity error;
		
        --9--
		s_b <= "0000"; s_a <= "1001"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 1001" severity error;

	--10--
		s_b <= "0000"; s_a <= "1010"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 1010" severity error;
		
        --11--
		s_b <= "0000"; s_a <= "1011"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 1011" severity error;
		
        --12--
		s_b <= "0000"; s_a <= "1100"; wait for 100 ns;
		assert ((s_B_greater_A = '1') and (s_B_equals_A = '1') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 1100" severity error;
		
        --13--
		s_b <= "0000"; s_a <= "1101"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 1101" severity error;
		
        --14--
		s_b <= "0000"; s_a <= "1110"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 1110" severity error;
		
        --15--
		s_b <= "0000"; s_a <= "1111"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0000, 1111" severity error;
		
        --16--
		s_b <= "0001"; s_a <= "0000"; wait for 100 ns;
		assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))
		report "Test failed for input combination: 0001, 0000" severity error;
		
        --17--
		s_b <= "0001"; s_a <= "0001"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
		report "Test failed for input combination: 0001, 0001" severity error;
		
        --18--
		s_b <= "0001"; s_a <= "0010"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0001, 0010" severity error;
		
        --19--
		s_b <= "0001"; s_a <= "0011"; wait for 100 ns;
		assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
		report "Test failed for input combination: 0001, 0011" severity error;


        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;

```
## Error
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/02-logic/image/error.png"/>

## Simulatien
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/02-logic/image/4-bit.png"/>

[EDA Playground](https://www.edaplayground.com/x/8Rem)
