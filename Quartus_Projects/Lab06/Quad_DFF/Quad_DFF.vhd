LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Quad_DFF IS
	PORT(
		i_EN12, i_EN34	:	IN	std_logic;
		i_D4	:	IN std_logic_vector(3 DOWNTO 0);
		o_Q4,o_Qbar4	:	OUT std_logic_vector(3 DOWNTO 0) 
	);
END Quad_DFF;

ARCHITECTURE arch OF Quad_DFF IS
	 SIGNAL s_ENvec	:	std_logic_vector(1 DOWNTO 0);
	 BEGIN
	 s_ENvec <= i_EN12 & i_EN34;
	 gen_d12:
	 FOR i IN 0 TO 1 GENERATE
		comp_D12	: ENTITY work.DFF(arch) PORT MAP(i_EN=>i_EN12, i_D=>i_D4(i), o_Q=>o_Q4(i), o_Qbar=>o_Qbar4(i));
		comp_D34	: ENTITY work.DFF(arch) PORT MAP(i_EN=>i_EN34, i_D=>i_D4(i+2), o_Q=>o_Q4(i+2), o_Qbar=>o_Qbar4(i+2));
	END GENERATE gen_d12;
END arch;