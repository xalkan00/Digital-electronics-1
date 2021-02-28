# 03-vivado
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)
 
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/mux.png" /> 

| **LED** | **Connection** | **Switch** | **Connection** | 
| :-: | :-: | :-: | :-: |
| SW0 | a_i[0] | LED0 | J15 |
| SW1 | a_i[1] | LED1 | L16 |
| SW2 | b_i[0] | LED2 | M13 |
| SW3 | b_i[1] | LED3 | R15 |
| SW4 | c_i[0] | LED4 | R17 |
| SW5 | c_i[1] | LED5 | T18 |
| SW6 | d_i[0] | LED6 | U18 |
| SW7 | d_i[1] | LED7 | R13 |
| SW8 |   | LED8 | T8 |
| SW9 |   | LED9 | U8 |
| SW10 |   | LED10 | R16 |
| SW11 |   | LED11 | T13 |
| SW12 |   | LED12 | H6 |
| SW13 |   | LED13 | U12 |
| SW14 | sel_i[0]  | LED14 | U11 |
| SW15 | sel_i[1]  | LED15 | V10 |


## VHDL
### mux_2bit_4to1
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
### tb_mux_2bit_4to1

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

## Postup vytvařeni projek ve vivadu
Pro vytvoření nového projektu ve Vivadu, postupujeme následovně: 
File-> Projet-> New
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/1.png" /> 

Klikneme na Next->
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/2.png" /> 

Vyplníme Project name a location->
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/3.png" />

Necháme zvolený RTL project->
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/4.png" />

zvolime v Target language "VHDL", Simulator language "VHDL", Create File: zvolime file type "VHDL" a vyplníme File name -> OK-> Next
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/5.png" />

Klikneme na Next->
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/6.png" />

Překlikneme na záložku Boards a zvolíme vhodnou desku-> Next->Finish
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/7.png" />
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/8.png" />

Je třeba přidat si test bench následovně: File-> Add Source->

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/11.png" />

vybereme-> Add or create simulation sources-> Next
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/12.png" />

Klikneme na-> Create Files-> Vyplníme File name-> OK-> Finish
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/13.png" />

Pro spuštení simulace uložíme změny a pomocí okna: Flow -> Run Simulation -> Run Behavioral Simulation
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/14.png" />

Pro přidání XDC souboru klikneme na  File-> Add Source. 
vybereme -> Add or create constrains-> Create File-> Vyplníme File name-> OK-> Finish

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/03-vivado/image/15.png" />
