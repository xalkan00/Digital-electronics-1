------------------------------------------------------------------------
-- Library declaration
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for countdown
------------------------------------------------------------------------

entity countdown is
generic(
	g_NPERIOD : unsigned(16-1 downto 0) := x"2710"; 
    g_time_max : unsigned(12-1 downto 0) := x"E0F";
    g_time_min : unsigned(12-1 downto 0) := x"000"
);
port(
	-- Inputs
	clk_i    : 		in  	std_logic;		-- Clock 10 kHz
  	encoder_pb_i: 	in  	std_logic;		-- Push button of encoder (active low)
	encoder_A_i: 	in 		std_logic;
	encoder_B_i: 	in 		std_logic;
    srst_n_i   :    in      std_logic;		-- Synchronous reset (active low) 
    
	-- Outputs
  	current_time_o:	 out	unsigned(12-1 downto 0)
);
end entity countdown;  


------------------------------------------------------------------------
-- Architecture declaration for countdown
------------------------------------------------------------------------
architecture Behavioral of countdown is
    signal s_enc_A	: 		std_logic; -- last value of encoder_A_i
    signal s_enc_B	: 		std_logic; -- last value of encoder_B_i
    signal s_enc_pb	: 		std_logic := '1'; -- last value of encoder_pb_i
    
    signal s_toggled: 		std_logic := '0'; -- 0 set 1 countdown 

	signal s_init_set: 		std_logic := '0'; -- enc_A, enc_b initialized
    signal s_init_cd: 		std_logic := '0'; -- countdown initialize
    
	signal s_cur_time: 		unsigned(12-1 downto 0) := x"03C"; -- 1 min ; signal used when s_toggled ='1'
    														   -- for counting down  	
    signal s_set_time: 		unsigned(12-1 downto 0) := x"03C"; -- 1 min ; signal used when s_toggled ='0'
    														   -- for increments and decrements values from
                                                               -- encoder
                                                               
    signal s_1Hz_enable: 	std_logic := '0'; -- 1Hz signal used for counting down 
    signal s_init_en: 		std_logic := '0'; -- initializing 1 Hz signal
    signal s_cnt : 			unsigned(16-1 downto 0) := x"0000";-- counter for 1 Hz
    
    signal s_cd_end_timer:	unsigned(4-1 downto 0) := x"0"; -- counter when s_cur_time <= x'000'
    														--  more in p_count_down
begin
  
------------------------------------------------------------------------
-- p_toggle:
-- Scans encoder pushbutton for falling edge -> then toggles mode
-- case '0' : mode set
-- case '1' : mode countdown
------------------------------------------------------------------------
	p_toggle : process (clk_i)
	begin
    	if srst_n_i = '0' then -- synchronous reset, active low
        	s_toggled <= '0';
        	s_init_cd <= '0';      	
            s_cur_time <= x"03c";
            s_1Hz_enable <= '0';
            s_init_en <= '0';
            s_cnt <= x"0000";
            s_cd_end_timer <= x"0";
                 
  		elsif rising_edge(clk_i) then -- Rising clock edge
          	if s_enc_pb = '1' and encoder_pb_i = '0' then
            	s_toggled <= not(s_toggled);
    		end if;
  				
  			s_enc_pb <= encoder_pb_i;
  			
-------------------------------------------------------------------------- 
-- p_1Hz_enable:
-- Create 1Hz enable signal from point in time, when s_toggled change from
-- '0' to '1' -- reset by s_toggled = '0'
-------------------------------------------------------------------------- 
            
            if s_toggled = '0' then  		-- reset when mode set is selected
                s_cnt <= (others => '0');   -- Clear all bits
                s_1Hz_enable <= '0';
                s_init_en <= '0';
                s_init_cd <= '0';
                
                
            elsif s_init_en = '1' then
            	if s_cnt >= g_NPERIOD- x"0001" then
                    s_cnt <= (others => '0');
                    s_1Hz_enable <= '1';
                else
                    s_cnt <= s_cnt + x"0001";
                    s_1Hz_enable <= '0';
                end if;
            else
            	s_init_en <= '1';
            end if;
            
-------------------------------------------------------------------------- 
-- p_count_down:
-- When s_toggled is '1' (mode count down) counts down s_cur_time up to 
-- zero, where it stays for 5 sec (5 cycles) before resetting time to 1 min
-- and changing s_toggled to '0' (mode set time)
-------------------------------------------------------------------------- 
            
            if s_toggled = '1' then
            	if s_init_cd = '1' then
                
            		if s_1Hz_enable = '1' then
            			if s_cur_time = x"000" and s_cd_end_timer = x"5" then
                			s_cur_time <= x"03C"; -- 1 min
                    		s_cd_end_timer <= x"0";
                    		s_toggled <= '0'; -- change to mode set
                		elsif s_cur_time = x"000" then
                			s_cd_end_timer <= s_cd_end_timer + x"1";
                		else
                			s_cur_time <= s_cur_time - x"001";
                		end if;
            		end if;
                 else
                 	s_init_cd <= '1';
                    s_cur_time <= s_set_time;
                 end if;   
            end if;    
                       
    	end if;
        
        
	end process p_toggle;

-------------------------------------------------------------------------- 
-- p_set_time:
-- When s_toggled is '0' (mode set) scan encoder inputs A,B for change
-- and increment or decrement s_set_time with overflow
-- s_set_time max = x"E0F" -> 59 min 59 sec
-- s_set_time min = x"0" -> 0 sec
-------------------------------------------------------------------------- 
	p_set_time : process (clk_i)
    begin
    	if srst_n_i = '0' then -- synchronous reset, active low
        	s_set_time <= x"03C";
            s_init_set <= '0';
        
        
        elsif rising_edge(clk_i) and s_toggled = '0' then -- Rising clock edge
         	if s_init_set = '1' then
            
            	if encoder_A_i = '0' and encoder_B_i = '0' then
                
                	if s_enc_A = '0' and s_enc_B = '1' then
                    	if s_set_time = g_time_max then
                        	s_set_time <= x"000";
                        else
                        	s_set_time <= s_set_time + x"001";
                        end if;
                    elsif s_enc_A = '1' and s_enc_B = '0' then
                    	if s_set_time = g_time_min then
                        	s_set_time <= x"E0F";
                        else
                        	s_set_time <= s_set_time - x"001";
                        end if;
                    end if;
                    
                elsif encoder_A_i = '0' and encoder_B_i = '1' then
                	
                    if s_enc_A = '1' and s_enc_B = '1' then
                    	if s_set_time = g_time_max then
                        	s_set_time <= x"000";
                        else
                        	s_set_time <= s_set_time + x"001";
                        end if;
                    elsif s_enc_A = '0' and s_enc_B = '0' then
                    	if s_set_time = g_time_min then
                        	s_set_time <= x"E0F";
                        else
                        	s_set_time <= s_set_time - x"001";
                        end if;
                    end if;
                    
                elsif encoder_A_i = '1' and encoder_B_i = '0' then
                	
                    if s_enc_A = '0' and s_enc_B = '0' then
                    	if s_set_time = g_time_max then
                        	s_set_time <= x"000";
                        else
                        	s_set_time <= s_set_time + x"001";
                        end if;
                    elsif s_enc_A = '1' and s_enc_B = '1' then
                    	if s_set_time = g_time_min then
                        	s_set_time <= x"E0F";
                        else
                        	s_set_time <= s_set_time - x"001";
                        end if;
                    end if;
                    
                elsif encoder_A_i = '1' and encoder_B_i = '1' then
                	
                    if s_enc_A = '1' and s_enc_B = '0' then
                    	if s_set_time = g_time_max then
                        	s_set_time <= x"000";
                        else
                        	s_set_time <= s_set_time + x"001";
                        end if;
                    elsif s_enc_A = '0' and s_enc_B = '1' then
                    	if s_set_time = g_time_min then
                        	s_set_time <= x"E0F";
                        else
                        	s_set_time <= s_set_time - x"001";
                        end if;                   
                    end if;
                    
                end if;
            else
            	s_init_set <='1';

           	end if;
      		
      		s_enc_A <= encoder_A_i;
      		s_enc_B <= encoder_B_i;
            
        end if;
	end process p_set_time;
    
-------------------------------------------------------------------------- 
-- p_update:
-- Assigns the value of current time (s_cur_time) to output current_time_o
-- Assigns the value of current time (s_set_time) to output current_time_o
-------------------------------------------------------------------------- 
    p_update : process (clk_i)
    begin
    	if srst_n_i = '0' then -- synchronous reset, active low
        	current_time_o <= x"03C";
        
    	elsif rising_edge(clk_i) then -- Rising clock edge
        	if s_toggled = '1' and s_init_cd = '1' then
            	
        		current_time_o <= s_cur_time;
            else 
            	current_time_o <= s_set_time;
                
            end if;     
        end if; 
    end process p_update;
    
end architecture Behavioral;