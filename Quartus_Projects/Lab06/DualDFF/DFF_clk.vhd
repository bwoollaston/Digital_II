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
	SIGNAL Qinternal	:	std_logic_vector(1 DOWNTO 0)	:=	"10";	--internal signal vector <Q,Qbar>
	BEGIN
	o_Q <= Qinternal(1);
	o_Qbar <= Qinternal(0);
	PROCESS(i_CLK,i_LPR,i_LCLR)
		BEGIN
		IF(i_LCLR='0' OR i_LPR='0') THEN
			Qinternal(0) <= not i_LCLR;
			Qinternal(1) <= not i_LPR;
		ELSIF(i_CLK'EVENT and i_CLK='1') THEN
			Qinternal(1) <= i_D;
			Qinternal(0) <= not i_D;
	 END IF;
  END PROCESS;
END arch;
