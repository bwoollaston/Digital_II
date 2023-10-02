LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DFF IS
	PORT(
		i_EN, i_D	:	IN	std_logic;
		o_Q,o_Qbar	:	OUT std_logic
	);
END DFF;

ARCHITECTURE arch OF DFF IS
	SIGNAL s_in	:	std_logic_vector(1 DOWNTO 0);
	SIGNAL s_out:	std_logic_vector(1 DOWNTO 0) := "10";
	BEGIN
	s_in <= i_D & i_EN;
	o_Q <= s_out(1);
	o_Qbar <= s_out(0);
	WITH s_in SELECT
	 s_out <= 	"01" WHEN "01",
					"10" WHEN "10",
					i_D & not i_D WHEN OTHERS;
	 
END arch;