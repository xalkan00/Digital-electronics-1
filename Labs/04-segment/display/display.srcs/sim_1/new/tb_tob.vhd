
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity tb_tob is
--  Port ( );
end tb_tob;

architecture Behavioral of tb_tob is
   signal s_SW :  std_logic_vector(4-1 downto 0);
   signal s_CA :  std_logic;
   signal s_CB :  std_logic;
   signal s_CC :  std_logic;
   signal s_CD :  std_logic;
   signal s_CE :  std_logic;
   signal s_CF :  std_logic;
   signal s_CG :  std_logic;
   signal s_LED:  std_logic_vector(8-1 downto 0);
   signal s_AN :  std_logic_vector(8-1 downto 0);

begin

    uut_TOP : entity work.top
        port map(
            SW           => s_SW,
            CA           => s_CA,
            CB           => s_CB,
            CC           => s_CC,
            CD           => s_CD,
            CE           => s_CE,
            CF           => s_CF,
            CG           => s_CG,
            LED          => s_LED,                            
            AN           => s_AN
                      
        );

 p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;

        s_SW <= "0000";  wait for 130 ns; 
        s_SW <= "0001";  wait for 130 ns;
        s_SW <= "0010";  wait for 130 ns;
        s_SW <= "0011";  wait for 130 ns;
        s_SW <= "0100";  wait for 130 ns;
        s_SW <= "0101";  wait for 130 ns;
        s_SW <= "0110";  wait for 130 ns;
        s_SW <= "0111";  wait for 130 ns;
        s_SW <= "1000";  wait for 130 ns;
        s_SW <= "1001";  wait for 130 ns;
        s_SW <= "1010";  wait for 130 ns;
        s_SW <= "1011";  wait for 120 ns;
        s_SW <= "1100";  wait for 120 ns;       
        s_SW <= "1101";  wait for 120 ns;
        s_SW <= "1110";  wait for 120 ns;
        s_SW <= "1111";  wait for 120 ns;
              
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end Behavioral;
