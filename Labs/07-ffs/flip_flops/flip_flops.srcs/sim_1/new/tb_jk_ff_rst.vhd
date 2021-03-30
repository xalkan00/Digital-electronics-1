library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_jk_ff_rst is
--  Port ( );
end tb_jk_ff_rst;

 architecture Behavioral of tb_jk_ff_rst is
 constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
 signal  s_clk_100MHz         : STD_LOGIC; 
 signal  s_rst                : STD_LOGIC; 
 signal  s_j                  : STD_LOGIC;
 signal  s_k                  : STD_LOGIC;
 signal  s_q                  : STD_LOGIC; 
 signal  s_q_bar              : STD_LOGIC;
begin
uut_jk_ff_rst : entity work.jk_ff_rst
port map(

    clk    => s_clk_100MHz,
    rst    => s_rst,
    j      => s_j,
    k      => s_k,
    q      => s_q,
    q_bar  => s_q_bar

);
 p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_reset_gen : process
    begin
        s_rst <= '0';                 
        wait for 60 ns;
        s_rst <= '1';                 
        wait for 20 ns;
        s_rst <= '0';                 
        wait;
    end process p_reset_gen;
    
     p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started." severity note;
        wait for 10 ns;
        s_j     <=  '0';
        s_k     <=  '0';
        wait for 10ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 1" severity note;
        s_j     <=  '0';
        s_k     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 2" severity note;
        s_j     <=  '1';
        s_k     <=  '0';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 3" severity note;
        s_j     <=  '1';
        s_k     <=  '1';
        wait for 20ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 4" severity note;
        
        s_j     <=  '0';
        s_k     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 5" severity note;
        s_j     <=  '1';
        s_k     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 6" severity note;
               
        report "Stimulus process ended." severity note;
        wait;
    end process p_stimulus;

end Behavioral;