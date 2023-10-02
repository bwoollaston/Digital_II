LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY nand_latch IS
	PORT(
	i_S, i_R	:	IN		std_logic;
	o_Q		:	BUFFER	std_logic := '0';
	o_Qbar	:	BUFFER	std_logic := '1'
	);
END nand_latch;

ARCHITECTURE arch OF nand_latch IS
	BEGIN
		o_Q <= i_S NAND o_Qbar;
		o_Qbar <= i_R NAND o_Q;
END arch;