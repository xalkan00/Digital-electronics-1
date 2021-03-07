library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  Port 
  (
    SW : in std_logic_vector(4-1 downto 0);
    CA : out std_logic;
    CB : out std_logic;
    CC : out std_logic;
    CD : out std_logic;
    CE : out std_logic;
    CF : out std_logic;
    CG : out std_logic;
    LED: out std_logic_vector(8-1 downto 0);
    AN : out std_logic_vector(8-1 downto 0)
  
   );
end top;

architecture Behavioral of top is
    
begin
  
hex2seg : entity work.hex_7seg

    port map(
    
          hex_i => SW,    
          seg_o(6) => CA,
          seg_o(5) => CB,
          seg_o(4) => CC,
          seg_o(3) => CD,
          seg_o(2) => CE,
          seg_o(1) => CF,
          seg_o(0) => CG
           
    );
  
         --Connect one common anode to 3.3V
        AN <= b"1111_0111";

       -- Display input value
       LED(3 downto 0) <= SW; 
       
       -- Turn on LD3 if the input value is equal to "0000"
                               
       LED(4) <= not SW(3) and not SW(2) and not SW(1) and not SW(0); -- nebo  LED(4)  <= '1' when (SW = "0000") else '0';
 
       -- Turn LED(5) on if input value is greater than 9
       LED(5) <= 
            '1' when SW = "1010" else    --a      nebo  LED(5)  <= '1' when (SW > "1001") else '0';
			'1' when SW = "1011" else	 --b
			'1' when SW = "1100" else	 --c
			'1' when SW = "1101" else	 --d
			'1' when SW = "1110" else	 --e
			'1' when SW = "1111" else    --f		
			'0';
       
       -- Turn LED(6) on if input value is odd, ie 1, 3, 5, ...
       LED(6) <= 
            '1' when SW = "0001" else    --1		
			'1' when SW = "0011" else	 --3			
			'1' when SW = "0101" else	 --5			
			'1' when SW = "0111" else    --7			
			'1' when SW = "1001" else    --9
			'1' when SW = "1011" else    --B
			'1' when SW = "1101" else    --D
			'1' when SW = "1111" else    --F
			'0';
              
       -- Turn LED(7) on if input value is a power of two, ie 1, 2, 4, or 8
       LED(7) <=
            '1' when (SW = "0001") else  --1
	        '1' when (SW = "0010") else  --2
			'1' when (SW = "0100") else	 --4
			'1' when (SW = "1000") else	 --8			  
			'0';

end Behavioral;







