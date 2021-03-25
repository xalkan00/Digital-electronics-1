--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:24:55 04/11/2020
-- Design Name:   
-- Module Name:   C:/Users/pesul/Xilinx/UART/testbench.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk_i 	: IN  std_logic;
         BTN0 		: IN  std_logic;
         SW0_CPLD : IN  std_logic;
         SW1_CPLD : IN  std_logic;
         SW2_CPLD : IN  std_logic;
         SW3_CPLD : IN  std_logic;
         SW4_CPLD : IN  std_logic;
         SW5_CPLD : IN  std_logic;
         SW6_CPLD : IN  std_logic;
         SW7_CPLD : IN  std_logic;
         SW8_CPLD : IN  std_logic;
         SW9_CPLD : IN  std_logic;
         SW10_CPLD: IN  std_logic;
         LD0 		: OUT  std_logic;
         active_o  : OUT  std_logic;
         done_o 	: OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i 	 : std_logic;
   signal BTN0 	 : std_logic := '1';   -- 1 passive state -- 0 active state
   signal SW0_CPLD : std_logic := '1';
   signal SW1_CPLD : std_logic := '0';
   signal SW2_CPLD : std_logic := '1';
   signal SW3_CPLD : std_logic := '0';
   signal SW4_CPLD : std_logic := '1';
   signal SW5_CPLD : std_logic := '0';
   signal SW6_CPLD : std_logic := '1';
   signal SW7_CPLD : std_logic := '0';
   signal SW8_CPLD : std_logic := '1';		-- speed -- 0 600 bit/s -- 1 110 bit/s 
   signal SW9_CPLD : std_logic := '1';		-- parity -- 1 even -- 0 odd
   signal SW10_CPLD : std_logic:= '0';		-- 1 double stop bit

 	--Outputs
   signal LD0 		: std_logic;
   signal active_o : std_logic;
   signal done_o 	: std_logic;
	
   -- Clock period definitions
   constant clk_i_period : time := 100 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk_i 	 => clk_i,
          BTN0		 => BTN0,
          SW0_CPLD => SW0_CPLD,
          SW1_CPLD => SW1_CPLD,
          SW2_CPLD => SW2_CPLD,
          SW3_CPLD => SW3_CPLD,
          SW4_CPLD => SW4_CPLD,
          SW5_CPLD => SW5_CPLD,
          SW6_CPLD => SW6_CPLD,
          SW7_CPLD => SW7_CPLD,
          SW8_CPLD => SW8_CPLD,
          SW9_CPLD => SW9_CPLD,
          SW10_CPLD => SW10_CPLD,
          LD0		 => LD0,
          active_o  => active_o,
          done_o	 => done_o
        );

   -- Clock process definitions
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
      -- hold reset state for 100 ns
      wait for 100 ns;	
      wait for clk_i_period*10;
		
		BTN0 <= '0';						-- even parity, 110 bit/s, one stop bit
		wait for clk_i_period*1400;
		
		BTN0 <= '1';						--	odd parity, 110 bit/s, one stop bit
		SW9_CPLD <= '0';
		wait for clk_i_period*200;		
		BTN0 <= '0';
		wait for clk_i_period*1400;
		
		BTN0 <= '1';						--	even parity, 110 bit/s, double stop bit
		SW9_CPLD <= '1';
		SW10_CPLD <= '1';
		wait for clk_i_period*200;		
		BTN0 <= '0';
		wait for clk_i_period*1400;
				
		BTN0 <= '1';						--	even parity, 600 bit/s, one stop bit
		SW10_CPLD <= '0';
		SW8_CPLD <= '0';
		wait for clk_i_period*200;		
		BTN0 <= '0';
		wait for clk_i_period*300;
		
		BTN0 <= '1';						-- passsive state
		wait for clk_i_period*200;	
      wait;
   end process;

END;
