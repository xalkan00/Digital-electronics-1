----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:19:52 04/11/2020 
-- Design Name: 
-- Module Name:    UART_tx - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART_tx is
 
  port (
    clk_i       : in  std_logic;
    tx_dv_i     : in  std_logic;
    tx_byte_i   : in  std_logic_vector(7 downto 0);
    en_i        : in  std_logic;
    parity_i	 : in  std_logic;
	 double_stop : in  std_logic;
    
    res_en_o	 : out std_logic;
    tx_active_o : out std_logic;
    tx_serial_o : out std_logic;
    tx_done_o   : out std_logic
    );
    
end UART_tx;


architecture transmitter of UART_tx is

  type t_Main is (s_passive, s_tx_start_bit, s_tx_data_bits, s_tx_parity_even, s_tx_parity_odd, s_tx_stop_bit, s_clean);
  
  signal s_Main : t_Main  := s_passive;
  signal s_bit_index : integer range 0 to 7 := 0;
  signal s_one_bits  : integer range 0 to 7 := 0;
  signal s_tx_data   : std_logic_vector(7 downto 0) := (others => '0');
  signal s_tx_done   : std_logic := '0';
  signal s_double_control : integer range 0 to 1 := 0;
  
begin

  
  UART_tx : process (clk_i,en_i,parity_i)
  begin
    if rising_edge(clk_i) then
        
      case s_Main is

        when s_passive =>
          tx_active_o <= '0';
          tx_serial_o <= '1';  
          s_tx_done   <= '0';
          s_bit_index <= 0;
          s_one_bits  <= 0;

          if tx_dv_i = '0' then
            s_tx_data <= tx_byte_i;
            res_en_o <= '0';
            s_Main <= s_tx_start_bit;
          else
            s_Main <= s_passive;
          end if;

          
        -- activate start bit, start bit = 0
        when s_tx_start_bit =>
			 res_en_o 	 <= '1';
          tx_active_o <= '1';
          tx_serial_o <= '0';

        -- assigning start/data bits
          if en_i = '0' then
            s_Main   <= s_tx_start_bit;
          else
            s_Main   <= s_tx_data_bits;
          end if;

          
        -- activate data bits         
        when s_tx_data_bits =>
          tx_serial_o <= s_tx_data(s_bit_index);
          
          if en_i = '0' then
            s_Main   <= s_tx_data_bits;
          else
          	if s_tx_data(s_bit_index) = '1' then   -- parity counter
            	s_one_bits <= s_one_bits + 1;			
       		end if;
				
            if s_bit_index < 7 then						-- send next bit
              s_bit_index <= s_bit_index + 1;
              s_Main   <= s_tx_data_bits;
            else
					s_bit_index <= 0;
              if parity_i = '1' then 					-- choose parity
              	s_Main   <= s_tx_parity_even;
              else
              	s_Main   <= s_tx_parity_odd;
              end if;
            end if;
          end if;

		-- parity bit even
		when s_tx_parity_even =>
        
        	if (s_one_bits mod 2) < 1 then				-- parity counting
            	tx_serial_o <= '0';
             else
             	tx_serial_o <= '1';
        	end if;
            
            if en_i = '0' then
            	s_Main   <= s_tx_parity_even;
          	else
            	s_one_bits <= 0;
            	s_Main   <= s_tx_stop_bit;
          	end if;
            
        -- parity bit odd
        when s_tx_parity_odd =>
         
        	if (s_one_bits mod 2) < 1 then				-- parity counting
            	tx_serial_o <= '1';
             else
             	tx_serial_o <= '0';
        	end if;
            
            if en_i = '0' then
            	s_Main   <= s_tx_parity_odd;
          	else
            	s_one_bits <= 0;
            	s_Main   <= s_tx_stop_bit;
          	end if;


        -- active stop bit, stop bit = 1
        when s_tx_stop_bit =>
          tx_serial_o <= '1';

          if en_i = '0' then
            s_Main   <= s_tx_stop_bit;
          else
				if double_stop = '1' then			-- double stop bit
					if s_double_control < 1 then
						s_double_control <= s_double_control + 1;
						s_Main   <= s_tx_stop_bit;
					else
						s_Main   <= s_clean;
					end if;
				else
					s_tx_done   <= '1';
					s_Main   <= s_clean;
				end if;
          end if;

                  
        -- clean process
        when s_clean =>
          tx_active_o <= '0';
          s_tx_done   <= '1';
			 if tx_dv_i = '0' then
				s_Main <= s_clean;
			 else
				s_Main   <= s_passive;
		 	 end if;
          
        -- passive state    
        when others =>
          s_Main <= s_passive;

      end case;
    end if;
  end process UART_tx;

  tx_done_o <= s_tx_done;
  
end transmitter;
