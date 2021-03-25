-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
--empty
end testbench;

architecture tb of testbench is
  -- DUT component
  component commander is
	port(
	-- Inputs
	clk_i  	: 	in 	std_logic;		-- Clock 10 kHz
  	current_time_i:	 in	unsigned(12-1 downto 0);
    srst_n_i:	in	std_logic;		-- Synchronous reset (active low)
	-- Outputs
  	CLK_o	:	out std_logic;
    DIO_o	:	out std_logic
	);
  end component;

  signal clk_in   	: std_logic := '0'; 
  signal srst_n_in	: std_logic	:= '1';		-- Synchronous reset (active low)
  signal current_time_in: unsigned(12-1 downto 0) := x"CD0";
  signal CLK_out	: std_logic;
  signal DIO_out	: std_logic;
  
  BEGIN
	UUT: commander port map(
      clk_i => clk_in,
      current_time_i => current_time_in,
      srst_n_i => srst_n_in,
      CLK_o => CLK_out,
      DIO_o => DIO_out
    );
	

	Clk_gen: process	
  	begin
    	while Now < 5000 nS loop
      		clk_in <= '0';
      		wait for 0.5 NS;
      		clk_in <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_gen;
   
   -- Stimulus process
   stim_proc: process
   begin	
   	  
      
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait for 500 NS;
      
      current_time_in <= x"CD1";
      
      wait;
   end process;
end tb;