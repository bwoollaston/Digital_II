LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tb_twobitcomp IS
END tb_twobitcomp;

ARCHITECTURE test OF tb_twobitcomp IS

  FUNCTION countTwoBits(num : integer) return std_logic_vector(1 DOWNTO 0) IS
  VARIABLE s_out : std_logic_vector(1 DOWNTO 0);
  BEGIN
    PROCESS
      BEGIN
        IF (num=0) THEN s_out <='00';
        ELSIF (num=1) THEN s_out <='01';
        ELSIF (num=2) THEN s_out <='10';
        ELSIF (num=3) THEN s_out <='11';
        ELSE s_out <= '00';
        RETURN s_out;
      END PROCESS;
  END FUNCTION;

  SIGNAL test_inA  : std_logic_vector(1 DOWNTO 0) := '00';
  SIGNAL test_inB  : std_logic_vector(1 DOWNTO 0) := '00';
  SIGNAL test_out_aeq2b, test_out_altb, test_out_agtb  : std_logic;

  COMPONENT twobitcomp IS
    PORT (
      i_a, i_b  : IN std_logic_vector(1 DOWNTO 0);
      o_aeq2b, o_agtb, o_altb : OUT std_logic;
    );
    END COMPONENT twobitcomp;

    BEGIN
    twobitcomp_INST : twobitcomp
      PORT MAP( i_a => test_inA, i_b => test_inB,
                o_agtb  => test_out_agtb,
                o_altb  => test_out_altb
                o_aeq2b => test_out_aeq2b);
    PROCESS IS
    BEGIN
      FOR i IN 0 TO 3 LOOP
        FOR j IN 0 TO 3 LOOP
          test_inA <= countTwoBits(i);
          test_inB <= countTwoBits(j);
          WAIT FOR 10ns
        END LOOP;
      END LOOP;
      assert false
      report "Simulation Completed"
      severity FAILURE;
    END PROCESS;
END test;
