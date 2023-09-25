LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY decoder_1to4 IS
  PORT(
    i_EN  : IN  std_logic;
    i_SEL : IN  std_logic_vector(1 DOWNTO 0);
    o_OUT : OUT std_logic_vector(3 DOWNTO 0)
  );
END decoder_1to4;

ARCHITECTURE arch OF decoder_1to4 IS
  BEGIN
    PROCESS(i_EN,i_SEL)
      BEGIN
      IF (i_EN = '0') THEN
			CASE i_SEL IS
				WHEN "00" => o_OUT <= "1110";
				WHEN "01" => o_OUT <= "1101";
				WHEN "10" => o_OUT <= "1011";
				WHEN "11" => o_OUT <= "0111";
				WHEN OTHERS => o_OUT<="1111";
			END CASE;
      ELSE
        o_OUT <= "1111";
      END IF;
    END PROCESS;
END arch;