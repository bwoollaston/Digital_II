LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SigVsVar1 IS
  PORT(
    i_A,i_B,i_clk : IN  std_logic;
    o_OUT         : OUT std_logic
  );
  END SigVsVar1;

-- METHOD 1
-- A & B assigned to signal and then to out all in one clock
--ARCHITECTURE arch OF SigVsVar1 IS
--  SIGNAL s_AB :  std_logic := '0';
--  BEGIN
--    PROCESS
--    BEGIN
--      WAIT UNTIL ( i_clk'EVENT and i_clk='1' );
--      s_AB <= i_A AND i_B;
--    END PROCESS;
--    o_OUT <= s_AB;
--END arch;


--METHOD 2
-- Use variable instead of signal
--ARCHITECTURE arch OF SigVsVar1 IS
--  BEGIN
--    PROCESS
--    VARIABLE v_AB :  std_logic := '0';
--    BEGIN
--      WAIT UNTIL ( i_clk'EVENT AND i_clk='1' );
--      v_AB := i_A;
--      v_AB := v_AB AND i_B;
--      o_OUT <= v_AB;
--    END PROCESS;
--END arch;

-- METHOD 3
-- Use variable to assign A and B to sin
ARCHITECTURE arch OF SigVsVar1 IS
  SIGNAL s_AB :  std_logic := '0';
  BEGIN
    PROCESS
    VARIABLE v_AB :  std_logic := '0';
    BEGIN
      WAIT UNTIL ( i_clk'EVENT and i_clk='1' );
      v_AB := i_A;
      v_AB := v_AB AND i_B;
      s_AB <= v_AB;
    END PROCESS;
    o_OUT <= s_AB;
END arch;
