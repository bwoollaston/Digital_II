LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY tb_twobitcomp IS
END tb_twobitcomp;

ARCHITECTURE test OF tb_twobitcomp IS

  SIGNAL test_inA  : std_logic_vector(1 DOWNTO 0) := "00";
  SIGNAL test_inB  : std_logic_vector(1 DOWNTO 0) := "00";
  SIGNAL s_iterateA : UNSIGNED(1 DOWNTO 0) := "00";
  SIGNAL s_iterateB : UNSIGNED(1 DOWNTO 0) := "00";
  SIGNAL test_out_aeq2b, test_out_altb, test_out_agtb  : std_logic;

  COMPONENT twobitcomp IS
    PORT (
      i_a, i_b  : IN std_logic_vector(1 DOWNTO 0);
      o_aeq2b, o_agtb, o_altb : OUT std_logic
    );
    END COMPONENT twobitcomp;

    BEGIN
    twobitcomp_INST : twobitcomp
      PORT MAP( i_a => test_inA, i_b => test_inB,
                o_agtb  => test_out_agtb,
                o_altb  => test_out_altb,
                o_aeq2b => test_out_aeq2b);
    PROCESS
    BEGIN
      FOR i IN 0 TO 3 LOOP
        test_inA <= "00";
        s_iterateA <= "00";
        s_iterateB <= s_iterateB + 1;
        FOR j IN 0 TO 3 LOOP
          s_iterateA <= s_iterateA + 1;
          test_inA <= std_logic_vector(s_iterateA);
          WAIT FOR 10ns;
        END LOOP;
        test_inB <= std_logic_vector(s_iterateB);
      END LOOP;
      assert false
      report "Simulation Completed"
      severity FAILURE;
    END PROCESS;
END test;
