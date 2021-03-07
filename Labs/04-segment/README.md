# 01-segment
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)
## 1) Preparation tasks (done before the lab at home). Submit:

#### 1.1 Figure or table with connection of 7-segment displays on Nexys A7 board,


#### 1.2 - Decoder truth table for common anode 7-segment display.

| **Hex** | **Input** | **a** | **b** | **c** | **d** | **e** | **f** | **g** |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| 1 | 0001 | 1 | 0 | 0 | 1 | 1 | 1 | 1 |
| 2 | 0010 | 0 | 0 | 1 | 0 | 0 | 1 | 0 |
| 3 | 0011 | 0 | 0 | 0 | 0 | 1 | 1 | 0 |
| 4 | 0100 | 1 | 0 | 0 | 1 | 1 | 0 | 0 |
| 5 | 0101 | 0 | 1 | 0 | 0 | 1 | 0 | 0 |
| 6 | 0110 | 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 7 | 0111 | 0 | 0 | 0 | 1 | 1 | 1 | 0 |
| 8 | 1000 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 9 | 1001 | 0 | 0 | 0 | 1 | 1 | 0 | 0 |
| A | 1010 | 0 | 0 | 0 | 1 | 0 | 0 | 0 |
| b | 1011 | 1 | 1 | 0 | 0 | 0 | 0 | 0 |
| C | 1100 | 0 | 1 | 1 | 0 | 0 | 0 | 1 |
| d | 1101 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
| E | 1110 | 0 | 1 | 1 | 0 | 0 | 0 | 0 |
| F | 1111 | 0 | 1 | 1 | 1 | 0 | 0 | 0 |

## 2) Seven-segment display decoder. Submit:

 #### 2.1 - Listing of VHDL architecture from source file hex_7seg.vhd with syntax highlighting.
 
``` VHDL
architecture Behavioral of hex_7seg is

begin
    --------------------------------------------------------------------
    --         a
    --       -----          a: seg_o(6)
    --    f |     | b       b: seg_o(5)
    --      |  g  |         c: seg_o(4)
    --       -----          d: seg_o(3)
    --    e |     | c       e: seg_o(2)
    --      |     |         f: seg_o(1)
    --       -----          g: seg_o(0)
    --         d
    --------------------------------------------------------------------
   p_7seg_decoder : process(hex_i)
    begin
        case hex_i is
            when "0000" =>
                seg_o <= "0000001";     -- 0
            when "0001" =>
                seg_o <= "1001111";     -- 1
            when "0010" =>
                seg_o <= "0010010";     -- 2
            when "0011" =>
                seg_o <= "0000110";     -- 3
            when "0100" =>
                seg_o <= "1001100";     -- 4
            when "0101" =>
                seg_o <= "0100100";     -- 5
            when "0110" =>
                seg_o <= "0100000";     -- 6
            when "0111" =>
                seg_o <= "0001110";     -- 7
            when "1000" =>
                seg_o <= "0000000";     -- 8
            when "1001" =>
                seg_o <= "0001100";     -- 9
            when "1010" =>
                seg_o <= "0001000";     -- A
            when "1011" =>
                seg_o <= "1100000";     -- B
            when "1100" =>
                seg_o <= "0110001";     -- C
            when "1101" =>
                seg_o <= "1000010";     -- D                                                             
            when "1110" =>
                seg_o <= "0110000";     -- E
            when others =>
                seg_o <= "0111000";     -- F
        end case;
    end process p_7seg_decoder;
                                    


end Behavioral;
```
 
 #### 2.2 - Listing of VHDL stimulus process from testbench file tb_hex_7seg.vhd with syntax highlighting.
 
 ``` VHDL
     p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;

        s_hex <= "0000";  wait for 100 ns; 
        s_hex <= "0001";  wait for 100 ns;
        s_hex <= "0010";  wait for 100 ns;
        s_hex <= "0011";  wait for 100 ns;
        s_hex <= "0100";  wait for 100 ns;
        s_hex <= "0101";  wait for 100 ns;
        s_hex <= "0110";  wait for 100 ns;
        s_hex <= "0111";  wait for 100 ns;
        s_hex <= "1000";  wait for 100 ns;
        s_hex <= "1001";  wait for 100 ns;
        s_hex <= "1010";  wait for 100 ns;
        s_hex <= "1011";  wait for 100 ns;
        s_hex <= "1100";  wait for 100 ns;       
        s_hex <= "1101";  wait for 100 ns;
        s_hex <= "1110";  wait for 100 ns;
        s_hex <= "1111";  wait for 100 ns;
        
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```
 #### 2.3 - Screenshot with simulated time waveforms; always display all inputs and outputs.
 
 <img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/04-segment/image/Snímek%20obrazovky%202021-03-03%20210440.png" />
 
 #### 2.4 - Listing of VHDL code from source file top.vhd with 7-segment module instantiation.
 
 ``` VHDL
 hex2seg : entity work.hex_7seg

    port map(
    
          hex_i => SW,    
          seg_o(6) => CA,
          seg_o(5) => CB,
          seg_o(4) => CC,
          seg_o(3) => CD,
          seg_o(2) => CE,
          seg_o(1) => CF,
          seg_o(0) => CG
           
    );
    
 ```
 

## 3) LED(7:4) indicators. Submit:

#### 3.1 - Truth table and listing of VHDL code for LEDs(7:4) with syntax highlighting,


| **Hex** | **Inputs** | **LED4** | **LED5** | **LED6** | **LED7** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0000 | 1 | 0 | 0 | 0 |
| 1 | 0001 | 0 | 0 | 1 | 1 |
| 2 | 0010 | 0 | 0 | 0 | 1 |
| 3 | 0011 | 0 | 0 | 1 | 0 |
| 4 | 0100 | 0 | 0 | 0 | 1 |
| 5 | 0101 | 0 | 0 | 1 | 0 |
| 6 | 0110 | 0 | 0 | 0 | 0 |
| 7 | 0111 | 0 | 0 | 1 | 0 |
| 8 | 1000 | 0 | 0 | 0 | 1 |
| 9 | 1001 | 0 | 0 | 1 | 0 |
| A | 1010 | 0 | 1 | 0 | 0 |
| b | 1011 | 0 | 1 | 1 | 0 |
| C | 1100 | 0 | 1 | 0 | 0 |
| d | 1101 | 0 | 1 | 1 | 0 |
| E | 1110 | 0 | 1 | 0 | 0 |
| F | 1111 | 0 | 1 | 1 | 0 |


Turn LED(4) on if input value is equal to 0, ie "0000"
 ``` VHDL
 LED(4) <= not SW(3) and not SW(2) and not SW(1) and not SW(0); 
 
 -- nebo  LED(4)  <= '1' when (SW = "0000") else '0';
    
 ```
Turn LED(5) on if input value is greater than 9

 ``` VHDL
 LED(5) <= 
   '1' when SW = "1010" else  --a      
   '1' when SW = "1011" else  --b
   '1' when SW = "1100" else  --c
   '1' when SW = "1101" else  --d
   '1' when SW = "1110" else  --e
   '1' when SW = "1111" else  --f		
   '0';
        
-- nebo  LED(5)  <= '1' when (SW > "1001") else '0';
 ```
Turn LED(6) on if input value is odd, ie 1, 3, 5, ...

 ``` VHDL 
 LED(6) <=
   '1' when SW = "0001" else    --1		
   '1' when SW = "0011" else    --3			
   '1' when SW = "0101" else    --5			
   '1' when SW = "0111" else    --7			
   '1' when SW = "1001" else    --9
   '1' when SW = "1011" else    --B
   '1' when SW = "1101" else    --D
   '1' when SW = "1111" else    --F
   '0';   
 ```  
Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8

 ``` VHDL
 LED(7) <=
   '1' when (SW = "0001") else  --1
   '1' when (SW = "0010") else  --2
   '1' when (SW = "0100") else	--4
   '1' when (SW = "1000") else	--8			  
   '0';   
 ```

#### 3.2 - Screenshot with simulated time waveforms; always display all inputs and outputs.

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/04-segment/image/Simulace%20LED.png" />

