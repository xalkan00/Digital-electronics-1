library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
--empty
end testbench;

architecture tb of testbench is
  -- DUT component
  component countdown is
  port(
      -- INPUTS
	  clk_i    : 		in  	std_logic;		-- Clock 10 kHz
  	  encoder_pb_i: 	in  	std_logic;		-- Push button of encoder (active low)
	  encoder_A_i: 	    in 		std_logic;
	  encoder_B_i:  	in 		std_logic;
      srst_n_i	 :		in		std_logic;  	-- Synchronous reset (active low) 
      -- OUTPUTS
	  current_time_o:   out	    unsigned(12-1 downto 0)
  );
  end component;

  signal clk_in   	   :  std_logic := '0';
  signal encoder_pb_in :  std_logic := '1';
  signal encoder_A_in  :  std_logic := '0';
  signal encoder_B_in  :  std_logic := '0';
  signal srst_n_in	   :  std_logic := '1'; -- Synchronous reset (active low) 
  
  signal current_time_out    :  unsigned(12-1 downto 0);
  
  BEGIN
	UUT: countdown port map(
     srst_n_i		=>  srst_n_in,
     clk_i          =>  clk_in,
     encoder_pb_i   =>  encoder_pb_in,
     encoder_A_i    =>  encoder_A_in,
     encoder_B_i    =>  encoder_B_in,
     current_time_o =>  current_time_out   
    );
	

	Clk_gen: process	
  	begin
    	while Now < 4.4 uS loop
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
   
   
   	  wait for 0.5 NS;
      encoder_A_in  <= '1';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait for 0.5 NS;
      wait until rising_edge(clk_in);
      encoder_B_in <= '1';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait for 0.5 NS;
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait for 0.5 NS;
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait for 0.5 NS;
      wait until rising_edge(clk_in);
      encoder_A_in  <= '0';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      encoder_B_in  <= '0';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait for 0.5 NS;
      wait until rising_edge(clk_in);
      encoder_B_in  <= '1';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      encoder_pb_in <= '0';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait for 0.5 NS;
      encoder_pb_in <= '1';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      

      wait;
   end process;
end tb;