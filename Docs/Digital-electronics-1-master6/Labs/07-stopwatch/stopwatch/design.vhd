------------------------------------------------------------------------
-- Library declaration
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for stopwatch
------------------------------------------------------------------------

entity stopwatch is
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
end entity stopwatch;

------------------------------------------------------------------------
-- Architecture declaration for stopwatch
------------------------------------------------------------------------
architecture Behavioral of stopwatch is
    signal s_sec_h	: unsigned(4-1 downto 0) := x"0";
    signal s_sec_l	: unsigned(4-1 downto 0) := x"0";
    signal s_hth_h	: unsigned(4-1 downto 0) := x"0";
    signal s_hth_l	: unsigned(4-1 downto 0) := x"0";
begin
    --------------------------------------------------------------------
    -- p_watch_cnt:
    -- Sequential process with synchronous reset, which keeps track of
    -- time (up to one minute) with 0.01 sec resolution 
    --------------------------------------------------------------------
	p_watch_cnt : process (clk_i)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)
                s_sec_h <= x"0";
                s_sec_l <= x"0";
                s_hth_h <= x"0";
                s_hth_l <= x"0";
            elsif cnt_en_i = '1' then
            	if s_sec_h = x"5" and s_sec_l = x"9" and s_hth_h = x"9"
                and s_hth_l = x"9" then 	-- Overflow reset
                	s_sec_h <= x"0";
                	s_sec_l <= x"0";
                	s_hth_h <= x"0";
                	s_hth_l <= x"0";
                elsif s_sec_l = x"9" and s_hth_h = x"9"
                and s_hth_l = x"9" then 	-- Incrementing s_sec_h
                	s_sec_h <= s_sec_h + '1';
                	s_sec_l <= x"0";
                	s_hth_h <= x"0";
                	s_hth_l <= x"0";
                elsif s_hth_h = x"9" and s_hth_l = x"9" then
                 							-- Incrementing s_sec_l
                 	s_sec_l <= s_sec_l + '1';
                	s_hth_h <= x"0";
                	s_hth_l <= x"0";
                elsif s_hth_l = x"9" then 	-- Incrementing s_hth_h
                	s_hth_h <= s_hth_h + '1';
                	s_hth_l <= x"0";
                else 
                	s_hth_l <= s_hth_l + '1';
                end if;
            end if;
        end if;
    end process p_watch_cnt;
    
    --------------------------------------------------------------------
    -- p_watch_update:
    -- Sequential process with synchronous reset, that updates output 
    -- values, when stopwatch enable (cnt_en_i) is high
    --------------------------------------------------------------------
	p_watch_update : process (clk_i)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)
                sec_h_o <= x"0";
                sec_l_o <= x"0";
                hth_h_o <= x"0";
                hth_l_o <= x"0";
            elsif ce_100Hz_i = '1' then
            	sec_h_o <= s_sec_h;
                sec_l_o <= s_sec_l;
                hth_h_o <= s_hth_h;
                hth_l_o <= s_hth_l;
            end if;
        end if;
    end process p_watch_update;


end architecture Behavioral;
