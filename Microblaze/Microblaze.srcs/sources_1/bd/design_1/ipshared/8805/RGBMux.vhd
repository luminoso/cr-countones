library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Monitor.ALL;

entity RGBMux is
	generic (RedBits   : positive;
			 GreenBits : positive;
			 BlueBits  : positive);
	port (
		  TileRed       : in STD_LOGIC;
		  TileGreen     : in STD_LOGIC;
		  TileBlue      : in STD_LOGIC;
		  RedOut        : out STD_LOGIC_VECTOR(RedBits - 1 downto 0);
		  GreenOut      : out STD_LOGIC_VECTOR(GreenBits - 1 downto 0);
		  BlueOut       : out STD_LOGIC_VECTOR(BlueBits - 1 downto 0));
end RGBMux;

architecture Behavioral of RGBMux is

begin

	Generate_Red: for r in RedOut'range generate
		RedOut(r) <= TileRed;
	end generate;

	Generate_Green: for g in GreenOut'range generate
		GreenOut(g) <= TileGreen;
	end generate;

	Generate_Blue: for b in BlueOut'range generate
		BlueOut(b) <= TileBlue;
	end generate;

end Behavioral;
