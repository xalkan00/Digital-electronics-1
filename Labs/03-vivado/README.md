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
entity gates is
    port(           -- Vstupni data
        x_i    : in  std_logic;         
        y_i    : in  std_logic;         
        z_i    : in  std_logic;    
        			-- vystupni data
        f1_o    : out std_logic;
        f2_o    : out std_logic;
        f3_o    : out std_logic;
        f4_o    : out std_logic
       
    );
end entity gates;

------------------------------------------------------------------------
-- Architecture body for basic gates
------------------------------------------------------------------------
architecture dataflow of gates is
begin
 
  
  f1_o <= ((x_i and y_i) or (x_i and z_i));
  f2_o <= (x_i and (y_i or Z_i));
  f3_o <= ((x_i or y_i) and (x_i or z_i));
  f4_o <= (x_i or (y_i and z_i));

end architecture dataflow;
```

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/01-gates/Obrazky/Snímek%20obrazovky%202021-02-16%20105325.png" /> 




 

### Verification of Distributive laws.

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/01-gates/Obrazky/x.png"/>




<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/01-gates/Obrazky/fx.png" />
