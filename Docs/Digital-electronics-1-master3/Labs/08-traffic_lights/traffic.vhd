library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity traffic is
	port(
		  clk_i    	: in  std_logic; 
        srst_n_i  : in  std_logic;
        cnt_en_i 	: in  std_logic;        
        light_o	: out std_logic_vector(5 downto 0)
		  );
end entity traffic;

architecture traffic of traffic is

    type state_type is (stop_go, stop_wait, stop_stop_1, go_stop, wait_stop, stop_stop_2);
    signal s_state : state_type;
    signal s_count : unsigned(3 downto 0);
    constant SEC5  : unsigned(3 downto 0) := "1111";
    constant SEC1  : unsigned(3 downto 0) := "0011";
	 
begin
    
traffic : process (clk_i, srst_n_i, cnt_en_i)    
   begin
		if rising_edge(clk_i) then
            if srst_n_i = '0' then
					s_state <= stop_go;
               s_count <= x"0";
            elsif cnt_en_i = '1' then
                case s_state is
                    when stop_go =>
                        if s_count < SEC5 then
                            s_state <= stop_go;
                            s_count <= s_count + 1;
                        else
                            s_state <= stop_wait;
                            s_count <= x"0";
                        end if;
                    when stop_wait =>
                        if s_count < SEC1 then
                            s_state <= stop_wait;
                            s_count <= s_count + 1;
                        else
                            s_state <= stop_stop_1;
                            s_count <= x"0";
                        end if;    
                    when stop_stop_1 =>
                        if s_count < SEC1 then
                            s_state <= stop_stop_1;
                            s_count <= s_count + 1;
                        else
                            s_state <= go_stop;
                            s_count <= x"0";
                        end if;
                    when go_stop =>
                        if s_count < SEC5 then
                            s_state <= go_stop;
                            s_count <= s_count + 1;
                        else
                            s_state <= wait_stop;
                            s_count <= x"0";
                        end if;    
                    when wait_stop =>
                        if s_count < SEC1 then
                            s_state <= wait_stop;
                            s_count <= s_count + 1;
                        else
                            s_state <= stop_stop_2;
                            s_count <= x"0";
                        end if;   
                    when stop_stop_2 =>
                        if s_count < SEC1 then
                            s_state <= stop_stop_2;
                            s_count <= s_count + 1;
                        else
                            s_state <= stop_go;
                            s_count <= x"0";
                        end if;    
                    when others =>
							 s_state <= stop_go;
                end case;
            end if;
        end if;    
end process traffic;

	traffic_to_LED : process (s_state)
    begin
    	case s_state is
			when stop_go   	=> light_o <= "100001";
         when stop_wait 	=> light_o <= "100010";
         when stop_stop_1  => light_o <= "100100";
         when go_stop  		=> light_o <= "001100";
         when wait_stop 	=> light_o <= "010100";
         when stop_stop_2  => light_o <= "100100";
         when others 		=> light_o <= "100001";
		end case;
	end process;
end traffic;
