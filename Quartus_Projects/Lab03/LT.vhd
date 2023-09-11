LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY lt IS
  PORT(
    i_A,i_B : IN Std_logic_vector(1 DOWNTO 0);
    o_ALTB  : OUT Std_logic
  );
END lt;

ARCHITECTURE arch OF lt IS
  SIGNAL ab_bits : std_logic_vector(3 DOWNTO 0);
  BEGIN
  ab_bits <= i_A & i_B;
    WITH ab_bits SELECT
    o_ALTB  <=  '1' WHEN "0001" | "0010" |  "0011" | "0110" | "0111" | "1011",
                '0' WHEN OTHERS;
END arch;
