LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY DM74LS244 IS
  PORT(
    i_LG1, i_LG2  : IN  std_logic;                      --Active low EN inputs for each input vector
    i_A1, i_A2    : IN  std_logic_vector(3 DOWNTO 0);   --two vectors of input lines
    o_Y1, o_Y2    : OUT std_logic_vector(3 DOWNTO 0)    --two vectors of output lines
  );
END DM74LS244;

ARCHITECTURE arch OF DM74LS244 IS
  SIGNAL s_invertedG  : std_logic_vector(1 DOWNTO 0);
  BEGIN
  s_invertedG <= not i_LG2 & not i_LG1;
  -- Generate 2 vectors of tristate buffer components
  gen_tri1:
  FOR i IN 0 TO 3 GENERATE
    comp_tri1  : ENTITY work.tristate(arch) PORT MAP(i_oe=>s_invertedG(0), i_in=>i_A1(i), o_OUT=>o_Y1(i));
  END GENERATE gen_tri1;
  gen_tri2:
  FOR i IN 0 TO 3 GENERATE
    comp_tri2  : ENTITY work.tristate(arch) PORT MAP(i_oe=>s_invertedG(1), i_in=>i_A2(i), o_OUT=>o_Y2(i));
  END GENERATE gen_tri2;
END arch;
