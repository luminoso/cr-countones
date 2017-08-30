-- Exercício 3.1. Descrever um circuito que permite encontrar o número máximo de uns consecutivos num vetor
-- binário sw(15 downto 0). Usar máquinas de estados finitos. Mostrar o resultado em displays de segmentos
-- em decimal e hexadecimal. Usar IP block integrator. 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Count_Ones is
	generic(number_of_bits : integer := 256);
	port(clk  : in  std_logic;
		 BTNC : in  std_logic;
		 data_in   : in  STD_LOGIC_VECTOR(255 downto 0);
		 finish : out std_logic;
		 data_out  : out STD_LOGIC_VECTOR(8 downto 0));
end Count_Ones;
architecture Behavioral of Count_Ones is
	type state_type is (initial_state, final_state); -- enumeração de estados
	signal C_S, N_S                : state_type;
	signal N_Finish : std_logic;
	signal index, next_index       : integer range 0 to number_of_bits - 1;
	signal Res, next_Res           : integer range 0 to number_of_bits;
	signal n_o_ones, next_n_o_ones : integer range 0 to number_of_bits;
begin
	process(clk)                        -- processo sequencial
	begin
		if rising_edge(clk) then
			if (btnC = '1') then
				C_S      <= initial_state;
				index    <= 0;
				n_o_ones <= 0;
				Res      <= 0;
				finish <= '0';
			else
				C_S      <= N_S;
				index    <= next_index; -- índice do vetor
				n_o_ones <= next_n_o_ones; -- número de uns
				Res      <= next_Res;   -- resultado
			    finish <= N_Finish;
			end if;
		end if;
	end process;
	process(C_S, data_in, index, n_o_ones, Res) -- processo combinatório
	begin
		N_S           <= C_S;
		next_index    <= index;
		next_n_o_ones <= n_o_ones;
		next_Res      <= Res;
		case C_S is
			when initial_state => next_index <= index + 1;
				N_S           <= initial_state;
				
				if data_in(index) = '0' then
				    if n_o_ones > Res then
				        next_Res <= n_o_ones;
				    end if;
				    next_n_o_ones <= 0;
    			else
				    next_n_o_ones <= n_o_ones + 1;
				    if n_o_ones+1 > Res then
                        next_Res <= n_o_ones+1;
                    end if;
				end if;
                                    
				if (index = number_of_bits - 1) then
					N_S <= final_state;
				end if;
			when final_state => N_S <= initial_state;
				next_Res       <= Res;
				next_n_o_ones  <= 0;
				next_index     <= 0;
				N_Finish <= '1';
			when others => N_S <= initial_state;
		end case;
	end process;
	data_out <= conv_std_logic_vector(Res, 9); -- resultado
end Behavioral;