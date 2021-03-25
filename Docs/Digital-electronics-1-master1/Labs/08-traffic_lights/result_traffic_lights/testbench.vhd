library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is

end testbench;

architecture tb of testbench is

component traffic_light is
port(
    	clk_i    : 	in std_logic;
        srst_n_i : 	in std_logic;
    	ce_2Hz_i : in std_logic;	
    
    	light_o  : 	out unsigned (6-1 downto 0)	
	 );
end component;


  signal clk_in   	: std_logic := '0'; 
  signal srst_n_in 	: std_logic := '0';   
  signal ce_2Hz_in	: std_logic := '0';
signal light_out	: unsigned(6-1 downto 0 );

begin


	UUT: traffic_light port map(
      clk_i => clk_in,
      srst_n_i => srst_n_in,
      ce_2Hz_i => ce_2Hz_in,
      light_o => light_out 
    );
	

	Clk_gen: process	
  	begin
    	while Now < 500 ns loop
      		clk_in <= '0';
      		wait for 0.5 ns;
      		clk_in <= '1';
      		wait for 0.5 ns;
    	end loop;
    	wait;
  	end process Clk_gen;
    Clk_2Hz_gen: process	
  	begin
    	while Now < 500 ns loop
      		ce_2Hz_in <= '0';
      		wait for 1.5 ns;
      		ce_2Hz_in <= '1';
      		wait for 0.5 ns;
    	end loop;
    	wait;
  	end process Clk_2Hz_gen;
   
   -- Stimulus process
   stim_proc: process
   begin	
   	  
      srst_n_in <= '1';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      srst_n_in <= '0';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      srst_n_in <= '1';
      
      wait;
   end process;

end tb;

