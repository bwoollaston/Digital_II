-- FOR Lab07
-- CTRL => PIN 0 & 1
-- LD => PIN 2-5
-- CLK => Button 1
-- RST => PIN 6
-- Q => LED 0-3

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shift_reg IS
  GENERIC(
    N : INTEGER := 4
  );
  PORT(
    i_CTRL        : IN  std_logic_vector(1 DOWNTO 0);
    i_LD          : IN  std_logic_vector(N-1 DOWNTO 0);
    i_CLK, i_aRST : IN  std_logic;
    o_Q           : OUT std_logic_vector(N-1 DOWNTO 0)
  );
END ;

ARCHITECTURE arch OF shift_reg IS
  SIGNAL r_reg  : std_logic_vector(N-1 DOWNTO 0);
  SIGNAL r_next : std_logic_vector(N-1 DOWNTO 0);
  BEGIN
    PROCESS(i_CLK, i_aRST)
    BEGIN
      IF(i_aRST = '1') THEN
        r_reg <= (OTHERS => '0');

      ELSIF(i_CLK'EVENT AND i_CLK='1') THEN
        r_reg <= r_next;
      END IF;
    END PROCESS;
    WITH i_CTRL SELECT
      r_next <= (r_reg(N-2 DOWNTO 0) & i_LD(0)) WHEN "01",
                (i_LD(N-1) & r_reg(N-1 DOWNTO 1)) WHEN "10",
                i_LD WHEN "11",
                r_reg WHEN OTHERS;
      o_Q <= r_reg;
END arch;
