library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_convertor is
    Port ( distance_i 	: in  STD_LOGIC_VECTOR (8 downto 0);
           hundreds_o 	: out  STD_LOGIC_VECTOR (3 downto 0);
           tens_o 		: out  STD_LOGIC_VECTOR (3 downto 0);
           unit_o 		: out  STD_LOGIC_VECTOR (3 downto 0));
end BCD_convertor;

architecture Behavioral of BCD_convertor is

begin
Var_dis : process(distance_i)
	variable i : integer :=0;
	variable bcd : STD_LOGIC_VECTOR(20 downto 0);
begin

	bcd := (others => '0');
	bcd(8 downto 0) := distance_i;
		for i in 0 to 8 loop
			bcd(19 downto 0) := bcd(18 downto 0) & '0';
			if(i < 8 AND bcd(12 downto 9) > "0100")then
				bcd(12 downto 9) := bcd(12 downto 9) + "0011";
			end if;
				if(i < 8 AND bcd(16 downto 13) > "0100")then
					bcd(16 downto 13) := bcd(16 downto 13) + "0011";
				end if;
					if(i < 8 AND bcd(20 downto 17) > "0100")then
						bcd(20 downto 17) := bcd(20 downto 17) + "0011";
					end if;
		end loop;
	hundreds_o 	<= bcd(20 downto 17);
	tens_o 		<= bcd(16 downto 13);
	unit_o		<= bcd(12 downto 9);
end process;

end Behavioral;