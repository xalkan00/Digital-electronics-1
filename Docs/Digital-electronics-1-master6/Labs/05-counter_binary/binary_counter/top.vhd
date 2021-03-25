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
    disp_dig_o : out std_logic_vector(4-1 downto 0);
	 LD0:	out std_logic;
	 LD1:	out std_logic;
	 LD2:	out std_logic;
	 LD3:	out std_logic
	 
);
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    constant c_NBIT0 : positive := 4;   -- Number of bits for Counter0
    signal s_hex: std_logic_vector(c_NBIT0-1 downto 0);
	 signal s_hex1: std_logic_vector(c_NBIT0-1 downto 0);
	 signal s_en: std_logic;
	 signal s_en1: std_logic;
	 
	 --- WRITE YOUR CODE HERE
begin

    --------------------------------------------------------------------
    -- Sub-block of clock_enable entity
	 CLOCK0: entity work.clock_enable
	 generic map(
			g_NPERIOD => x"09C4"
	 )
	 port map(
			clk_i    => clk_i,  -- 10 kHz
			srst_n_i => BTN0,   -- Synchronous reset
			clock_enable_o => s_en
	 );


    --------------------------------------------------------------------
    -- Sub-block of binary_cnt entity
    COUNTER0: entity work.binary_cnt
	 generic map(
			g_NBIT => c_NBIT0
	 )
	 port map(
			clk_i    => clk_i,  -- 10 kHz
			srst_n_i => BTN0,   -- Synchronous reset
			en_i     => s_en,   -- Enable
			cnt_o    => s_hex   -- Output bits
	 );
	 
	 -- Sub-block of clock_enable entity
	 CLOCK1: entity work.clock_enable
	 generic map(
			g_NPERIOD => x"9C40"
	 )
	 port map(
			clk_i    => clk_i,  -- 10 kHz
			srst_n_i => BTN0,   -- Synchronous reset
			clock_enable_o => s_en1
	 );


    --------------------------------------------------------------------
    -- Sub-block of binary_cnt entity
    COUNTER1: entity work.binary_cnt
	 generic map(
			g_NBIT => c_NBIT0
	 )
	 port map(
			clk_i    => clk_i,  -- 10 kHz
			srst_n_i => BTN0,   -- Synchronous reset
			en_i     => s_en1,   -- Enable
			cnt_o    => s_hex1   -- Output bits
	 );


    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    HEX2SSEG: entity work.hex_to_7seg
	 port map(
			hex_i => s_hex,
			seg_o => disp_seg_o
	 );

    -- Select display position
    disp_dig_o <= "1110";
	 
	 LD0 <= not s_hex1(0);
	 LD1 <= not s_hex1(1);
	 LD2 <= not s_hex1(2);
	 LD3 <= not s_hex1(3);

end architecture Behavioral;