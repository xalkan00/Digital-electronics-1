# 05-counter
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)

## 1.Preparation tasks (done before the lab at home). Submit:

### 1.1 Figure or table with connection of push buttons on Nexys A7 board,
### 1.2 Table with calculated values.

   | **Time interval** | **Number of clk periods** | **Number of clk periods in hex** | **Number of clk periods in binary** |
   | :-: | :-: | :-: | :-: |
   | 2&nbsp;ms | 200 000 | 0x3 0d40 | 0b 0011 0000 1101 0100 0000 |
   | 4&nbsp;ms | 400 000 | 0x6 1a80 | 0b 0110 0001 1010 1000 0000 |
   | 10&nbsp;ms | 1 000 000 | 0xf 4240 | 0b 1111 0100 0010 0100 0000 |
   | 250&nbsp;ms | 25 000 000 | 0x17D 7840 | 0b 0001 0111 1101 0111 1000 0100 0000 |
   | 500&nbsp;ms | 50 000 000 | 0x2FA F080 | 0b 0010 1111 1010 1111 0000 1000 0000 |
   | 1&nbsp;sec | 100 000 000 | 0x5F5 E100 | 0b 0101 1111 0101 1110 0001 0000 0000 |


## 2.Bidirectional counter. Submit:

### 2.1 Listing of VHDL code of the process p_cnt_up_down with syntax highlighting.

``` VHDL
    p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then
        
            if (reset = '1') then               -- Synchronous reset
                s_cnt_local <= (others => '0'); -- Clear all bits

            elsif (en_i = '1') then       -- Test if counter is enabled


                -- TEST COUNTER DIRECTION HERE
                    if (cnt_up_i = '1') then
        
                        s_cnt_local <= s_cnt_local + 1;
                    else
                    
                       s_cnt_local <= s_cnt_local - 1;
               
                    end if; 
            end if;
        end if;
    end process p_cnt_up_down;
 ```
   
  
### 2.2 Listing of VHDL reset and stimulus processes from testbench file tb_cnt_up_down.vhd with syntax highlighting and asserts,

```   VHDL
 p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 12 ns;         -- v 12 ns přepne na 1
        s_reset <= '1';                 -- Reset activated
        wait for 73 ns;         -- za 73 ns od 12 ns  přepne na 0
        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        s_en     <= '1';                -- Enable counting
        s_cnt_up <= '1';
        wait for 380 ns;                -- v 380 ns s_cnt_up konči a za 220 ns od 380 konči s_en
        s_cnt_up <= '0';
        wait for 220 ns;
        s_en     <= '0';                -- Disable counting

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
 ```
### 2.3 Screenshot with simulated time waveforms; always display all inputs and outputs,


## 3.Top level. Submit:
``` VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
  Port ( 
    CLK100MHZ : in std_logic;
    BTNC      : in std_logic;
    SW        : in std_logic_vector(1-1 downto 0);
    LED       : out std_logic_vector(4-1 downto 0);
    AN        : out std_logic_vector(8-1 downto 0);
    CA        : out std_logic;
    CB        : out std_logic;
    CC        : out std_logic;
    CD        : out std_logic;
    CE        : out std_logic;
    CF        : out std_logic;
    CG        : out std_logic

  );
end top;

architecture Behavioral of top is      -- vnit?ni signaly v tobu
    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal counter
    signal s_cnt : std_logic_vector(4 - 1 downto 0);
begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 100000000
        )
        port map(
            clk   => CLK100MHZ,
            reset => BTNC,
            ce_o  => s_en          
        );

    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 4
        )
        port map(
        clk   => CLK100MHZ,   
        reset => BTNC,  
        en_i  => s_en,   
        cnt_up_i  => sw(0),
        cnt_o    => s_cnt
        );

    -- Display input value on LEDs
    LED(3 downto 0) <= s_cnt;

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => s_cnt,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    -- Connect one common anode to 3.3V
    AN <= b"1111_1110";

end Behavioral;
```

### 3.1 Listing of VHDL code from source file top.vhd with all instantiations for the 4-bit bidirectional counter.
### 3.2 (Hand-drawn) sketch of the top layer including both counters, ie a 4-bit bidirectional counter from Part 4 and a 16-bit counter with a different time base from Part Experiments on your own.
