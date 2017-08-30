library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Monitor.ALL;

entity VGATileMatrix is
	generic (PixelXBits  : natural;
			 PixelYBits  : natural;
			 AddressBits : natural);
	port (Reset       : in STD_LOGIC;
		  Clock       : in STD_LOGIC;
		  PixelX      : in STD_LOGIC_VECTOR(PixelXBits - 1 downto 0);
		  PixelY      : in STD_LOGIC_VECTOR(PixelYBits - 1 downto 0);
		  ROMData     : in STD_LOGIC_VECTOR(0 to 7);
		  LineAddress : out STD_LOGIC_VECTOR(3 downto 0);
		  ReadAddress : out STD_LOGIC_VECTOR(AddressBits - 1 downto 0);
		  TileRed     : out STD_LOGIC;
		  TileGreen   : out STD_LOGIC;
		  TileBlue    : out STD_LOGIC);
		  
end VGATileMatrix;

architecture Behavioral of VGATileMatrix is

	signal TileCol   : natural range 0 to CHARWIDTH - 1;
	signal TileRow   : natural range 0 to CHARHEIGHT - 1;
	signal MatrixCol : natural range 0 to TEXTCOLUMNS - 1;
	signal MatrixRow : natural range 0 to TEXTROWS - 1;
	signal PixelData : STD_LOGIC_VECTOR(0 to ROMData'length - 1);

begin

	process(Reset, Clock)
	begin
		if Reset = '1' then
			TileCol <= 0;
			MatrixCol <= 0;
		elsif rising_edge(Clock) then
			if PixelX > HBP - CHARWIDTH and PixelX <= HAV then
				if TileCol = CHARWIDTH - 1 then
					TileCol <= 0;
					MatrixCol <= MatrixCol + 1;
				else
					TileCol <= TileCol + 1;
				end if;
			else
				TileCol <= 0;
				MatrixCol <= 0;
			end if;
		end if;
	end process;

	process(Reset, Clock)
	begin
		if Reset = '1' then
			TileRow <= 0;
			MatrixRow <= 0;
		elsif rising_edge(Clock) then
			if PixelX = HP then
				if PixelY > VBP and PixelY <= VAV then
					if TileRow = CHARHEIGHT - 1 then
						TileRow <= 0;
						MatrixRow <= MatrixRow + 1;
					else
						TileRow <= TileRow + 1;
					end if;
				else
					TileRow <= 0;
					MatrixRow <= 0;
				end if;
			end if;
		end if;
	end process;

	LineAddress <= conv_std_logic_vector(TileRow, LineAddress'length);
	ReadAddress <= conv_std_logic_vector(MatrixRow * TEXTCOLUMNS + MatrixCol, ReadAddress'length);

	process(Reset, Clock)
	begin
		if Reset = '1' then
			PixelData <= (others => '0');
		elsif rising_edge(Clock) then
			if TileCol = 0 then
				PixelData <= ROMData;
			else
				PixelData <= PixelData(1 to CHARWIDTH - 1) & '0';
			end if;
		end if;
	end process;

	TileRed <= PixelData(0);
	TileGreen <= PixelData(0);
	TileBlue <= '1';

end Behavioral;
