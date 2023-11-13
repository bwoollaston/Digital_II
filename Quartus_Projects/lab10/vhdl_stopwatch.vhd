LIBRARY IEEE;
LIBRARY altera;
USE IEEE.std_logic_1164.all;
USE altera.maxplus2.all;

ENTITY vhdl_stopwatch IS
	PORT(
		i_CLR, i_Start_Stop, i_CLK_50MHz : IN std_logic;
		o_CO : OUT std_logic;
		o_sDSP, o_100msDSP : OUT std_logic_vector(7 DOWNTO 0)
	);
END vhdl_stopwatch;

ARCHITECTURE arch OF vhdl_stopwatch IS
	CONSTANT Vcc : std_logic := '1';
	CONSTANT GND : std_logic := '0';
	-- Clock Signal
	SIGNAL s_CLK_10Hz : std_logic;
	-- Pre Counter Signals
	SIGNAL s_jkff_Q : std_logic;
	-- Post Counter / Pre Seven Seg Signals
	SIGNAL s_CO : std_logic;
	SIGNAL s_100ms_count, s_1s_count : std_logic_vector(3 DOWNTO 0);
	
	BEGIN
	--Instantiated using old method
	comp_jkff : jkff 
		PORT MAP( 
			CLK => not i_Start_Stop, 
			J => Vcc, 
			K => Vcc, 
			PRN => Vcc, 
			CLRN => i_CLR, 
			Q => s_jkff_Q
		);
	
	--Instantiated using new method
	comp_freq_div : ENTITY work.freq_div(a) 	
		PORT MAP(
			clock_50Mhz  => i_CLK_50MHz,
			clock_10Hz => s_CLK_10Hz
		);
	
	comp_100ms_counter : ENTITY work.MOD10_Count(arch) 
		GENERIC MAP(N=>4)
		PORT MAP(	
			i_CLK		=> s_CLK_10Hz,
			i_LD 		=> GND,
			i_D		=> (OTHERS=>'0'),
			i_EN 		=> s_jkff_Q,
			i_aRST 	=> not i_CLR,
			o_CO 		=> s_CO,
			o_Q 		=> s_100ms_count
		);
	
	comp_1s_counter : ENTITY work.MOD10_Count(arch) 
		GENERIC MAP(N=>4)
		PORT MAP(
			i_CLK		=> s_CLK_10Hz,
			i_LD 		=> GND,
			i_D		=> (OTHERS=>'0'),
			i_EN 		=> s_CO,
			i_aRST 	=> not i_CLR,
			o_CO 		=> o_CO,
			o_Q		=> s_1s_count
		);
	
	comp_100ms_dsp : ENTITY work.sevenSeg(arch)
		PORT MAP(
			i_inputs  => s_100ms_count,
			o_display => o_100msDSP
		);
	
	comp_1s_dsp : ENTITY work.sevenSeg(arch)
		PORT MAP(
			i_inputs  => s_1s_count,
			o_display => o_sDSP
		);
	
END arch;