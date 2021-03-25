------------------------------------------------------------------------
-- Library declaration
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for commander
------------------------------------------------------------------------

entity commander is
generic(
	g_command1: unsigned(8-1 downto 0) := "01000000";
    g_command2: unsigned(8-1 downto 0) := "11000000";
    g_command3: unsigned(8-1 downto 0) := "10001101"
);
port(
	-- Inputs
	clk_i  	: 	in 	std_logic;		-- Clock 10 kHz
    srst_n_i:	in	std_logic;		-- Synchronous reset (active low)
  	current_time_i:	 in	unsigned(12-1 downto 0);
	-- Outputs
  	CLK_o	:	out std_logic := '1';
    DIO_o	:	out std_logic := '1'
);
end entity commander;


------------------------------------------------------------------------
-- Architecture declaration for commander
------------------------------------------------------------------------
architecture Behavioral of commander is
	-- signal with the last 
    signal s_last_time	:	unsigned(12-1 downto 0) := x"000";
    
    -- signal representing output CLK_o
    signal s_CLK		:	std_logic := '1';
    
    -- signal representing output DIO_o
    signal s_DIO		:	std_logic := '1';
    
    -- activate command sequence
    signal s_activated	:	std_logic := '0';
    
    -- counter for the whole command sequence
    signal s_counter	: 	unsigned(8-1 downto 0) := x"00";
    
    -- counter for inner segments of command sequence
    signal s_cnt_inner	: 	unsigned(5-1 downto 0) := "00000";
    
    -- Numbers that are supposed to be displayed on corresponding grids
    signal s_num1		:	unsigned(12-1 downto 0) := x"000";
    signal s_num2		:	unsigned(12-1 downto 0) := x"000";
    signal s_num3		:	unsigned(12-1 downto 0) := x"000";
    signal s_num4		:	unsigned(12-1 downto 0) := x"000";
    
    -- 7 segment display data with decimal point for corresponding grids
    signal s_grid1		:	unsigned(8-1 downto 0) := x"00";
    signal s_grid2		:	unsigned(8-1 downto 0) := x"00";
    signal s_grid3		: 	unsigned(8-1 downto 0) := x"00";
    signal s_grid4		:	unsigned(8-1 downto 0) := x"00";
    

    
begin
  
------------------------------------------------------------------------
-- p_activate_command:
-- Compares last value of time (s_last_time) with current time of input
-- current_time_i. If they differ, set s_activate_command to '1', thus 
-- starting the command creation and stopping the comparison of input.
------------------------------------------------------------------------
	p_activate_command: process (clk_i)
	begin
  		if rising_edge(clk_i) then --and s_activated = '0' then -- Rising clock edge
        	if srst_n_i = '0' then -- Synchronous reset	
            	
				s_last_time	<= x"000";
 				s_activated <= '0';    
				s_counter <= x"00";   
				s_num1 <= x"000";
				s_num2 <= x"000";
				s_num3 <= x"000";
				s_num4 <= x"000";    
				s_grid1 <= x"00";
				s_grid2 <= x"00";
				s_grid3 <= x"00";
				s_grid4 <= x"00";
                
            elsif  s_activated = '0' then       	
            	if (s_last_time = current_time_i) then 
            	else	-- s_last_time is not current_time_i
                	s_activated <= '1';
                
                	-- time mod 10 = # of seconds
                	s_num1 <= current_time_i mod x"00A";
                
                	-- ((time mod 60) - # of seconds) / 10 = # of tens of seconds
                	s_num2 <= (current_time_i mod x"03C" - current_time_i mod x"00A")/x"00A";
                
                	-- ((time mod 600) - (time mod 60)) / 60 = # of minutes
                	s_num3 <= (current_time_i mod x"258" - current_time_i mod x"03C")/x"03C";
                
                	-- (time - (time mod 600)) / 600 = # of tens of minutes
                	s_num4 <= (current_time_i - current_time_i mod x"258")/x"258";
                
           		end if;
            
            	s_last_time <= current_time_i;

------------------------------------------------------------------------
-- command_counter:
-- after activation increments s_counter till the end of 
-- the sequence (x"CB"); after that it sets s_activated to zero
-- and resets the counter
-- the counter directly dictates the sequences of DIO_o and CLK_o
------------------------------------------------------------------------

       		elsif s_activated = '1' then
				if s_counter >= x"CB" then
            
            	
                	s_counter <= x"00";
                	s_activated <= '0';
                
            	elsif s_counter = x"00" then
            		
                
            		s_grid1 <= 	"11000000" when (s_num1 = x"000") else
                				"11111001" when (s_num1 = x"001") else
                            	"10100100" when (s_num1 = x"002") else
                            	"10110000" when (s_num1 = x"003") else
                            	"10011001" when (s_num1 = x"004") else
                            	"10010010" when (s_num1 = x"005") else
                            	"10000010" when (s_num1 = x"006") else
                            	"11111000" when (s_num1 = x"007") else
                            	"10000000" when (s_num1 = x"008") else
                            	"10010000";
                                                   
              		s_grid2 <= 	"11000000" when (s_num2 = x"000") else
                				"11111001" when (s_num2 = x"001") else
                            	"10100100" when (s_num2 = x"002") else
                            	"10110000" when (s_num2 = x"003") else
                            	"10011001" when (s_num2 = x"004") else
                            	"10010010" when (s_num2 = x"005") else
                            	"10000010" when (s_num2 = x"006") else
                            	"11111000" when (s_num2 = x"007") else
                            	"10000000" when (s_num2 = x"008") else
                            	"10010000";
                            
               		s_grid3 <= 	"11000000" when (s_num3 = x"000") else
                				"11111001" when (s_num3 = x"001") else
                            	"10100100" when (s_num3 = x"002") else
                            	"10110000" when (s_num3 = x"003") else
                            	"10011001" when (s_num3 = x"004") else
                            	"10010010" when (s_num3 = x"005") else
                            	"10000010" when (s_num3 = x"006") else
                            	"11111000" when (s_num3 = x"007") else
                            	"10000000" when (s_num3 = x"008") else
                            	"10010000";
              
              		s_grid4 <= 	"11000000" when (s_num4 = x"000") else
                				"11111001" when (s_num4 = x"001") else
                            	"10100100" when (s_num4 = x"002") else
                            	"10110000" when (s_num4 = x"003") else
                            	"10011001" when (s_num4 = x"004") else
                            	"10010010" when (s_num4 = x"005") else
                            	"10000010" when (s_num4 = x"006") else
                            	"11111000" when (s_num4 = x"007") else
                            	"10000000" when (s_num4 = x"008") else
                            	"10010000";
                            
                	s_counter <= s_counter + x"01";
           		else
            		s_counter <= s_counter + x"01";
           		end if; 
           	end if;
    	end if;
	end process p_activate_command;  
    

    
------------------------------------------------------------------------
-- p_create-clk:
-- Creates sequence of output CLK
-- The overall sequence is:
-- START - COMMAND 1 - END - START - COMMAND 2 - DATA 1~4 - END -
-- START - COMMAND 3 - END
-- for commands and data it creates a square wave with duty cycle 1/3
------------------------------------------------------------------------
	
 	p_create_clk : process (clk_i)
	begin
  		if rising_edge(clk_i) and s_activated = '1' then -- Rising clock edge
        	if srst_n_i = '0' then -- Synchronous reset	
            	s_CLK <= '1';
				s_cnt_inner	<= "00000";
            else
            	if (s_counter >= x"01") and (s_counter < x"1F") then
            		-- starting one clock earlier due to mod
            		-- vytváří 001001001001... spravne
                
            		if (s_cnt_inner mod "00011") = "00000" then -- mod 3 = 0
            			s_CLK <= '0';
              			s_cnt_inner <= s_cnt_inner + "00001";
            		elsif (s_cnt_inner mod "00011") = "00001" then -- mod 3 = 1
            			s_CLK <= '0';
              			s_cnt_inner <= s_cnt_inner + "00001";
            		else -- (s_cnt_inner mod 3) = 2
            			s_CLK <= '1';
              			s_cnt_inner <= s_cnt_inner + "00001";
            		end if;
            		if s_cnt_inner = "11101" then -- (30) reset inner counter on end of sequence
            			s_cnt_inner <= "00000";

            		end if;
                
         		elsif (s_counter = x"1F") then
            	
                	s_CLK <= '1';
        		                
          		elsif (s_counter >= x"21") and (s_counter < x"AB") then
        	
        			-- vytváří 001001001001... spravne
            		if (s_cnt_inner mod "00011") = "00000" then -- mod 3 = 0
            			s_CLK <= '0';
              			s_cnt_inner <= s_cnt_inner + "00001";
            		elsif (s_cnt_inner mod "00011") = "00001" then -- mod 3 = 1
            			s_CLK <= '0';
              			s_cnt_inner <= s_cnt_inner + "00001";
            		else -- (s_cnt_inner mod 3) = 2
            			s_CLK <= '1';
              			s_cnt_inner <= s_cnt_inner + "00001";
            		end if;
               		if s_cnt_inner = "11110" then
                		s_cnt_inner <= "00001";
                	end if;
            		if s_counter = x"AA" then -- (27) reset inner counter on end of sequence
            			s_cnt_inner <= "00000";
            		end if;
            
            	elsif (s_counter = x"AB") then
                	s_CLK <= '1';
           	
            	elsif (s_counter >= x"AD") and (s_counter < x"CB") then
            	
                
            		if (s_cnt_inner mod "00011") = "00000" then -- mod 3 = 0
            			s_CLK <= '0';
              			s_cnt_inner <= s_cnt_inner + "00001";
            		elsif (s_cnt_inner mod "00011") = "00001" then -- mod 3 = 1
            			s_CLK <= '0';
              			s_cnt_inner <= s_cnt_inner + "00001";
            		else -- (s_cnt_inner mod 3) = 2
            			s_CLK <= '1';
              			s_cnt_inner <= s_cnt_inner + "00001";
            		end if;
            		if s_cnt_inner = "11101" then -- (30) reset inner counter on end of sequence
            			s_cnt_inner <= "00000";

            		end if;
                
            	else -- s_counter = CB
            		s_CLK <= '1';
          		end if;
        	end if;
    	end if;
	end process p_create_clk; 
           
------------------------------------------------------------------------
-- p_create-command:
-- Creates sequence of output DIO
-- The overall sequence is:
-- START - COMMAND 1 - END - START - COMMAND 2 - DATA 1~4 - END -
-- START - COMMAND 3 - END
-- command 1 sets the TM1637 into auto adress increment mode
-- command 2 sets starter adress
-- data 1~4 are the values from s_grid1~4
-- command 3 sets the display to on with set pulsewidth 12/16
------------------------------------------------------------------------
	
	p_create_command : process (clk_i)
	begin
  		if rising_edge(clk_i) and s_activated = '1' then -- Rising clock edge
        	if srst_n_i = '0' then -- Synchronous reset	
            	s_DIO <= '0';
            else
       
      			if s_counter = x"00" then 
            		-- START
                
            		s_DIO <= '0';
                
        		elsif (s_counter >= x"01") and (s_counter < x"1F") then
            		-- COMMAND 1
                
                	case s_counter is
                		when x"01"+x"01" => s_DIO <= g_command1(0);
                   		when x"01"+x"04" => s_DIO <= g_command1(1);
                    	when x"01"+x"07" => s_DIO <= g_command1(2);
                    	when x"01"+x"0A" => s_DIO <= g_command1(3);
                    	when x"01"+x"0D" => s_DIO <= g_command1(4);
                    	when x"01"+x"10" => s_DIO <= g_command1(5);
                    	when x"01"+x"13" => s_DIO <= g_command1(6);
                    	when x"01"+x"16" => s_DIO <= g_command1(7);
                    	when x"01"+x"19" => s_DIO <= '0';
                    	when others =>
                	end case;
            	
                
         		elsif (s_counter = x"1F") then 
            		-- END
            	
              		s_DIO <= '1';
              
            	elsif (s_counter = x"20") then 
            		-- START
            
               		s_DIO <= '0';
        		                
          		elsif (s_counter >= x"21") and (s_counter < x"AB") then
        			-- COMMAND 2
            	
        			case s_counter is
                		when x"21"+x"01" => s_DIO <= g_command2(0);
                   		when x"21"+x"04" => s_DIO <= g_command2(1);
                    	when x"21"+x"07" => s_DIO <= g_command2(2);
                    	when x"21"+x"0A" => s_DIO <= g_command2(3);
                    	when x"21"+x"0D" => s_DIO <= g_command2(4);
                    	when x"21"+x"10" => s_DIO <= g_command2(5);
                    	when x"21"+x"13" => s_DIO <= g_command2(6);
                    	when x"21"+x"16" => s_DIO <= g_command2(7);
                    	when x"21"+x"19" => s_DIO <= '0';
                    	when others =>
                	end case;
                
                
					-- DATA 1                

                	case s_counter is
                		when x"3C"+x"01" => s_DIO <= s_grid1(0);
                   		when x"3C"+x"04" => s_DIO <= s_grid1(1);
                    	when x"3C"+x"07" => s_DIO <= s_grid1(2);
                    	when x"3C"+x"0A" => s_DIO <= s_grid1(3);
                    	when x"3C"+x"0D" => s_DIO <= s_grid1(4);
                    	when x"3C"+x"10" => s_DIO <= s_grid1(5);
                    	when x"3C"+x"13" => s_DIO <= s_grid1(6);
                    	when x"3C"+x"16" => s_DIO <= s_grid1(7);
                    	when x"3C"+x"19" => s_DIO <= '0';
                    	when others =>
                	end case;
                
                	-- DATA 2
                
                	case s_counter is
                		when x"57"+x"01" => s_DIO <= s_grid2(0);
                   		when x"57"+x"04" => s_DIO <= s_grid2(1);
                    	when x"57"+x"07" => s_DIO <= s_grid2(2);
                    	when x"57"+x"0A" => s_DIO <= s_grid2(3);
                    	when x"57"+x"0D" => s_DIO <= s_grid2(4);
                    	when x"57"+x"10" => s_DIO <= s_grid2(5);
                    	when x"57"+x"13" => s_DIO <= s_grid2(6);
                    	when x"57"+x"16" => s_DIO <= s_grid2(7);
                    	when x"57"+x"19" => s_DIO <= '0';
                    	when others =>
                	end case;
                
                	-- DATA 3
                
                	case s_counter is
                		when x"72"+x"01" => s_DIO <= s_grid3(0);
                   		when x"72"+x"04" => s_DIO <= s_grid3(1);
                    	when x"72"+x"07" => s_DIO <= s_grid3(2);
                    	when x"72"+x"0A" => s_DIO <= s_grid3(3);
                    	when x"72"+x"0D" => s_DIO <= s_grid3(4);
                    	when x"72"+x"10" => s_DIO <= s_grid3(5);
                    	when x"72"+x"13" => s_DIO <= s_grid3(6);
                    	when x"72"+x"16" => s_DIO <= s_grid3(7);
                    	when x"72"+x"19" => s_DIO <= '0';
                    	when others =>
                	end case;
                
               		-- DATA 4
                
                	case s_counter is
                		when x"8D"+x"01" => s_DIO <= s_grid4(0);
                   		when x"8D"+x"04" => s_DIO <= s_grid4(1);
                    	when x"8D"+x"07" => s_DIO <= s_grid4(2);
                    	when x"8D"+x"0A" => s_DIO <= s_grid4(3);
                    	when x"8D"+x"0D" => s_DIO <= s_grid4(4);
                    	when x"8D"+x"10" => s_DIO <= s_grid4(5);
                    	when x"8D"+x"13" => s_DIO <= s_grid4(6);
                    	when x"8D"+x"16" => s_DIO <= s_grid4(7);
                    	when x"8D"+x"19" => s_DIO <= '0';
                    	when others =>
                	end case;
                
                
            
            	elsif (s_counter = x"AB") then 
            		-- END
                
            		s_DIO <= '1';
           	
            	elsif (s_counter = x"AC") then 
            		-- START
            
               		s_DIO <= '0';
               
            	elsif (s_counter >= x"AD") and (s_counter < x"CB") then
            		-- COMMAND 3
            	
                	case s_counter is
                		when x"AD"+x"01" => s_DIO <= g_command3(0);
                   		when x"AD"+x"04" => s_DIO <= g_command3(1);
                    	when x"AD"+x"07" => s_DIO <= g_command3(2);
                    	when x"AD"+x"0A" => s_DIO <= g_command3(3);
                    	when x"AD"+x"0D" => s_DIO <= g_command3(4);
                    	when x"AD"+x"10" => s_DIO <= g_command3(5);
                    	when x"AD"+x"13" => s_DIO <= g_command3(6);
                    	when x"AD"+x"16" => s_DIO <= g_command3(7);
                    	when x"AD"+x"19" => s_DIO <= '0';
                    	when others =>
                	end case;
            	
                
            	else -- s_counter = CB aka length of sequence - 1
            		-- END
                
            		s_DIO <= '1'; 
          		end if;
        	end if;
    	end if;
	end process p_create_command;

-------------------------------------------------------------------------- 
-- p_update:
-- Assigns the value of current time (s_cur_time) to output current_time_o
-- (this warrants a delay of 1 clock cycle from input to output)
-------------------------------------------------------------------------- 
    p_update : process (clk_i)
    begin
    	if rising_edge(clk_i) then -- Rising clock edge
        	if srst_n_i = '0' then
            		CLK_o <= '1';
                	DIO_o <= '1';
           	else
        		CLK_o <= s_CLK;
            		DIO_o <= s_DIO;
            	end if;
        end if; 
    end process p_update;
    
end architecture Behavioral;
