LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Mux_2bit IS
  PORT(
    i_A, i_B  : IN  std_logic;                      --MUX select lines
    i_Data    : IN  std_logic_vector(3 DOWNTO 0);   --MUX Data Lines
    o_OUT     : OUT std_logic                       --MUX output
  );
END Mux_2bit;

ARCHITECTURE arch OF Mux_2bit IS
  SIGNAL s_AB : std_logic_vector(1 DOWNTO 0);
  BEGIN
    s_AB  <=  i_A & i_B;
    PROCESS(i_A,i_B)
      BEGIN
      CASE s_AB IS
        WHEN "00" => o_OUT <= i_Data(0);
        WHEN "01" => o_OUT <= i_Data(1);
        WHEN "10" => o_OUT <= i_Data(2);
        WHEN "11" => o_OUT <= i_Data(3);
        WHEN OTHERS  o_OUT <= '0';
      END CASE;
    END PROCESS;
END arch;
