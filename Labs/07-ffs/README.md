# 07-ffs
[xalkan00-Digital-electronics-1](https://github.com/xalkan00/Digital-electronics-1)

## 1- Preparation tasks (done before the lab at home). Submit:
### 1.1 Characteristic equations and completed tables for D, JK, T flip-flops.
 <img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/07-ffs/Image/D_ff.png" />
 
   | **D** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | No change |
   | 0 | 1 | 0 | Reset |
   | 1 | 0 | 0 | Reset |
   | 1 | 1 | 1 | Set |

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/07-ffs/Image/JK_ff.png" />

   | **J** | **K** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | 0 | No change |
   | 0 | 0 | 1 | 1 | No change |
   | 0 | 1 | 0 | 0 | Reset |
   | 0 | 1 | 1 | 0 | Reset |
   | 1 | 0 | 0 | 1 | Set |
   | 1 | 0 | 1 | 1 | Set |
   | 1 | 1 | 0 | 1 | Toggle |
   | 1 | 1 | 1 | 0 | Toggle |

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/07-ffs/Image/T_ff.png" />

   | **T** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | No change |
   | 0 | 1 | 1 | No change |
   | 1 | 0 | 1 | Toggle |
   | 1 | 1 | 0 | Toggle  |


## 2- D latch. Submit:

### 2.1 VHDL code listing of the process p_d_latch with syntax highlighting,
``` VHDL
p_d_latch : process (d, arst, en)
begin
    if (arst  = '1') then
        q     <= '0';
        q_bar <= '1';
        
    elsif (en = '1') then
       q     <= d;
       q_bar <= not d;
       
    end if;
end process p_d_latch;
```
### 2.2 Listing of VHDL reset and stimulus processes from the testbench tb_d_latch.vhd file with syntax highlighting and asserts,
``` VHDL
p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 50 ns;
                 
        s_arst <= '1';                      
        wait for 10 ns; 
                
        s_arst <= '0';
        
        wait for 200 ns;
        
        s_arst <= '1';
        wait;
    end process p_reset_gen;


   p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_en <= '0';       
        s_d  <= '0'; 
       
        wait for 10 ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 1" severity note; 
        s_d  <= '1';
        wait for 10 ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 2" severity note; 
        s_d  <= '0';
        wait for 10 ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 3" severity note; 
        s_d  <= '1';
        wait for 10 ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 4" severity note; 
        s_d  <= '0';
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;
 -----------------------------------     
        s_en <= '1';
        
        wait for 10 ns;
         assert (s_q = '1' and s_q_bar = '0') report "Error 5" severity note;
        s_d  <= '1';
        wait for 10 ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 6" severity note;
        s_d  <= '0';
        wait for 10 ns;
         assert (s_q = '1' and s_q_bar = '0') report "Error 7" severity note;
        s_d  <= '1';
        wait for 10 ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 8" severity note;
        s_d  <= '0';
        wait for 10 ns;
         assert (s_q = '1' and s_q_bar = '0') report "Error 9" severity note;
        s_d  <= '1';
        wait for 10 ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 10" severity note;
        s_d  <= '0';
        wait for 10 ns;
         assert (s_q = '1' and s_q_bar = '0') report "Error 11" severity note;
  -------------------------------------      
        s_en <= '0';
          
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;

  ---------------------------
        s_en <= '1';      
        
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;


        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;  
```
### 2.3 Screenshot with simulated time waveforms; always display all inputs and outputs. The full functionality of the entity must be verified.

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/07-ffs/Image/D-Latch.png" />

## 3- Flip-flops. Submit:

### 3.1 VHDL code listing of the processes p_d_ff_arst, p_d_ff_rst, p_jk_ff_rst, p_t_ff_rst with syntax highlighting,
proces p_d_ff_arst
``` VHDL
p_d_ff_arst : process (clk, arst)
begin
    if (arst  = '1') then
        q     <= '0';
        q_bar <= '1';
        
    elsif rising_edge(clk) then
       q     <= d;
       q_bar <= not d;
       
    end if;
end process p_d_ff_arst;

```
proces p_d_ff_rst
``` VHDL
p_d_ff_rst :  process (clk)

    begin
       if rising_edge (clk) then
          if(rst = '1') then 
             s_q     <= '0';
             s_q_bar <= '1'; 
           else
             s_q     <= d;    
             s_q_bar <= not d;
   
          end if;
       end if;
    end process p_d_ff_rst;
     
             q     <= s_q;
             q_bar <= s_q_bar;

```
proces p_jk_ff_rst
``` VHDL
p_jk_ff_rst : process(clk)
    
    begin
        if rising_edge(clk) then
            if (rst= '1') then
            s_q <= '0';
            else
                if(j='0' and k='0') then
                  s_q <= s_q;
                elsif (j='0' and k='1') then
                  s_q <= '0';
                elsif (j='1' and k='0') then
                  s_q <= '1';
                elsif (j='1' and k='1') then
                  s_q <= not s_q;
                end if;
            end if;
         end if;
     end process  p_jk_ff_rst;

```
proces p_t_ff_rst
``` VHDL
p_t_ff_rst :process (clk)
     
    begin 
     if rising_edge (clk) then
         if(rst = '1') then 
                 s_q     <= '0';
                 s_q_bar <= '1'; 
           else
             if (t = '0') then
                 s_q     <= s_q;
                 s_q_bar <= s_q_bar;
             else 
                 s_q     <= not s_q;
                 s_q_bar <= not s_q_bar;
             end if;
          end if;
     end if;
   
      end process  p_t_ff_rst ;
      
            q     <= s_q;
            q_bar <= s_q_bar;

```

### 3.2 Listing of VHDL clock, reset and stimulus processes from the testbench files with syntax highlighting and asserts,

``` VHDL
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
```   

#### reset and stimulus processes  tb_d_ff_arst
``` VHDL
     p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 50 ns;
        
        s_arst <= '1';                 
        wait for 30 ns;
        
        s_arst <= '0';

        wait;
    end process p_reset_gen;
    
     p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started." severity note;
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 1" severity note;
        
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 2" severity note;
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 3" severity note;
       
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 4" severity note;
              
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 5" severity note;
        
              
        ------------------------- Reset activated --------------------------
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 7" severity note;
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 8" severity note;
        
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 9" severity note;
       
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 10" severity note;
              
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 11" severity note;
        
         s_d    <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 12" severity note;
        
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 13" severity note;
        
        ------------------------- Reset deactivated --------------------------
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 14" severity note;
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 15" severity note;
       
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 16" severity note;        
       
        
        report "Stimulus process ended." severity note;
        wait;
    end process p_stimulus;

```
#### reset and stimulus processes  tb_d_ff_rst
``` VHDL
 p_reset_gen : process
  
    begin
        s_rst <= '0';                 
        wait for 50 ns;
        
        s_rst <= '1';                 
        wait for 60 ns;
        
        s_rst <= '0';
                 
        wait;
  end process p_reset_gen;
  
  p_stimulus : process
   
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started." severity note;
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 1" severity note;
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 2" severity note;
        
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 3" severity note;
       
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 4" severity note;
           
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 5" severity note;
        
        
        ----------------------  Reset activated  -------------------------
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 7" severity note;
        
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 8" severity note;
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 9" severity note;
       
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 10" severity note;
           
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 11" severity note;
        
         s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 12" severity note;

      
        ----------------------------  Reset deactivated  --------------------------
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 14" severity note;
        
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 15" severity note;
       
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 16" severity note;
           
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 17" severity note;
        
         s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 18" severity note;
                    
        report "Stimulus process ended." severity note;
        wait;
   end process p_stimulus;
```

#### reset and stimulus processes tb_jk_ff_rst
``` VHDL
    p_reset_gen : process
    begin
        s_rst <= '0';                 
        wait for 60 ns;
        s_rst <= '1';                 
        wait for 20 ns;
        s_rst <= '0';                 
        wait;
    end process p_reset_gen;
    
     p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started." severity note;
        wait for 10 ns;
        s_j     <=  '0';
        s_k     <=  '0';
        wait for 10ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 1" severity note;
        s_j     <=  '0';
        s_k     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 2" severity note;
        s_j     <=  '1';
        s_k     <=  '0';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 3" severity note;
        s_j     <=  '1';
        s_k     <=  '1';
        wait for 20ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 4" severity note;
        
        s_j     <=  '0';
        s_k     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 5" severity note;
        s_j     <=  '1';
        s_k     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 6" severity note;
               
        report "Stimulus process ended." severity note;
        wait;
    end process p_stimulus;
```
#### reset and stimulus processes tb_t_ff_rst
``` VHDL
       p_reset_gen : process
  
    begin
        s_rst <= '0';                 
        wait for 40 ns;
        s_rst <= '1';                 
        wait for 50 ns;
        s_rst <= '0';                 
        wait;
  end process p_reset_gen;
       
       p_stimulus : process
   
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started." severity note;
       s_t     <=  '0';
        wait for 10ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 1" severity note;
        
        s_t     <=  '1';
        wait for 10ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 2" severity note;
        
        s_t     <=  '0';
        wait for 10ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 3" severity note;
       
        s_t     <=  '1';
        wait for 10ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 4" severity note;
           
       
        ----------------------  Reset activated  -------------------------
        
        s_t     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 7" severity note;
        
        s_t     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 8" severity note;
        
        s_t     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 9" severity note;
       
        s_t     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 10" severity note;
           
        s_t     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 11" severity note;
        
        
        ----------------------------  Reset deactivated  --------------------------
        
        s_t     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 14" severity note;
        
        s_t     <=  '0';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 15" severity note;
       
        s_t     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 16" severity note;
           
        s_t     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 17" severity note;
     
        report "Stimulus process ended." severity note;
        wait;
   end process p_stimulus;

```
### 3.3 Screenshot with simulated time waveforms; always display all inputs and outputs. The full functionality of the entities must be verified.

tb_d_ff_arst
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/07-ffs/Image/arst.png" />

tb_d_ff_rst
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/07-ffs/Image/rst.png" />

tb_jk_ff_rst
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/07-ffs/Image/jk.png" />

tb_t_ff_rst
<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/07-ffs/Image/t.png" />

## 4- Shift register. Submit:

### 4.1 Image of the shift register schematic. The image can be drawn on a computer or by hand. Name all inputs, outputs, components and internal signals.

<img src="https://github.com/xalkan00/Digital-electronics-1/blob/main/Labs/07-ffs/Image/tgjjj.png" />
