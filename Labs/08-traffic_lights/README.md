# 08-traffic_lights
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)

## 1- Preparation tasks (done before the lab at home). Submit:

### 1.1 Completed state table,

| **Input P** | `0` | `0` | `1` | `1` | `0` | `1` | `0` | `1` | `1` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| :-- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **Clock** | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) | ![rising](Image/eq_uparrow.png) |
| **State** | A | A | B | C | C | D | A | B | C | D | B | B | B | C | D | B |
| **Output R** | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `1` | `0` |

### 1.2 Figure with connection of RGB LEDs on Nexys A7 board and completed table with color settings.

| **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |


## 2-Traffic light controller. Submit:
### 2.1 State diagram,
<img src="   " />

### 2.2 Listing of VHDL code of sequential process p_traffic_fsm with syntax highlighting,
``` VHDL
p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then

                case s_state is


                    when STOP1 =>
                       
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else                           
                            s_state <= WEST_GO;                           
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_GO =>

                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else                          
                            s_state <= WEST_WAIT;                          
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_WAIT =>

                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else                           
                            s_state <= STOP2;                           
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when STOP2 =>

                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else                           
                            s_state <= SOUTH_GO;                           
                            s_cnt   <= c_ZERO;
                        end if;

                    when SOUTH_GO =>

                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else                            
                            s_state <= SOUTH_WAIT;                           
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when SOUTH_WAIT =>

                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else                          
                            s_state <= STOP1;                           
                            s_cnt   <= c_ZERO;
                        end if;                        
                                                                                             
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_traffic_fsm;
```
### 2.3 Listing of VHDL code of combinatorial process p_output_fsm with syntax highlighting,
``` VHDL
p_output_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>
                 south_o <= "100";   -- Red (RGB = 100)
                 west_o  <= "100";   -- Red (RGB = 100)
                 
            when WEST_GO =>
                 south_o <= "100";   -- Red (RGB = 100)
                 west_o  <= "010";   -- Green (RGB = 010)
                                  
            when WEST_WAIT =>
                 south_o <= "100";   -- Red (RGB = 100)
                 west_o  <= "110";   -- Yellow (RGB = 110)
                 
            when STOP2 =>
                 south_o <= "100";   -- Red (RGB = 100)
                 west_o  <= "100";   -- Red (RGB = 100)
                 
            when SOUTH_GO =>
                 south_o <= "010";   -- Green (RGB = 010)
                 west_o  <= "100";   -- Red (RGB = 100)
                 
            when SOUTH_WAIT =>
                 south_o <= "110";   -- Yellow (RGB = 110)
                 west_o  <= "100";   -- Red (RGB = 100)
                                
            when others =>
                south_o <= "100";   -- Red
                west_o  <= "100";   -- Red
        end case;
    end process p_output_fsm;
```
### 2.4 Screenshot(s) of the simulation, from which it is clear that controller works correctly.

<img src="   " />

## 3-Smart controller. Submit:

### 3.1 State table,

| **  state ** | No cars <br />west, east <br /> 00  | Cars to west<br />west, east  <br /> 10 | Cars to east<br />west, east  <br /> 01 | Cars to both<br />west, east <br /> 11 |
| :-- | :-: | :-: | :-: | :-: |
| **`STOP1`**  | `WEST_GO` | `WEST_GO` | `SOUTH_GO` | `WEST_GO` |
| **`WEST_GO`** | `WEST_WAIT` | ``WEST_GO`` | `WEST_WAIT` | ``WEST_GO`` |
| **`WEST_WAIT`** | ``STOP2`` | `STOP2` | ``STOP2`` | ``STOP2`` |
| **`STOP2`**  | `SOUTH_GO` | `WEST_GO` | `SOUTH_GO` | ``SOUTH_GO`` |
| **`SOUTH_GO`** | `SOUTH_WAIT` | `SOUTH_WAIT` | `SOUTH_GO` | ```SOUTH_GO``` |
| **`SOUTH_WAIT`** | `STOP1` | `STOP1` | `STOP1` | ``STOP1`` |

### 3.2 State diagram,

<img src="   " />

### 3.3 Listing of VHDL code of sequential process p_smart_traffic_fsm with syntax highlighting.

``` VHDL

```

