------------------------------------------------------------------------
--
-- Implementation of 4-bit adder.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
entity top is
    port (SW0_CPLD:   in  std_logic;        -- Input A
          SW1_CPLD:   in  std_logic;
          SW2_CPLD:   in  std_logic;
          SW3_CPLD:   in  std_logic;
          SW8_CPLD:   in  std_logic;        -- Input B
          SW9_CPLD:   in  std_logic;
          SW10_CPLD:  in  std_logic;
          SW11_CPLD:  in  std_logic;
          disp_seg_o: out std_logic_vector(7-1 downto 0);
          disp_dig_o: out std_logic_vector(4-1 downto 0));
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    signal s_dataA, s_dataB: std_logic_vector(4-1 downto 0);
    signal s_carry0, s_carry1, s_carry2: std_logic;
    signal s_result: std_logic_vector(4-1 downto 0);
    signal s_carryOut: std_logic;
begin

    -- Combine two 4-bit inputs to internal signals s_dataA and s_dataB
    -- WRITE YOUR CODE HERE


    --------------------------------------------------------------------
    -- Sub-blocks of four full_adders
    FULLADDER0: entity work.full_adder
        port map (-- <component_signal> => actual_signal,
                  -- <component_signal> => actual_signal,
                  -- ...
                  -- <component_signal> => actual_signal);
                  -- WRITE YOUR CODE HERE
                 );

    FULLADDER1: entity work.full_adder
        port map (
                  -- WRITE YOUR CODE HERE
                 );

    FULLADDER2: entity work.full_adder
        port map (
                  -- WRITE YOUR CODE HERE
                 );

    FULLADDER3: entity work.full_adder
        port map (
                  -- WRITE YOUR CODE HERE
                 );


    --------------------------------------------------------------------
    -- Sub-block of hex_to_7seg entity
    HEX2SSEG: entity work.hex_to_7seg
        port map (
                  -- WRITE YOUR CODE HERE
                  );

    -- Select display position
    disp_dig_o <= "1110";


    -- Show carry output bit on Coolrunner-II LED
    -- WRITE YOUR CODE HERE

    -- Show two 4-bit inputs on CPLD expansion LEDs
    -- WRITE YOUR CODE HERE

end architecture Behavioral;