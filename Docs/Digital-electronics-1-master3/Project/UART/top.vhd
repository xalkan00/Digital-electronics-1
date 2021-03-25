----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:19:29 04/11/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
------------------------------------------------------------------------
--
-- Implementation of 4-bit binary counter.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
entity top is
port (
    clk_i      	: in  std_logic;  	-- 10 kHz clock signal
    BTN0       	: in  std_logic;  	-- synchronous reset
    SW0_CPLD	: in  std_logic;	-- data (0)
    SW1_CPLD	: in  std_logic;	-- data (1)
    SW2_CPLD	: in  std_logic;	-- data (2)
    SW3_CPLD	: in  std_logic;	-- data (3)
    SW4_CPLD	: in  std_logic;	-- data (4)
    SW5_CPLD	: in  std_logic;	-- data (5)
    SW6_CPLD	: in  std_logic;  	-- data (6)
    SW7_CPLD	: in  std_logic;	-- data (7)
    SW8_CPLD	: in  std_logic;	-- speed
    SW9_CPLD	: in  std_logic;	-- parity
    SW10_CPLD	: in  std_logic;	-- double stop bit
------------------------- control variables ----------------------------
    LD0		: out std_logic;  	-- LED for control
    active_o	: out std_logic;	-- active state
    done_o	: out std_logic); 	-- passive state
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    
    --- WRITE YOUR CODE HERE
    signal s_en	 	: std_logic;
    signal s_srst	: std_logic;
    signal s_test	: std_logic;
    signal s_bound 	: std_logic_vector(16-1 downto 0);
    signal s_data  	: std_logic_vector(8-1 downto 0);
begin
    s_data(0) <= SW0_CPLD;
    s_data(1) <= SW1_CPLD;
    s_data(2) <= SW2_CPLD;
    s_data(3) <= SW3_CPLD;
    s_data(4) <= SW4_CPLD;
    s_data(5) <= SW5_CPLD;
    s_data(6) <= SW6_CPLD;
    s_data(7) <= SW7_CPLD;

    --------------------------------------------------------------------
    -- Sub-block of clock_enable entity
    --- WRITE YOUR CODE HERE
    CLOCKE: entity work.clock_enable
   		  
        port map( 
		  g_NPERIOD => s_bound,
		  srst_n_i  => s_srst,
                  clock_enable_o =>s_en,
                  clk_i => clk_i
		);

 

    --------------------------------------------------------------------
    -- Sub-block of UART_tx entity
    --- WRITE YOUR CODE HERE
    UART: entity work.UART_tx
	  
        port map (   
		   clk_i	=> clk_i,
		   tx_dv_i	=> BTN0,
		   tx_byte_i 	=> s_data,
            	   parity_i	=> SW9_CPLD,
		   en_i		=> s_en,
		   double_stop 	=> SW10_CPLD,
            	   res_en_o 	=> s_srst,
		   tx_active_o	=> active_o,	
		   tx_serial_o 	=> s_test,
		   tx_done_o   	=> done_o	
		 );

                
                
  speed : process (clk_i)
  begin		
		if rising_edge(clk_i) then  
			if SW8_CPLD = '1' then		-- speed choose
				s_bound <= x"005B";	-- 110 bit/s
			else
				s_bound <= x"0011";	-- 600 bit/s
			end if; 
		end if;
        

	end process speed;

	LD0 <= s_test;						
end architecture Behavioral;
