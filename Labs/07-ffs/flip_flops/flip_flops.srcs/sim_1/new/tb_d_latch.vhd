library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity tb_d_latch is
--  Port ( );
end tb_d_latch;

architecture Behavioral of tb_d_latch is

          signal s_en    :  STD_LOGIC;
          signal s_arst  :  STD_LOGIC;
          signal s_d     :  STD_LOGIC;
          signal s_q     :  STD_LOGIC;
          signal s_q_bar :  STD_LOGIC;

begin

uut_d_latch : entity work.d_latch

    port map (
    
    arst  =>  s_arst,
    en    =>  s_en,   
    d     =>  s_d,
    q     =>  s_q,
    q_bar =>  s_q_bar
    
    );

   p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 50 ns;
                 
        s_arst <= '1';                      
        wait for 10 ns; 
                
        s_arst <= '0';
        
        wait for 200 ns;
        
        s_arst <= '1';
        wait;
    end process p_reset_gen;


   p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_en <= '0';       
        s_d  <= '0'; 
       
        wait for 10 ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 1" severity note; 
        s_d  <= '1';
        wait for 10 ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 2" severity note; 
        s_d  <= '0';
        wait for 10 ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 3" severity note; 
        s_d  <= '1';
        wait for 10 ns;
        assert (s_q = 'U' and s_q_bar = 'U') report "Error 4" severity note; 
        s_d  <= '0';
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;
 -----------------------------------     
        s_en <= '1';
        
        wait for 10 ns;
         assert (s_q = '1' and s_q_bar = '0') report "Error 7" severity note;
        s_d  <= '1';
        wait for 10 ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 8" severity note;
        s_d  <= '0';
        wait for 10 ns;
         assert (s_q = '1' and s_q_bar = '0') report "Error 7" severity note;
        s_d  <= '1';
        wait for 10 ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 8" severity note;
        s_d  <= '0';
        wait for 10 ns;
         assert (s_q = '1' and s_q_bar = '0') report "Error 7" severity note;
        s_d  <= '1';
        wait for 10 ns;
        assert (s_q = '0' and s_q_bar = '1') report "Error 8" severity note;
        s_d  <= '0';
        wait for 10 ns;
         assert (s_q = '1' and s_q_bar = '0') report "Error 7" severity note;
  -------------------------------------      
        s_en <= '0';
          
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;

  ---------------------------
        s_en <= '1';      
        
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;
        s_d  <= '1';
        wait for 10 ns;
        s_d  <= '0';
        wait for 10 ns;


        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;  
        
end Behavioral;
