library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_d_ff_arst is
--  Port ( );
end tb_d_ff_arst;

architecture Behavioral of tb_d_ff_arst is

 constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
 signal  s_clk_100MHz    : STD_LOGIC; 
 signal  s_arst    : STD_LOGIC; 
 signal  s_d       : STD_LOGIC;
 signal  s_q       : STD_LOGIC; 
 signal  s_q_bar   : STD_LOGIC;

begin
 uut_d_ff_arst : entity work.d_ff_arst
port map(

    clk    => s_clk_100MHz,
    arst   => s_arst,
    d      => s_d,
    q      => s_q,
    q_bar  => s_q_bar

);

--------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
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
        s_arst <= '0';
        wait for 50 ns;
        
        s_arst <= '1';                 
        wait for 30 ns;
        
        s_arst <= '0';

        wait;
    end process p_reset_gen;
    
     p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started." severity note;
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 1" severity note;
        
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 2" severity note;
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 3" severity note;
       
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 4" severity note;
              
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 5" severity note;
        
              
        ------------------------- Reset activated --------------------------
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 7" severity note;
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 8" severity note;
        
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 9" severity note;
       
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 10" severity note;
              
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 11" severity note;
        
         s_d    <=  '1';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 12" severity note;
        
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 13" severity note;
        
        ------------------------- Reset deactivated --------------------------
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 14" severity note;
        
        s_d     <=  '1';
        wait for 10ns;
        assert (s_q = '1' and s_q_bar = '0') report "Error 15" severity note;
       
        s_d     <=  '0';
        wait for 10ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 16" severity note;        
       
        
        report "Stimulus process ended." severity note;
        wait;
    end process p_stimulus;

end Behavioral;