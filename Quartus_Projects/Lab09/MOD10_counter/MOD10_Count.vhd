LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY MOD10_Count IS
	GENERIC(N :	INTEGER := 4 );
	PORT(
		i_CLK			:	IN		std_logic;
		i_aRST 		:	IN 	std_logic;
		i_EN,i_LD	:	IN 	std_logic;
		i_D			:	IN		std_logic_vector(N-1 DOWNTO 0);
		
		o_CO			:	OUT	std_logic;
		o_Q			:	OUT	std_logic_vector(N-1 DOWNTO 0)
		
	);
END MOD10_Count;

ARCHITECTURE arch OF MOD10_Count IS
	SIGNAL s_CLK_1Hz	:	std_logic := '0';
	SIGNAL r_reg		:	unsigned(N-1 DOWNTO 0);
	SIGNAL r_next		:	unsigned(N-1 DOWNTO 0);
	
	BEGIN
	
	--Instantiate 50MHz -> 1Hz Freq Divider
	freq_div_inst : ENTITY work.freq_div(a)
	PORT MAP(clock_50Mhz=>i_CLK, clock_1Hz=>s_CLK_1Hz);
	
	PROCESS(s_CLK_1Hz, i_aRST)
	BEGIN
		IF(i_aRST='1') THEN
				r_reg <= (OTHERS=>'0');
		ELSIF(s_CLK_1Hz'EVENT AND s_CLK_1Hz='0') THEN
				r_reg <= r_next;
		END IF;
	END PROCESS;
	
	PROCESS(i_EN, i_LD)
	BEGIN
	
		IF(i_LD='1') THEN
			IF(i_D>"1001") THEN
				r_next <= (OTHERS=>'0');
			ELSE
				r_next <= unsigned(i_D);
			END IF;
		ELSIF(i_EN='1') THEN
			IF(r_reg < 9) THEN
				r_next <= (r_reg + 1);
			ELSE 
				r_next <= (OTHERS=>'0');
			END IF;
		ELSE
			r_next <= r_reg;
		END IF;
	END PROCESS;
	
	o_Q <= std_logic_vector(r_reg);
	-- CARRY OUT goes high when reg=9 so that it enables the next
	-- counter for the ipending clock
	o_CO <= '1' WHEN r_reg = 9 ELSE '0';
	
END arch;