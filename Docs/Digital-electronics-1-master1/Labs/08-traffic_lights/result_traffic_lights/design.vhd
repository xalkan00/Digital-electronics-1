library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light is

port(clk_i : 	in std_logic;
	srst_n_i : 	in std_logic;
    ce_2Hz_i : in std_logic;	
    
    light_o : 	out unsigned (6-1 downto 0)
    );
end entity traffic_light;

architecture traffic_light of traffic_light is

type state_type is (green_red, yellow_red, red_red_1, red_green, red_yellow, red_red_2);
signal s_state : state_type;
signal s_count : unsigned(3 downto 0);
signal srst_n_in : std_logic;
signal s_en  : std_logic;
constant SEC5 : unsigned(3 downto 0) := "1111";
constant SEC1 : unsigned(3 downto 0) := "0011";

begin

CLOCK: entity work.clock_enable
	 generic map(g_NPERIOD => x"000A")
	 port map(
			clk_i    		=>  clk_i,  		-- 10 kHz
			srst_n_i 		=>	srst_n_i,   	-- Synchronous reset
			clock_enable_o 	=> 	s_en			
	 		 );

--------------------------------------------------------------------

traffic_light : process (clk_i, srst_n_i)    
   begin
		if rising_edge(clk_i) then
            if srst_n_i = '0' then
					s_state <= red_green;
               s_count <= x"0";
            elsif rising_edge(clk_i) and ce_2Hz_i = '1' then
                case s_state is
                    when red_green =>
                        if s_count < SEC5 then
                            s_state <= red_green;
                            s_count <= s_count + 1;
                        else
                            s_state <= red_yellow;
                            s_count <= x"0";
                        end if;
                    when red_yellow =>
                        if s_count < SEC1 then
                            s_state <= red_yellow;
                            s_count <= s_count + 1;
                        else
                            s_state <= red_red_1;
                            s_count <= x"0";
                        end if;    
                    when red_red_1 =>
                        if s_count < SEC1 then
                            s_state <= red_red_1;
                            s_count <= s_count + 1;
                        else
                            s_state <= green_red;
                            s_count <= x"0";
                        end if;
                    when green_red =>
                        if s_count < SEC5 then
                            s_state <= green_red;
                            s_count <= s_count + 1;
                        else
                            s_state <= yellow_red;
                            s_count <= x"0";
                        end if;    
                    when yellow_red =>
                        if s_count < SEC1 then
                            s_state <= yellow_red;
                            s_count <= s_count + 1;
                        else
                            s_state <= red_red_2;
                            s_count <= x"0";
                        end if;   
                    when red_red_2 =>
                        if s_count < SEC1 then
                            s_state <= red_red_2;
                            s_count <= s_count + 1;
                        else
                            s_state <= red_green;
                            s_count <= x"0";
                        end if;    
                    when others =>
							 s_state <= red_green;
                end case;
            end if;
        end if;    
end process traffic_light;

--------------------------------------------------------------------

traffic_light_LED : process (s_state)
    begin
    	case s_state is
			when red_green   	=> light_o <= "100001";
         	when red_yellow 	=> light_o <= "100010";
         	when red_red_1  	=> light_o <= "100100";
        	when green_red  	=> light_o <= "001100";
         	when yellow_red 	=> light_o <= "010100";
         	when red_red_2  	=> light_o <= "100100";
         	when others 		=> light_o <= "100001";
		end case;
	end process;
end traffic_light;


