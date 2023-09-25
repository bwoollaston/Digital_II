LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tristate IS
  PORT(
    i_oe, i_in  : IN  std_logic;
    o_OUT       : OUT std_logic
  );
END tristate;

ARCHITECTURE arch OF tristate IS
  BEGIN
  WITH i_oe SELECT
    o_OUT <=  i_in WHEN '0',
              'Z' WHEN OTHERS;
END arch;
