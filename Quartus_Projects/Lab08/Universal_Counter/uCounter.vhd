LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY uCounter IS
	GENERIC(N	:	INTEGER := 8);
	PORT(
		i_CLK,i_aRST,i_LD,i_EN	:	IN 	std_logic;
		o_MIN_TICK, o_MAX_TICK	:	OUT	std_logic;
		o_Q							:	OUT	std_logic_vector(N-1 DOWNTO 0)
	);
END uCounter;

ARCHITECTURE arch OF uCounter IS
	SIGNAL r_reg	:	unsigned(N-1 DOWNTO 0);
	SIGNAL r_next	:	unsigned(N-1 DOWNTO 0);
	BEGIN
		PROCESS(i_CLK, i_sRST)
		BEGIN
			IF(i_aRST) THEN
				r_reg <= (OTHERS=>'0');
			ELSIF(i_CLK'EVENT AND i_CLK='1') THEN
				r_reg <= r_next;
			END IF;
		END PROCESS;
	--NEXT STATE LOGIC
	
END arch;