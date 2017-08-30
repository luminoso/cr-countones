library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity EightDisplayControl is
	port(clk                 : in  std_logic;
		 leftL, near_leftL   : in  std_logic_vector(3 downto 0);
		 near_rightL, rightL : in  std_logic_vector(3 downto 0);
		 leftR, near_leftR   : in  std_logic_vector(3 downto 0);
		 near_rightR, rightR : in  std_logic_vector(3 downto 0);
		 select_display      : out std_logic_vector(7 downto 0);
		 segments            : out std_logic_vector(6 downto 0));
end EightDisplayControl;
architecture Behavioral of EightDisplayControl is
	signal Display    : std_logic_vector(2 downto 0);
	signal div        : std_logic_vector(16 downto 0);
	signal convert_me : std_logic_vector(3 downto 0);
begin
	div     <= div + 1 when rising_edge(clk);
	Display <= div(16 downto 14);
	process(Display, leftL, near_leftL, near_rightL, rightL, leftR, near_leftR, near_rightR, rightR)
	begin                               -- ativação sequencial dos displays
		if Display = "111" then
			select_display <= "01111111";
			convert_me     <= leftL;
		elsif Display = "110" then
			select_display <= "10111111";
			convert_me     <= near_leftL;
		elsif Display = "101" then
			select_display <= "11011111";
			convert_me     <= near_rightL;
		elsif Display = "100" then
			select_display <= "11101111";
			convert_me     <= rightL;
		elsif Display = "011" then
			select_display <= "11110111";
			convert_me     <= leftR;
		elsif Display = "010" then
			select_display <= "11111011";
			convert_me     <= near_leftR;
		elsif Display = "001" then
			select_display <= "11111101";
			convert_me     <= near_rightR;
		else
			select_display <= "11111110";
			convert_me     <= rightR;
		end if;
	end process;
	decoder : entity work.segment_decoder -- descodificador de segmentos
		port map(convert_me, segments);
end Behavioral;