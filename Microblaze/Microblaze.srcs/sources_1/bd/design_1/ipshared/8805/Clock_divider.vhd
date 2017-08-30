library IEEE;	-- in future VHDL modules we will assume including these libraries
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;		-- additional libraries	 
use IEEE.STD_LOGIC_UNSIGNED.ALL;	-- for conversion functions

entity clock_div is
generic 	(	how_fast			: integer := 0  );		
port 		( 	clk, reset		: in std_logic;
				divided_clk		: out std_logic	);
end clock_div;

architecture Behavioral of clock_div is
signal internal_clock : std_logic_vector (how_fast downto 0);
begin
process(clk, reset)
begin
if rising_edge(clk) then			
	if reset = '1' then 		-- synchronous reset
			internal_clock <= (others=>'0');
	else	internal_clock <= internal_clock+1;
	end if;
end if;
end process;	
divided_clk <= internal_clock(internal_clock'left) when falling_edge(clk); 
-- the leftmost bit of internal_clock
end Behavioral;


