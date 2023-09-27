LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY asyncJKFF IS
  PORT(
    i_J,i_K,i_LCLK,i_LPR,i_LCLR : IN  std_logic;
    o_Q,o_Qbar  : OUT std_logic
  );
END asyncJKFF;

ARCHITECTURE arch OF asyncJKFF IS
  SIGNAL Qinternal  : std_logic_vector(1 DOWNTO 0); --internal sig vector <Q,Qbar>
  SIGNAL s_JK,s_async: std_logic_vector(1 DOWNTO 0); --current value of <J,K> and async inputs <pre,clr>
  BEGIN
  s_JK <= i_J & i_K;
  s_async <= i_LPR & i_LCLR;
  o_Q <= Qinternal(1);
  o_Qbar <= Qinternal(0);
  PROCESS(i_LCLK)
	BEGIN
    IF(i_LCLK'EVENT AND i_LCLK='0') THEN
      CASE s_JK IS
        WHEN "00" => NULL;
        WHEN "01" => Qinternal <= "01";
        WHEN "10" => Qinternal <= "10";
        WHEN "11" => Qinternal <= not Qinternal;
        WHEN OTHERS => Qinternal <= (OTHERS =>'1');
      END CASE;
    END IF;
  END PROCESS;
  PROCESS(i_LCLR,i_LPR)
  BEGIN
    CASE s_async IS
      WHEN "00" => Qinternal <= "11";
      WHEN "01" => Qinternal <= "10";
      WHEN "10" => Qinternal <= "01";
      WHEN "11" => NULL;
      WHEN OTHERS => Qinternal <= (OTHERS =>'1');
    END CASE;
  END PROCESS;

END arch;
