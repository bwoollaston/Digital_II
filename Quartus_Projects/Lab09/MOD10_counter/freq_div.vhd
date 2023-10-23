LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Freq_div IS
	GENERIC(
		c_MAX : INTEGER := 50000000
	);
	PORT(
		i_CLK_IN		: IN	std_logic;
		o_CLK_OUT	: OUT std_logic
	);
END Freq_div;

ARCHITECTURE arch OF Freq_div IS
	SIGNAL r_VAL_reg	: unsigned(63 DOWNTO 0) := (OTHERS=>'0');
	SIGNAL r_VAL_next : unsigned(63 DOWNTO 0) := (OTHERS=>'0');
	BEGIN
	
	PROCESS(i_CLK_IN)
		BEGIN
		IF(i_CLK_IN'EVENT AND i_CLK_IN='0') THEN
			r_VAL_reg <= r_VAL_next;
		END IF;
	END PROCESS;
	
	-- NEXT STATE LOGIC
	r_VAL_next	<= (OTHERS=>'0') 	WHEN r_VAL_reg = to_unsigned(c_MAX,64) ELSE (r_VAL_reg+1);
	o_CLK_OUT 	<= '1' 				WHEN r_VAL_reg = to_unsigned(c_MAX,64) ELSE '0';			
	
END arch;