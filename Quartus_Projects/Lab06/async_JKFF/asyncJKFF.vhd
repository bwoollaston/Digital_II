LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY asyncJKFF IS
  PORT(
    i_J, i_K, i_LCLK, i_LPR, i_LCLR : IN  std_logic;
    o_Q, o_Qbar  : OUT std_logic
  );
END asyncJKFF;

ARCHITECTURE arch OF asyncJKFF IS
	SIGNAL Qinternal, s_JK : std_logic_vector(1 DOWNTO 0);
	BEGIN
	s_JK <= i_J & i_K;
	PROCESS(i_LCLK,i_LPR,i_LCLR)
		BEGIN
		IF(i_LPR='0' OR i_LCLR='0') THEN
			Qinternal(1) <= not i_LPR;
			Qinternal(0) <= not i_LCLR;
		ELSIF(i_LCLK'EVENT AND i_LCLK='0') THEN
			CASE s_JK IS
				WHEN "00"=>null;
				WHEN "01"=>Qinternal<="01";
				WHEN "10"=>Qinternal<="10";
				WHEN "11"=>Qinternal<=not Qinternal;
				WHEN OTHERS=> Qinternal<=(OTHERS=>'1');
			END CASE;
		END IF;
	END PROCESS;
	o_Q <= Qinternal(1);
	o_Qbar <= Qinternal(0);
END arch;
