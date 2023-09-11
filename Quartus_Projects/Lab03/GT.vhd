LIBRARY IEEE;
USE IEEE.Std_logic_1164.all;

ENTITY gt is
  PORT (
    i_A,i_B : IN Std_logic_vector(1 DOWNTO 0);
    o_AGTB  : OUT Std_logic );
END gt;


-- * if-else *
ARCHITECTURE arch OF gt is
  BEGIN
  PROCESS(i_A,i_B)
    BEGIN
      IF (i_A > i_B) THEN
        o_AGTB <= '1';
      ELSE
        o_AGTB <= '0';
      END IF; 
  END PROCESS;
END arch;