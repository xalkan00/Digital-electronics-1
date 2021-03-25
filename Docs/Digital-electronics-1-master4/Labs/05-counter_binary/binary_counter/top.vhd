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
    clk_i      : in  std_logic;     -- 10 kHz clock signal
    BTN0       : in  std_logic;     -- Synchronous reset
    disp_seg_o : out std_logic_vector(7-1 downto 0);
	  LD0_CPLD:  out  std_logic;
          LD1_CPLD:  out  std_logic;
          LD2_CPLD:  out  std_logic;
          LD3_CPLD:  out  std_logic;
          LD8_CPLD:  out  std_logic;
          LD9_CPLD:  out  std_logic;
          LD10_CPLD:  out  std_logic;
          LD11_CPLD:  out  std_logic;
    disp_dig_o : out std_logic_vector(4-1 downto 0)
);
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    constant c_NBIT0 : positive := 4;   -- Number of bits for Counter0
    signal s_e : std_logic;
	 signal s_e2 : std_logic;
    signal bity : std_logic_vector(4-1 downto 0);
	 signal bity8 : std_logic_vector(8-1 downto 0);
    --- WRITE YOUR CODE HERE
begin


    --------------------------------------------------------------------
    -- Sub-block of clock_enable entity
    --- WRITE YOUR CODE HERE
 GGenable: entity work.clock_enable
        generic map (g_NPERIOD=>x"09C4")
        port map (-- <component_signal> => actual_signal,
                  -- <component_signal> => actual_signal,
                  -- ...
                  -- <component_signal> => actual_signal);
                  -- WRITE YOUR CODE HERE
                  clk_i=>clk_i,
                  srst_n_i=>BTN0,
                  clock_enable_o=>s_e
                 );
          
 GGenable2: entity work.clock_enable
        generic map (g_NPERIOD=>x"2710")
        port map (-- <component_signal> => actual_signal,
                  -- <component_signal> => actual_signal,
                  -- ...
                  -- <component_signal> => actual_signal);
                  -- WRITE YOUR CODE HERE
                  clk_i=>clk_i,
                  srst_n_i=>BTN0,
                  clock_enable_o=>s_e2
                 );
          
    --------------------------------------------------------------------
    -- Sub-block of binary_cnt entity
    --- WRITE YOUR CODE HERE
counter: entity work.binary_cnt
        generic map (g_NBIT =>4)
        port map (-- <component_signal> => actual_signal,
                  -- <component_signal> => actual_signal,
                  -- ...
                  -- <component_signal> => actual_signal);
                  -- WRITE YOUR CODE HERE
                  clk_i=>clk_i,
                  srst_n_i=>BTN0,
                  en_i=>s_e,
                  cnt_o=>bity
                 );


counter2: entity work.binary_cnt
        generic map (g_NBIT =>8)
        port map (-- <component_signal> => actual_signal,
                  -- <component_signal> => actual_signal,
                  -- ...
                  -- <component_signal> => actual_signal);
                  -- WRITE YOUR CODE HERE
                  clk_i=>clk_i,
                  srst_n_i=>BTN0,
                  en_i=>s_e2,
                  cnt_o=>bity8
                 );

    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    --- WRITE YOUR CODE HERE
HEX2SSEG: entity work.hex_to_7seg
        port map (hex_i=>bity,
                  seg_o=>disp_seg_o
                  );

    -- Select display position
    disp_dig_o <= "1110";

	LD0_CPLD<=bity8(0);
    LD1_CPLD<=bity8(1);
    LD2_CPLD<=bity8(2);
    LD3_CPLD<=bity8(3);
    
    LD8_CPLD<=bity8(4);
    LD9_CPLD<=bity8(5);
    LD10_CPLD<=bity8(6);
    LD11_CPLD<=bity8(7);



end architecture Behavioral;