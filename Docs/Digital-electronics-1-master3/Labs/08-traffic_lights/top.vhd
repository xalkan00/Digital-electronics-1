library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity top is
port(
    clk_i    	: in  std_logic;
    --srst_n_i 	: in  std_logic;    
	 LD12_CPLD  : out  std_logic;       
	 LD8_CPLD   : out  std_logic;        
	 LD5_CPLD   : out  std_logic;       
	 LD4_CPLD   : out  std_logic;        
	 LD1_CPLD   : out  std_logic;     
	 LD0_CPLD   : out  std_logic;
	 BTN0			: in  std_logic
	 );
end entity top;


architecture top of top is
    signal s_en  : std_logic;
	 signal s_light: std_logic_vector(5 downto 0);
begin


	CLK_EN_0 : entity work.clock_enable
    generic map(g_NPERIOD 	 => x"0D02")
    port map(clk_i		 	 => clk_i,
				 srst_n_i	 	 => BTN0,
             clock_enable_o => s_en);


	TRAFFIC_DRIVE : entity work.traffic
    port map(clk_i	 => clk_i,
				 cnt_en_i => s_en,
				 srst_n_i => BTN0,
             light_o  => s_light);
				 
	LD0_CPLD <= s_light(0);
	LD1_CPLD <= s_light(1);
	LD8_CPLD <= s_light(2);
	LD4_CPLD <= s_light(3);
	LD5_CPLD <= s_light(4);
	LD12_CPLD <= s_light(5);
            
end architecture top;
