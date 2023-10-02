LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DFF_noCLK IS
	PORT(
		i_EN, i_D	:	IN	std_logic;
		o_Q,o_Qbar	:	OUT std_logic
	);
END DFF_noCLK;

ARCHITECTURE arch OF DFF_noCLK IS
	SIGNAL s_out : std_logic;
	BEGIN
	PROCESS(i_D,i_EN)
	BEGIN
	o_Q <= s_out;
	o_Qbar <= not s_out;
	IF(i_EN='1') THEN
		s_out <= i_D;
	END IF;
	END PROCESS;
END arch;