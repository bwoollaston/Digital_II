LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY uCounter IS
	GENERIC(N	:	INTEGER := 8);
	PORT(
		--clock inputs
		i_CLK										:	IN 	std_logic;

		--asynchronous inputs
		i_aRST									:	IN 	std_logic;

		--synchronous inputs
		i_CLR,i_LD,i_EN,i_UP		:	IN 	std_logic;
		i_D											:	IN	std_logic_vector(N-1 DOWNTO 0);

		--outputs
		o_MIN_TICK, o_MAX_TICK	:	OUT	std_logic;
		o_Q											:	OUT	std_logic_vector(N-1 DOWNTO 0)
	);
END uCounter;

ARCHITECTURE arch OF uCounter IS
	SIGNAL r_reg		:	unsigned(N-1 DOWNTO 0);
	SIGNAL r_next		:	unsigned(N-1 DOWNTO 0);
	BEGIN
		PROCESS(i_CLK, i_aRST)
		BEGIN
			IF(i_aRST='1') THEN
				r_reg <= (OTHERS=>'0');
			ELSIF(i_CLK'EVENT AND i_CLK='1') THEN
				r_reg <= r_next;
			END IF;
		END PROCESS;

	--NEXT STATE LOGIC
	PROCESS(i_CLR, i_LD, i_EN, i_UP)
	BEGIN
		IF(i_CLR='1') THEN
			r_next <= (OTHERS=>'0');
		ELSIF(i_LD='1') THEN
			r_next <= unsigned(i_D);
		ELSIF(i_EN='1')	THEN
			IF	(i_UP='1') THEN
				r_next <= (r_reg + 1);
			ELSE	
				r_next <= (r_reg - 1);
			END IF;
		ELSE
			r_next <= r_reg;
		END IF;
	END PROCESS;

	o_Q <= std_logic_vector(r_reg);
	o_MAX_TICK <= '1' WHEN r_reg=(2**N-1) ELSE '0';
	o_MIN_TICK <= '1' WHEN r_reg=0 ELSE '0';
END arch;
