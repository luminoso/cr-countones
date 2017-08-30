library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Monitor.ALL;

entity VGASync is
	generic (PixelXBits : natural;
			 PixelYBits : natural);
	port (Reset   : in STD_LOGIC;
		  Clock   : in STD_LOGIC;
		  PixelX  : out STD_LOGIC_VECTOR(PixelXBits - 1 downto 0);
		  PixelY  : out STD_LOGIC_VECTOR(PixelYBits - 1 downto 0);
		  --VideoON : out STD_LOGIC;
		  HSync   : out STD_LOGIC;
		  VSync   : out STD_LOGIC);
end VGASync;

architecture Behavioral of VGASync is

	signal HCount : natural range 0 to HP;
	signal VCount : natural range 0 to VP;

begin

	process(Reset, Clock)
	begin
		if Reset = '1' then
			HCount <= 0;
			VCount <= 0;
		elsif rising_edge(Clock) then
			if HCount = HP then
				HCount <= 0;
				if VCount = VP then
					VCount <= 0;
				else
					VCount <= VCount + 1;
				end if;
			else
				HCount <= HCount + 1;
			end if;
		end if;
	end process;

	process(Reset, Clock)
	begin
		if Reset = '1' then
			HSync <= '0';
		elsif rising_edge(Clock) then
			if HCount > HFP and HCount <= HP then
				HSync <= HSP;
			else
				HSync <= not HSP;
			end if;
		end if;
	end process;

	process(Reset, Clock)
	begin
		if Reset = '1' then
			VSync <= '0';
		elsif rising_edge(Clock) then
				if VCount > VFP and VCount <= VP then
					VSync <= VSP;
				else
					VSync <= not VSP;
				end if;
		end if;
	end process;

	process(Reset, Clock)
	begin
		if Reset = '1' then
			--VideoON <= '0';
			PixelX <= (others => '0');
			PixelY <= (others => '0');
		elsif rising_edge(Clock) then
--			if HCount >  HBP  and HCount <= HAV and VCount > VBP and VCount <= VAV then
--				VideoON <= '1';
--			else
--				VideoON <= '0';
--			end if;
			PixelX <= conv_std_logic_vector(HCount, PixelX'length);
			PixelY <= conv_std_logic_vector(VCount, PixelY'length);
		end if;
	end process;

end Behavioral;
