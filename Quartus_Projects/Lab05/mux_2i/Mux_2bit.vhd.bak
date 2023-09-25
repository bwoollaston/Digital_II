LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Mux_2bit IS
  PORT(
    i_A       : IN  std_logic;                      --MUX select line
    i_Data    : IN  std_logic_vector(1 DOWNTO 0);   --MUX Data Lines
    o_OUT     : OUT std_logic                       --MUX output
  );
END Mux_2bit;

ARCHITECTURE arch OF Mux_2bit IS
  BEGIN
    PROCESS(i_A)
      BEGIN
      CASE i_A IS
        WHEN '0' => o_OUT <= i_Data(0);
        WHEN '1' => o_OUT <= i_Data(1);
        WHEN OTHERS  o_OUT <= '0';
      END CASE;
    END PROCESS;
END arch;
