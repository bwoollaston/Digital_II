LIBRARY ieee;
USE ieee.std_logic_1164.all

ENTITY DFF_clk IS
  PORT(
    --INPUTS: Preset, clear, clock, D
    i_LPR,i_LCLR,i_CLK,i_D  : IN  std_logic;

    --OUTPUTS: Q, Qbar
    o_Q,o_Qbar  : OUT std_logic;
  );
END DFF_clk;

ARCHITECTURE arch OF DFF_clk IS
  BEGIN
  PROCESS
    BEGIN
    WAIT UNTIL(i_CLK'EVENT and i_CLK='1');
    o_Q <= i_D;
    o_Qbar <= not i_D;
    END PROCESS;

  PROCESS(i_LPR,i_LCLR)
    BEGIN
    o_Q <= not i_LCLR;
    o_Qbar <= not i_LPR;
  END PROCESS;
END arch;
