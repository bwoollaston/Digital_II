LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY asyncJKFF IS
  PORT(
    i_J, i_K, i_LCLK, i_LPR, i_LCLR : IN  std_logic;
    o_Q, o_Qbar  : OUT std_logic
  );
END asyncJKFF;

ARCHITECTURE arch OF asyncJKFF IS
	SIGNAL Qinternal : std_logic_vector(1 DOWNTO 0) := "10"; 	--internal ff signal <Q,Qb> preset to start
	SIGNAL s_JK : std_logic_vector(1 DOWNTO 0);						--internal jk signal <J,K> for case statement
	BEGIN
	PROCESS(i_LCLK,i_LPR,i_LCLR)
		BEGIN
		IF(i_LPR='0' AND i_LCLR='0') THEN
			Qinternal <= "11";
		ELSIF(i_LPR='1' AND i_LCLR='0') THEN
			Qinternal <= "01";
		ELSIF(i_LPR='0' AND i_LCLR='1') THEN
			Qinternal <= "10";
		ELSIF(i_LCLK'EVENT AND i_LCLK='0') THEN
			CASE s_JK IS
				WHEN "00"=>null;
				WHEN "01"=>Qinternal<="01";
				WHEN "10"=>Qinternal<="10";
				WHEN "11"=>Qinternal<=not Qinternal;
				WHEN OTHERS=> Qinternal<=(OTHERS=>'1');
			END CASE;
		ELSE null;
		END IF;
	END PROCESS;
	s_JK <= i_J & i_K;
	o_Q <= Qinternal(1);
	o_Qbar <= Qinternal(0);
END arch;
