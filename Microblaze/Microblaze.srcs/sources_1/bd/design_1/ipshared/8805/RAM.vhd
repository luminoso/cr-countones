library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
	generic (   AddressBits : positive;
				DataBits    : positive);
	port (Clock        : in STD_LOGIC;
		  WriteAddress : in STD_LOGIC_VECTOR(AddressBits - 1 downto 0);
		  WriteEnable  : in STD_LOGIC;
		  DataIn       : in STD_LOGIC_VECTOR(DataBits - 1 downto 0);
		  ReadAddress  : in STD_LOGIC_VECTOR(AddressBits - 1 downto 0);
		  DataOut      : out STD_LOGIC_VECTOR(DataBits - 1 downto 0));
end RAM;

architecture Behavioral of RAM is

	type MemMatrix is array (0 to 2**AddressBits - 1) of STD_LOGIC_VECTOR (DataBits - 1 downto 0);
	signal Memory : MemMatrix := (others => x"00");

begin

	process(Clock)
	begin
		if rising_edge (Clock) then
			if WriteEnable = '1' then
				Memory(conv_integer(WriteAddress)) <= DataIn;
			end if;
			DataOut <= Memory(conv_integer(ReadAddress));
		end if;
	end process;

end Behavioral;

