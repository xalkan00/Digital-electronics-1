------------------------------------------------------------------------
--
-- Driver for seven-segment displays.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation

------------------------------------------------------------------------
-- Entity declaration for display driver
------------------------------------------------------------------------
entity driver_7seg is
port (
    clk_i    : in  std_logic;
    srst_n_i : in  std_logic;   -- Synchronous reset (active low)
    data0_i  : in  std_logic_vector(4-1 downto 0);  -- Input values
    data1_i  : in  std_logic_vector(4-1 downto 0);
    data2_i  : in  std_logic_vector(4-1 downto 0);
    data3_i  : in  std_logic_vector(4-1 downto 0);
    dp_i     : in  std_logic_vector(4-1 downto 0);  -- Decimal points
    disp_enable: in  std_logic;  -- Decimal points
    dp_o     : out std_logic;                       -- Decimal point
    seg_o    : out std_logic_vector(7-1 downto 0);
    dig_o    : out std_logic_vector(4-1 downto 0)
	 
);
end entity driver_7seg;

------------------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------------------
architecture Behavioral of driver_7seg is
    signal s_en  : std_logic;
    signal s_hex : std_logic_vector(4-1 downto 0);
    signal s_cnt : std_logic_vector(2-1 downto 0) := "00";
	 signal seg_o_temp :  std_logic_vector(7-1 downto 0);
begin


	
    --------------------------------------------------------------------
    -- Sub-block of clock_enable entity. Create s_en signal.
    --- WRITE YOUR CODE HERE
	GGenable: entity work.clock_enable
        generic map (g_NPERIOD=>x"0002")
        port map (-- <component_signal> => actual_signal,
                  -- <component_signal> => actual_signal,
                  -- ...
                  -- <component_signal> => actual_signal);
                  -- WRITE YOUR CODE HERE
                  clk_i=>clk_i,
                  srst_n_i=>srst_n_i,
                  clock_enable_o=>s_en
                 );

    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    --- WRITE YOUR CODE HERE
HEX2SSEG: entity work.hex_to_7seg
        port map (hex_i=>s_hex,
                  seg_o=>seg_o_temp
                  );

    --------------------------------------------------------------------
    -- p_select_cnt:
    -- Sequential process with synchronous reset and clock enable,
    -- which implements an internal 2-bit counter s_cnt for multiplexer 
    -- selection bits.
    --------------------------------------------------------------------
    p_select_cnt : process (clk_i)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)
                s_cnt<="00";
            elsif s_en = '1' then
               s_cnt<=s_cnt+1;
            end if;
        end if;
    end process p_select_cnt;
	 --------------------------------------------------------------------
    -- p_mux_en:
    -- Combinational process which implements a 2-to-1 mux for turning the display on/off.
    --------------------------------------------------------------------
    
	 p_mux_en : process (disp_enable,seg_o_temp)
	 begin
	 case disp_enable is
	 
	 when '1' =>
	 seg_o<=seg_o_temp;
	 when others =>
	 seg_o<="1111111";
	 end case;
	 
	 end process p_mux_en ;
	 
	 
	 
	 --------------------------------------------------------------------
    -- p_mux:
    -- Combinational process which implements a 4-to-1 mux.
    --------------------------------------------------------------------
    p_mux : process (s_cnt, data0_i, data1_i, data2_i, data3_i, dp_i)
    begin
        case s_cnt is
        when "00" =>
            s_hex<=data0_i;
            dig_o<="1110";
				dp_o<=dp_i(3);
        when "01" =>
            s_hex<=data1_i;
				dig_o<="1101";
				dp_o<=dp_i(2);
        when "10" =>
            s_hex<=data2_i;
				dig_o<="1011";
				dp_o<=dp_i(1);
        when others =>
            s_hex<=data3_i;
				dig_o<="0111";
				dp_o<=dp_i(0);
        end case;
    end process p_mux;

end architecture Behavioral;