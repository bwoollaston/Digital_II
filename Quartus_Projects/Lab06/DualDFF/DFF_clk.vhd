LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DFF_clk IS
  PORT(
    --INPUTS: Preset, clear, clock, D
    i_LPR,i_LCLR,i_CLK,i_D  : IN  std_logic;

    --OUTPUTS: Q, Qbar
    o_Q,o_Qbar  : OUT std_logic
	 );
END DFF_clk;

ARCHITECTURE arch OF DFF_clk IS
	SIGNAL Qinternal	:	std_logic;	--internal signal vector <Q,Qbar>
	BEGIN
	PROCESS(i_CLK,i_LPR,i_LCLR)
		BEGIN
		--IF(i_LCLR='0' OR i_LPR='0') THEN
			IF(i_LCLR='0' AND i_LPR='0') THEN
				o_Q <= '1';
				o_Qbar <= '1';
			ELSIF(i_LCLR='0' AND i_LPR='1') THEN
				o_Qbar <= '1';
				o_Q <= '0';
			ELSIF(i_LPR='0' AND i_LCLR='1') THEN
				o_Q <= '1';
				o_Qbar <= '0';
			--END IF;
		ELSIF(i_CLK'EVENT and i_CLK='1') THEN
			o_Q <= i_D;
			o_Qbar <= not i_D;
	 END IF;
  END PROCESS;
END arch;
