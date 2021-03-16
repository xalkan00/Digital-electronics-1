
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- novinka 

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_clock_enable is
    -- Entity of testbench is always empty  // sem se nic nepi�e
end entity tb_clock_enable;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_clock_enable is

    constant c_MAX               : natural := 8;          -- mame konstanti
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;      --

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_ce         : std_logic;

begin
    -- Connecting testbench signals with clock_enable entity
    -- (Unit Under Test)
    uut_ce : entity work.clock_enable
        generic map(
            g_MAX => c_MAX
        )  
      
        port map(        -- tu pridame signaly k vstupy a vystupy
            clk   => s_clk_100MHz,
            reset => s_reset,
            ce_o  => s_ce
        );

    --------------------------------------------------------------------
    -- Clock generation process  // v�echni procesi spusti zarovne 
    --------------------------------------------------------------------
    p_clk_gen : process                           
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                           -- Process is suspended forever
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process            -- ?as v (ns) mu�eme zmenit nahodne podle jak nam simulace uka�e
    begin
        s_reset <= '0';
        wait for 28 ns;      -- za 28 ns reset bude na 1 
        
        -- Reset activated
        s_reset <= '1';      -- za 53 ns reset bude na 0
        wait for 53 ns;

        -- Reset deactivated
        s_reset <= '0';

        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;