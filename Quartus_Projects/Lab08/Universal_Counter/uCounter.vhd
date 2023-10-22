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
	SIGNAL s_inputs	:	std_logic_vector(3 DOWNTO 0);		-- Inputs signals <>
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
	s_inputs <= i_CLR & i_LD & i_EN & i_UP;	--conctinate the inputs for with-select logic
	WITH s_inputs SELECT
		r_next <= (OTHERS=>'0') WHEN	"1000" | "1001" | "1010" | "1011"	|
																	"1100" | "1101" | "1110" | "1111" ,
							unsigned(i_D) WHEN	"0100" | "0101" | "0110" | "0111" ,
							(r_reg + 1)		WHEN	"0011",
							(r_reg - 1)		WHEN	"0010",
							r_reg					WHEN	OTHERS;

	o_Q <= std_logic_vector(r_reg);
	o_MAX_TICK <= '1' WHEN r_reg=(2**N-1) ELSE '0';
	o_MIN_TICK <= '1' WHEN r_reg=0 ELSE '0';
END arch;
