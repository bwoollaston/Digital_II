LIBRARY ieee;
USE ieee.std_logic_1164.all
USE ieee.numeric_std.all;

ENTITY n_DFF IS
  GENERIC(N:  integer:=2);  --number of flipflops
  PORT(
    i_D,i_LPR,i_LCLR,_CLK : IN  std_logic_vector(N-1 DOWNTO 0);
    o_Q,o_Qbar  : OUT std_logic_vector(N-1 DOWNTO 0);
  );
END n_DFF;

ARCHITECTURE arch OF n_DFF IS
  gen_dff:
  FOR i IN 0 TO N-1 GENERATE
    comp_DFF : ENTITY work.DFF_clk(arch)
      PORT MAP(
        i_LPR=>i_LPR(i),
        i_LCLR=>i_LCLR(i),
        i_CLK=>i_CLK(i),
        i_D=>i_D(i),
        o_Q=>o_Q(i),
        o_Qbar=>o_Qbar(i)
      );
  END GENERATE gen_dff;
END arch;
