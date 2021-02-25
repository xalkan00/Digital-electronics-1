# 03-vivado
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/mux.png" /> 

## VHDL
```VHDL
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for mux_2bit_4to1
------------------------------------------------------------------------
entity mux_2bit_4to1 is
    port(
        a_i           : in  std_logic_vector(2 - 1 downto 0);
		b_i           : in  std_logic_vector(2 - 1 downto 0);
		c_i           : in  std_logic_vector(2 - 1 downto 0);
		d_i           : in  std_logic_vector(2 - 1 downto 0);
		sel_i         : in  std_logic_vector(2 - 1 downto 0);
        f_o           : out std_logic_vector(2 - 1 downto 0)     
    );
end entity mux_2bit_4to1;

------------------------------------------------------------------------
-- Architecture body for mux_2bit_4to1
------------------------------------------------------------------------
architecture Behavioral of mux_2bit_4to1 is
begin
       f_o <= a_i when (sel_i = "00" ) else
              b_i when (sel_i = "01" ) else
              c_i when (sel_i = "10" ) else
              d_i;

end architecture Behavioral;

```


``` VHDL
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_mux_2bit_4to1 is
    -- Entity of testbench is always empty
end entity tb_mux_2bit_4to1;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_mux_2bit_4to1 is

    -- Local signals
    signal s_a       : std_logic_vector(2 - 1 downto 0);
    signal s_b       : std_logic_vector(2 - 1 downto 0);
    signal s_c       : std_logic_vector(2 - 1 downto 0);
    signal s_d       : std_logic_vector(2 - 1 downto 0);
    signal s_sel     : std_logic_vector(2 - 1 downto 0);
    signal s_f       : std_logic_vector(2 - 1 downto 0);

begin
    uut_comparator_2bit : entity work.mux_2bit_4to1
        port map(
            a_i           => s_a,
            b_i           => s_b,
            c_i           => s_c,
            d_i           => s_d,
            sel_i         => s_sel,
            f_o           => s_f
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;

        s_a <= "00" ; 
        s_b <= "00" ; 
        s_c <= "00" ; 
        s_d <= "00" ;      
        s_sel <= "01" ; wait for 100 ns;  
        s_sel <= "10" ; wait for 100 ns;  
        s_sel <= "11" ; wait for 100 ns;  
        
        s_a <= "10" ; 
        s_b <= "00" ; 
        s_c <= "10" ; 
        s_d <= "11" ;        
        s_sel <= "00" ; wait for 100 ns;  
        s_sel <= "01" ; wait for 100 ns;  
          
        s_a <= "01" ; 
        s_b <= "11" ; 
        s_c <= "10" ; 
        s_d <= "10" ; 
        s_sel <= "00" ; wait for 100 ns;  
        s_sel <= "01" ; wait for 100 ns;
        s_sel <= "10" ; wait for 100 ns; 
        s_sel <= "11" ; wait for 100 ns;   
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
```
## Simulace
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/simulace.png" /> 

