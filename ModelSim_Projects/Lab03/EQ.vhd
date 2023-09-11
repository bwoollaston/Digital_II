LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY eq IS
  PORT(
    i_A,i_B : IN Std_logic_vector(1 DOWNTO 0);
    o_AEQ2B  : OUT Std_logic
  );
END eq;

ARCHITECTURE arch OF eq IS
  SIGNAL ab_bits : std_logic_vector(3 DOWNTO 0);
  BEGIN
    ab_bits <= i_A & i_B;
    PROCESS(ab_bits)
    -- PROCESS(i_A,i_B)
      BEGIN
      -- ab_bits <= i_A & i_B;
      CASE ab_bits IS
        WHEN "0000" => o_AEQ2B <= '1';
        WHEN "0101" => o_AEQ2B <= '1';
        WHEN "1010" => o_AEQ2B <= '1';
        WHEN "1111" => o_AEQ2B <= '1';
        WHEN OTHERS => o_AEQ2B <= '0';
      END CASE;
    END PROCESS;
END arch;
