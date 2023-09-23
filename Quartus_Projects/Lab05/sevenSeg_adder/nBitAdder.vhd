LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY nBitAdder IS
  GENERIC(N: integer:=4);
  PORT(
    i_A, i_B  : IN  std_logic_vector(N-1 DOWNTO 0);
    o_COUT    : OUT std_logic;
    o_SUM     : OUT std_logic_vector(N-1 DOWNTO 0)
  );
END nBitAdder;

ARCHITECTURE arch OF nBitAdder IS
  SIGNAL s_A, s_B, s_SUM  : unsigned(N DOWNTO 0);
  BEGIN
    s_A <= unsigned('0' & i_A);
    s_B <= unsigned('0' & i_B);
    s_SUM <= s_A + s_B;
    o_SUM <= std_logic_vector(s_SUM(N-1 DOWNTO 0));
    o_COUT <= s_SUM(N);
END arch;
