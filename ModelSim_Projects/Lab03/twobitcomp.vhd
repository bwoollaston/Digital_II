LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY twobitcomp IS
  PORT(
    i_a, i_b  : IN std_logic_vector(1 DOWNTO 0);
    o_aeq2b, o_agtb, o_altb : OUT std_logic
  );
END twobitcomp;

ARCHITECTURE arch OF twobitcomp IS
  COMPONENT eq PORT(
    i_A,i_b : IN  std_logic_vector(1 DOWNTO 0);
    o_AEQ2B : OUT std_logic
  );
  END COMPONENT;
  BEGIN
    comp_eq : eq PORT MAP(i_A => i_a, i_B => i_b, o_AEQ2B => o_aeq2b);
    comp_gt : ENTITY  work.GT(arch) PORT MAP(i_A => i_a, i_B => i_b, o_AGTB => o_agtb);
    comp_lt : ENTITY  work.LT(arch) PORT MAP(i_A => i_a, i_B => i_b, o_ALTB => o_altb);
END arch;
