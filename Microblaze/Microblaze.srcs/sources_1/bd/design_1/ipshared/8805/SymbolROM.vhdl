library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Monitor.ALL;

entity SymbolROM is
	port (SymbolPos   : in STD_LOGIC_VECTOR(7 downto 0);
		  LineAddress : in STD_LOGIC_VECTOR(3 downto 0);
		  Data        : out STD_LOGIC_VECTOR(0 to 7));
end SymbolROM;

architecture Behavioral of SymbolROM is

	signal Address : natural range 0 to 126;

begin

	Address <= conv_integer(SymbolPos);
	Data <= PixelMap(Address, conv_integer(LineAddress));

end Behavioral;
