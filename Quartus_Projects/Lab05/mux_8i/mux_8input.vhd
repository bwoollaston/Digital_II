LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_8input IS
  PORT(
    i_EN      : IN  std_logic;
    i_SEL     : IN  std_logic_vector(2 DOWNTO 0);   --MUX select lines
    i_Data    : IN  std_logic_vector(7 DOWNTO 0);   --MUX Data Lines
    o_OUT     : OUT std_logic                       --MUX output
  );
END mux_8input;

ARCHITECTURE arch OF mux_8input IS
  BEGIN
    PROCESS(i_EN,i_SEL,i_Data)
      BEGIN
      IF (i_EN = '0') THEN
        CASE i_SEL IS
          WHEN "000" => o_OUT <= i_Data(0);
          WHEN "001" => o_OUT <= i_Data(1);
          WHEN "010" => o_OUT <= i_Data(2);
          WHEN "011" => o_OUT <= i_Data(3);
          WHEN "100" => o_OUT <= i_Data(4);
          WHEN "101" => o_OUT <= i_Data(5);
          WHEN "110" => o_OUT <= i_Data(6);
          WHEN "111" => o_OUT <= i_Data(7);
          WHEN OTHERS => o_OUT <= '0';
        END CASE;
      ELSE
        o_OUT <= '0';
      END IF;
    END PROCESS;
END arch;
