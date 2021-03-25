--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:24:08 04/30/2020
-- Design Name:   
-- Module Name:   C:/Users/Ales Michalek/Desktop/KostelanskaMichalek/ALU/Testbench.vhd
-- Project Name:  ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOP
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Testbench IS
END Testbench;
 
ARCHITECTURE behavior OF Testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP
    PORT(
         inputA_i : IN  std_logic_vector(3 downto 0);
         inputB_i : IN  std_logic_vector(3 downto 0);
         control_i : IN  std_logic_vector(3 downto 0);
         carry_i : IN  std_logic;
         clk_i : IN  std_logic;
         carry_o : OUT  std_logic;
         carry_in_o : OUT  std_logic;
         parity_o : OUT  std_logic;
         A_o : OUT  std_logic_vector(3 downto 0);
         B_o : OUT  std_logic_vector(3 downto 0);
         control_o : OUT  std_logic_vector(3 downto 0);
         result_o : OUT  std_logic_vector(3 downto 0);
         disp_digit_o : OUT  std_logic_vector(3 downto 0);
         disp_seg_o : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal inputA_i : std_logic_vector(3 downto 0) := "0101";
   signal inputB_i : std_logic_vector(3 downto 0) := "0010";
   signal control_i : std_logic_vector(3 downto 0) := "0000";
   signal carry_i : std_logic := '0';
   signal clk_i : std_logic := '0';

 	--Outputs
   signal carry_o : std_logic;
   signal carry_in_o : std_logic;
   signal parity_o : std_logic;
   signal A_o : std_logic_vector(3 downto 0);
   signal B_o : std_logic_vector(3 downto 0);
   signal control_o : std_logic_vector(3 downto 0);
   signal result_o : std_logic_vector(3 downto 0);
   signal disp_digit_o : std_logic_vector(3 downto 0);
   signal disp_seg_o : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP PORT MAP (
          inputA_i => inputA_i,
          inputB_i => inputB_i,
          control_i => control_i,
          carry_i => carry_i,
          clk_i => clk_i,
          carry_o => carry_o,
          carry_in_o => carry_in_o,
          parity_o => parity_o,
          A_o => A_o,
          B_o => B_o,
          control_o => control_o,
          result_o => result_o,
          disp_digit_o => disp_digit_o,
          disp_seg_o => disp_seg_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
