-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.Numeric_std.all;

entity test is
-- empty
end test; 

architecture tb of test is

-- DUT (Device Under Test) component
component stopwatch is
port (
	clk_i : in std_logic := '0';
   srst_n_i : in std_logic:= '1';
	ce_100Hz_i : in std_logic := '0';
   cnt_en_i : in std_logic := '0';
   sec_l_o : out std_logic_vector(3 downto 0) := (others => '0');
	sec_h_o : out std_logic_vector(3 downto 0) := (others => '0');
	hth_l_o : out std_logic_vector(3 downto 0) := (others => '0');
	hth_h_o : out std_logic_vector(3 downto 0) := (others => '0'));
end component;

	--Inputs
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';
   signal ce_100Hz_i : std_logic := '0';
   signal cnt_en_i : std_logic := '0';

 	--Outputs
   signal sec_l_o : std_logic_vector(3 downto 0);
   signal sec_h_o : std_logic_vector(3 downto 0);
   signal hth_l_o : std_logic_vector(3 downto 0);
   signal hth_h_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 100 us; 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: stopwatch PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          ce_100Hz_i => ce_100Hz_i,
          cnt_en_i => cnt_en_i,
          sec_h_o => sec_h_o,
          sec_l_o => sec_l_o,
          hth_h_o => hth_h_o,
          hth_l_o => hth_l_o
        );

   
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 
 
   -- Stimulus process
   stim_proc: process
   begin		
      
      ce_100Hz_i <= '0';
      cnt_en_i <= '1';
      srst_n_i <= '1'; wait for clk_i_period;
      srst_n_i <= '0'; wait for clk_i_period;
      srst_n_i <= '1'; 
		
	for i in 0 to 50000 loop
	    ce_100Hz_i <= '1';
	    wait for clk_i_period*1;			
	    ce_100Hz_i <= '0';
	    wait for clk_i_period*99;
		 
	end loop;
	wait;
	end process;
	
END;