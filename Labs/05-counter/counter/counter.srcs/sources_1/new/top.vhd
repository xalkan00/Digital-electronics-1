library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
  Port ( 
    CLK100MHZ : in std_logic;
    BTNC      : in std_logic;
    SW        : in std_logic_vector(1-1 downto 0);
    LED       : out std_logic_vector(4-1 downto 0);
    AN        : out std_logic_vector(8-1 downto 0);
    CA        : out std_logic;
    CB        : out std_logic;
    CC        : out std_logic;
    CD        : out std_logic;
    CE        : out std_logic;
    CF        : out std_logic;
    CG        : out std_logic

  );
end top;

architecture Behavioral of top is      -- vnit?ni signaly v tobu
    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal counter
    signal s_cnt : std_logic_vector(4 - 1 downto 0);
begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 100000000
        )
        port map(
            clk   => CLK100MHZ,
            reset => BTNC,
            ce_o  => s_en          
        );

    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 4
        )
        port map(
        clk   => CLK100MHZ,   
        reset => BTNC,  
        en_i  => s_en,   
        cnt_up_i  => sw(0),
        cnt_o    => s_cnt
        );

    -- Display input value on LEDs
    LED(3 downto 0) <= s_cnt;

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => s_cnt,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );

    -- Connect one common anode to 3.3V
    AN <= b"1111_1110";

end Behavioral;
