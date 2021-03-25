----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:25:25 04/28/2020 
-- Design Name: 
-- Module Name:    TOP - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is

 port (
        --Inputs
        inputA_i : in std_logic_vector(4-1 downto 0);     --  A switch channel
        inputB_i : in std_logic_vector(4-1 downto 0);     --  B switch channel
        control_i : in std_logic_vector(4-1 downto 0);  -- control switch channel
        carry_i : in std_logic;                           
     
        clk_i : in std_logic;                             

        -- Outputs
        carry_o : out std_logic;                          -- carry out
        carry_in_o : out std_logic;                       -- carry in 
        parity_o : out std_logic;                         -- parit
        A_o : out std_logic_vector(4-1 downto 0);    -- A LEDs
        B_o : out std_logic_vector(4-1 downto 0);    -- B LEDs
        control_o : out std_logic_vector(4-1 downto 0); -- control LEDs 
        result_o : out std_logic_vector(4-1 downto 0);  -- result LEDs
        disp_digit_o : out std_logic_vector(4-1 downto 0);  -- selection of digit
        disp_seg_o  : out std_logic_vector(7-1 downto 0)   -- 7-segment
    );
	 
end TOP;

architecture Behavioral of TOP is
    constant C_NBIT : natural := 7; -- clock bits
    signal resultALU : std_logic_vector(4-1 downto 0);  -- total result
	 -- Carry
    signal resultCarry : std_logic;   
	 signal resultCarryAdd: std_logic;
	 signal resultCarrySubstract :std_logic; 
    signal resultCarryIncrement :std_logic; 
	 signal resultCarryDecrement :std_logic; 
	 signal resultCarryAddCarry :std_logic; 
	 signal resultCarrySubtractCarry : std_logic; 
    signal resultCarryRotateRight :std_logic; 
	 signal resultCarryRotateLeft :std_logic;  
	 signal resultCarryRotateRightCarry :std_logic;  
	 signal resultCarryRotateLeftCarry :std_logic; 
	 signal resultCarryMultiplication : std_logic;
	 
	 -- Add        0x0
    signal resultAdd : std_logic_vector(4-1 downto 0);
	 
	 -- Adder with carry    0x1    
    signal resultAddCarry : std_logic_vector(4-1 downto 0);
	 
	 -- Substract        0x2
    signal resultSubstract : std_logic_vector(4-1 downto 0);  
	 
	 -- Substract with carry   0x3
    signal resultSubstractCarry : std_logic_vector(4-1 downto 0); 
	 
	  -- Multiplication       0x4
    signal resultMultiplication : std_logic_vector(4-1 downto 0); 
	 
	 -- Increment 0x5
    signal resultIncrement : std_logic_vector(4-1 downto 0);
	 
	 -- Decrement        0x6	 
    signal resultDecrement : std_logic_vector(4-1 downto 0);
	  
	  -- Conjunction      0x7	 
    signal resultConjunction : std_logic_vector(4-1 downto 0);  
	 
	 -- Disjunction       0x8
    signal resultDisjunction : std_logic_vector(4-1 downto 0);  
	   
	 -- XOR      0x9
    signal resultExDisjunction : std_logic_vector(4-1 downto 0);
	 
	 -- Negation       0xA    
    signal resultNegation : std_logic_vector(4-1 downto 0); 
	 
	 -- Rotate right       0xB	 
    signal resultRotateRight : std_logic_vector(4-1 downto 0); 
	 
	  -- Rotate right with carry   0xC    
    signal resultRotateRightCarry : std_logic_vector(4-1 downto 0);
	 
	 -- Rotate left      0xD    
    signal resultRotateLeft : std_logic_vector(4-1 downto 0); 
	 
    -- Rotate left with carry   0xE
    signal resultRotateLefttCarry : std_logic_vector(4-1 downto 0);  
	 
	 -- Bitswap  0xF
    signal resultBitSwap : std_logic_vector(4-1 downto 0); 
	
    
begin
    -- LED A
    A_o <= inputA_i;
    -- LED B
    B_o <= inputB_i;
    -- LED control
    control_o <= control_i;
    -- LED result
    result_o <= resultALU;
    -- LED carry input
    carry_in_o <=  not (carry_i);
    -- Carry output
    carry_o <= not resultCarry;
   
    -- Display output
		--choose if digit
	 disp_digit_o <="1110";  --active in 0
	 
	 ProcessHexTo7seg: entity work.hexTo7seg
	 port map (
	 --Inputs
	 hex_i =>resultALU,
	 
	 --outputs
	 seg_o => disp_seg_o
    );
    
    -- Parity of result
    ProcessParity: entity work.parity
    port map (
        -- OUT from ALU
        A_i => resultALU,
        -- Parity OUT
        Y_o => parity_o
    ); 
    
    -- Adder
    ProcessAdder: entity work.fourAdder
    port map (
        -- Inputs
        A_i => inputA_i,
        B_i => inputB_i,
        C_i => '0',
        -- Outputs
        Y_o => resultAdd,
        C_o => resultCarryAdd
    );
	 
    -- Adder with carry
    ProcessAdderCarry: entity work.adderCarry
    port map (
        -- Inputs
        A_i => inputA_i,
        B_i => inputB_i,
        C_i => carry_i,
        -- Outputs
        Y_o => resultAddCarry,
        C_o => resultCarryAddCarry
    );
	 
    -- Substract
    ProcessSubstract: entity work.substraction
    port map (
        -- Inputs
        A_i => inputA_i,
        B_i => inputB_i,
        C_i => '0',
        -- Outputs
        Y_o => resultSubstract,
        C_o => resultCarrySubstract
    );
	 
    -- Substraction with carry
    ProcessSubstractionCarry: entity work.substractionCarry
    port map (
        -- Inputs
        A_i => inputA_i,
        B_i => inputB_i,
        C_i => carry_i,
        -- Outputs
        Y_o => resultSubstractCarry,
        C_o => resultCarrySubtractCarry
    );
    
	 -- Multiply
    ProcessMultiplication: entity work.multiplication
    port map (
       -- Inputs
       A_i => inputA_i,
       B_i => inputB_i,
       -- Output
       Y_o => resultMultiplication,
       C_o => resultCarryMultiplication
    );
	 
    -- Increment
    ProcessIncrement: entity work.increment
    port map (
        -- Inputs
        A_i => inputA_i,
        C_i => '0',
        -- Outputs
        Y_o => resultIncrement,
        C_o => resultCarryIncrement
    );
    
    -- Decrement
    ProcessDecrement: entity work.decrement
    port map (
        -- Inputs
        A_i => inputA_i,
        C_i => '0',
        -- Outputs
        Y_o => resultDecrement,
        C_o => resultCarryDecrement
    );
    
    
     -- Conjunction
   ProcessConjunction: entity work.conjunction
    port map (
        -- Inpputs
        A_i => inputA_i,
        B_i => inputB_i,
        -- Outputs
        Y_o => resultConjunction
    );
	 
    -- Disjuncion - OR
    ProcessDisjunction: entity work.disjunction
    port map (
        -- Inputs
        A_i => inputA_i,
        B_i => inputB_i,
        -- Output
        Y_o => resultDisjunction
    );
   
    -- EXdisjunction - XOR
    ProcessExDisjunction: entity work.exDisjunction
    port map (
        -- Inputs
        A_i => inputA_i,
        B_i => inputB_i,
        -- vystup
        Y_o => resultExDisjunction   
    );
    
    -- Negation
    ProcessNegation: entity work.negation
    port map (
        -- Inputs
        A_i => inputA_i,
        -- Outputs
        Y_o => resultNegation
    );    
    
    -- Rotate right
    ProcessRotateRight: entity work.rotateRight
    port map (
       -- Inputs
       A_i => inputA_i,
       -- Outputs
       Y_o => resultRotateRight,
       C_o => resultCarryRotateRight
    );
    
	    -- Rotate right - carry
    ProcessRotateRigtCarry: entity work.rotateRightCarry
    port map (
       -- Inputs
       A_i => inputA_i,
       C_i => carry_i,
       -- Outputs
       Y_o => resultRotateRightCarry,
       C_o => resultCarryRotateRightCarry
    );
	 
    -- Rotate Left
    ProcessRotateLeft: entity work.rotateLeft
    port map (
       -- Inputs
       A_i => inputA_i,
       -- Outputs
       Y_o => resultRotateLeft,
       C_o => resultCarryRotateLeft
    );
       
    -- Rotate left - carry
    ProcessRotateLeftCarry: entity work.rotateLeftCarry
    port map (
       -- Inputs
       A_i => inputA_i,
       C_i => carry_i,
       -- Outputs
       Y_o => resultRotateLefttCarry,
       C_o => resultCarryRotateLeftCarry
    );
    
    -- Bitswap
    ProcessBitSwap: entity work.bitswap
    port map (
       -- Inputs
       A_i => inputA_i,
       -- output
       Y_o => resultBitSwap
    );   
    
    
    
    -- choose result
    with control_i select
        resultALU <=  resultAdd when x"0",
							 resultAddCarry when x"1",
                      resultSubstract when x"2",
							 resultSubstractCarry when x"3",
							 resultMultiplication when x"4",
                      resultIncrement when x"5",
                      resultDecrement when x"6",
                      resultConjunction when x"7",
                      resultDisjunction when x"8",
                      resultExDisjunction when x"9",
                      resultNegation when x"A",
                      resultRotateRight when x"B",
							 resultRotateRightCarry when x"C",
                      resultRotateLeft when x"D",
                      resultRotateLefttCarry when x"E",
                      resultBitSwap when x"F",
                      
                      x"0" when others;
     
     -- choose carry
     with control_i select
         resultCarry <= resultCarryAdd when x"0",
								resultCarryAddCarry when x"1",
								resultCarrySubstract when x"2",
								resultCarrySubtractCarry when x"3",
								resultCarryMultiplication when x"4",
								resultCarryIncrement when x"5",
								resultCarryDecrement when x"6",
								resultCarryRotateRight when x"B",
								resultCarryRotateRightCarry when x"C",
								resultCarryRotateLeft when x"D",
								resultCarryRotateLeftCarry when x"E", 
                     '0' when others;            

end Behavioral;

