# 06-display_driver
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)



## 1.Preparation tasks (done before the lab at home). Submit:

<img src="   " />

### 1.1 Timing diagram figure for displaying value 3.142.


## 2.Display driver. Submit:

### 2.1 Listing of VHDL code of the process p_mux with syntax highlighting.

``` VHDL
    p_mux : process(s_cnt, data0_i, data1_i, data2_i, data3_i, dp_i)
    begin
        case s_cnt is
            when "11" =>
                s_hex <= data3_i;
                dp_o  <= dp_i(3);
                dig_o <= "0111";

            when "10" =>
                s_hex <= data2_i;
                dp_o  <= dp_i(2);
                dig_o <= "1011";

            when "01" =>
                s_hex <= data1_i;
                dp_o  <= dp_i(1);
                dig_o <= "1101";

            when others =>
                s_hex <= data0_i;
                dp_o  <= dp_i(0);
                dig_o <= "1110";
        end case;
    end process p_mux;
```

### 2.2 Listing of VHDL testbench file tb_driver_7seg_4digits with syntax highlighting and asserts,

``` VHDL
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_driver_7seg_4digits is
    -- Entity of testbench is always empty
end entity tb_driver_7seg_4digits;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_driver_7seg_4digits is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    
    --signal clk     : in  std_logic;        -- Main clock        
    signal s_reset   :   std_logic;        -- Synchronous reset 
                                                         
    signal s_data0_i :   std_logic_vector(4 - 1 downto 0);      
    signal s_data1_i :   std_logic_vector(4 - 1 downto 0);      
    signal s_data2_i :   std_logic_vector(4 - 1 downto 0);      
    signal s_data3_i :   std_logic_vector(4 - 1 downto 0);      
    signal s_dp_i    :   std_logic_vector(4 - 1 downto 0);      
                                                         
    signal s_dp_o    :  std_logic;                             
    signal s_seg_o   :  std_logic_vector(7 - 1 downto 0);      
    signal s_dig_o   :  std_logic_vector(4 - 1 downto 0);                                                          

begin
    -- Connecting testbench signals with driver_7seg_4digits entity
    -- (Unit Under Test)
    --- WRITE YOUR CODE HERE
uut_driver_7seg : entity work.driver_7seg_4digits
 port map(
        clk     => s_clk_100MHz,
        reset   => s_reset,
               
        data0_i => s_data0_i,
        data1_i => s_data1_i,
        data2_i => s_data2_i,
        data3_i => s_data3_i,
        dp_i    => s_dp_i,
               
        dp_o    => s_dp_o,
        seg_o   => s_seg_o,
        dig_o   => s_dig_o 
        );
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 10 ns;         
        s_reset <= '1';                 
        wait for 53 ns;         
        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
        p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        s_data3_i <= "0011";
        s_data2_i <= "0001";
        s_data1_i <= "0100";
        s_data0_i <= "0010";
        s_dp_i    <= "0111";
        
        wait for 500 ns;
        s_data3_i <= "0001";
        s_data2_i <= "0010";
        s_data1_i <= "0011";
        s_data0_i <= "0100";
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;
```

### 2.3 Screenshot with simulated time waveforms; always display all inputs and outputs,
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/06-display_driver/image/simulace%201.png" />
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/06-display_driver/image/simulace%202.png" />

### 2.4 Listing of VHDL architecture of the top layer.

``` VHDL

```

## 3.Eight-digit driver. Submit:

### 3.1 Image of the driver schematic. The image can be drawn on a computer or by hand.
