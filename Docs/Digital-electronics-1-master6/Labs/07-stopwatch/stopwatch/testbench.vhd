-- testbench for stopwatch entity
-- ATTENTION:
-- to demonstrate overflow, set the default value of s_sec_h to x"3" (line 32 in design.vhd)
-- and also comment line 70 in this file. Otherwise counting starts at 0000.
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
--empty
end testbench;

architecture tb of testbench is
  -- DUT component
  component stopwatch is
  port(
      -- INPUTS
      clk_i    : in  std_logic;
      srst_n_i : in  std_logic;   -- Synchronous reset (active low)
      ce_100Hz_i: in  std_logic; 	-- clock enable
      cnt_en_i : in std_logic;	-- stopwatch enable
      -- OUTPUTS
      sec_h_o  : out unsigned(4-1 downto 0);
      sec_l_o  : out unsigned(4-1 downto 0);
      hth_h_o  : out unsigned(4-1 downto 0);
      hth_l_o  : out unsigned(4-1 downto 0)
  );
  end component;

  signal clk_in   	: std_logic := '0'; -- will be used for clk_i,
  										-- ce_100Hz_i and cnt_en_i
                                        -- for demonstration purposes
  signal srst_n_in 	: std_logic := '0';   
  signal sec_h_out	: unsigned(4-1 downto 0);
  signal sec_l_out	: unsigned(4-1 downto 0);
  signal hth_h_out	: unsigned(4-1 downto 0);
  signal hth_l_out	: unsigned(4-1 downto 0);
  
  BEGIN
	UUT: stopwatch port map(
      clk_i => clk_in,
      ce_100Hz_i => clk_in,
      cnt_en_i => clk_in,
      srst_n_i => srst_n_in, 
      sec_h_o => sec_h_out,
      sec_l_o => sec_l_out, 
      hth_h_o => hth_h_out,
      hth_l_o => hth_l_out
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