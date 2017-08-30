library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity segment_decoder is
	port(BCD      : in  std_logic_vector(3 downto 0); -- entrada
		 segments : out std_logic_vector(7 downto 1)); -- saída
end segment_decoder;
architecture Behavioral of segment_decoder is
begin
	segments <= "1000000" when BCD = "0000" else -- 0
		"1111001" when BCD = "0001" else -- 1
		"0100100" when BCD = "0010" else -- 2
		"0110000" when BCD = "0011" else -- 3
		"0011001" when BCD = "0100" else -- 4
		"0010010" when BCD = "0101" else -- 5
		"0000010" when BCD = "0110" else -- 6
		"1111000" when BCD = "0111" else -- 7
		"0000000" when BCD = "1000" else -- 8
		"0010000" when BCD = "1001" else -- 9
		"0001000" when BCD = "1010" else -- a
		"0000011" when BCD = "1011" else -- b
		"1000110" when BCD = "1100" else -- c
		"0100001" when BCD = "1101" else -- d
		"0000110" when BCD = "1110" else -- e
		"0001110" when BCD = "1111" else -- f
		"1111111";                      -- todos os segmentos são passivos
end Behavioral;