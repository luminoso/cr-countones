library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Monitor.ALL;

entity VGA_for_block is
	port (
		   clk 			    : in STD_LOGIC;
           RAMData          : in std_logic_vector(0 to 7);
           btnC             : in STD_LOGIC;
		   HSync     	    : out STD_LOGIC;
		   VSync     	    : out STD_LOGIC;
		   VGARed    	    : out STD_LOGIC_VECTOR(3 downto 0);
		   VGAGreen  	    : out STD_LOGIC_VECTOR(3 downto 0);
		   VGABlue   	    : out STD_LOGIC_VECTOR(3 downto 0);
		   RAMWriteAddress 	: in STD_LOGIC_VECTOR(12 downto 0) ); -- (ADDRESSLENGTH - 1 downto 0) );
end VGA_for_block;

architecture Behavioral of VGA_for_block is
	
	constant PIXELXLENGTH  : natural := BitsNecessary(HP);
	constant PIXELYLENGTH  : natural := BitsNecessary(VP);

	signal Clock50In 			: STD_LOGIC;
	signal ClockVGA         : STD_LOGIC;
	signal Locked           : STD_LOGIC;
	signal Reset            : STD_LOGIC;
	signal PixelX           : STD_LOGIC_VECTOR(PIXELXLENGTH - 1 downto 0);
	signal PixelY           : STD_LOGIC_VECTOR(PIXELYLENGTH -1 downto 0);
	signal VideoONBadTiming : STD_LOGIC;
	signal HSyncBadTiming   : STD_LOGIC;
	signal VSyncBadTiming   : STD_LOGIC;
	signal WriteAddress     : STD_LOGIC_VECTOR(ADDRESSLENGTH - 1 downto 0);
	signal ReadAddress      : STD_LOGIC_VECTOR(ADDRESSLENGTH - 1 downto 0);
	signal SymbolPos        : STD_LOGIC_VECTOR(7 downto 0);
	signal ROMData          : STD_LOGIC_VECTOR(0 to 7);
	signal LineAddress      : STD_LOGIC_VECTOR(3 downto 0);
	signal TileRed          : STD_LOGIC;
	signal TileGreen        : STD_LOGIC;
	signal TileBlue         : STD_LOGIC;
	signal ASCII            : STD_LOGIC_VECTOR(7 downto 0);
	
--	signal RAMData          : STD_LOGIC_VECTOR(0 to 7);
	signal RAMWriteEnable 	: STD_LOGIC;

begin


divider:	entity work.clock_div
port map		( 	clk, '0',Clock50In);

	Reset <= btnC;
	ClockVGA <= Clock50In;

	VGA_Synchronization: entity work.VGASync
		generic map (	    PixelXBits => PIXELXLENGTH,
							PixelYBits => PIXELYLENGTH)
		port map (	    Reset   => Reset,
						Clock   => ClockVGA,
						PixelX  => PixelX,
						PixelY  => PixelY,
						HSync   => HSync,
						VSync   => VSync);  

	VGA_RAM: entity work.RAM
		generic map (	    AddressBits     => ADDRESSLENGTH,
							DataBits        => 8)
		port map (	    Clock        => ClockVGA,
						WriteAddress => RAMWriteAddress,  -- address to write
						WriteEnable  => '1',
						DataIn       => RAMData,          -- ASCII code to write
						ReadAddress  => ReadAddress,
						DataOut      => SymbolPos);

	Symbol_ROM: entity work.SymbolROM
		port map (	SymbolPos   => SymbolPos,
						LineAddress => LineAddress,
						Data        => ROMData);

	VGA_Tile_Matrix: entity work.VGATileMatrix
		generic map (PixelXBits => PIXELXLENGTH,
					 PixelYBits => PIXELYLENGTH,
					 AddressBits => ADDRESSLENGTH)
		port map (	    Reset       => Reset,
						Clock       => ClockVGA,
						PixelX      => PixelX,
						PixelY      => PixelY,
						ROMData     => ROMData,
						LineAddress => LineAddress,
						ReadAddress => ReadAddress,
						TileRed     => TileRed,
						TileGreen   => TileGreen,
						TileBlue    => TileBlue);

	RGB_Multiplexer: entity work.RGBMux
		generic map (RedBits   => VGARed'length,
					 GreenBits => VGAGreen'length,
					 BlueBits  => VGABlue'length)
		port map (	TileRed       => TileRed,
						TileGreen     => TileGreen,
						TileBlue      => TileBlue,
						RedOut        => VGARed,
						GreenOut      => VGAGreen,
						BlueOut       => VGABlue);
end Behavioral;
