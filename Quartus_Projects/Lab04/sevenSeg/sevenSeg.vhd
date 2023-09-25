LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY sevenSeg IS
  PORT(
     i_inputs   : IN std_logic_vector(3 DOWNTO 0);
     o_display  : OUT std_logic_vector(7 DOWNTO 0)
  );
END sevenSeg;

ARCHITECTURE arch OF sevenSeg IS
  --Constants for seven binary to seven seg conversion
  CONSTANT seg_0  : std_logic_vector(7 DOWNTO 0) := "11000000";
  CONSTANT seg_1  : std_logic_vector(7 DOWNTO 0) := "11111001";
  CONSTANT seg_2  : std_logic_vector(7 DOWNTO 0) := "10100100";
  CONSTANT seg_3  : std_logic_vector(7 DOWNTO 0) := "10110000";
  CONSTANT seg_4  : std_logic_vector(7 DOWNTO 0) := "10011001";
  CONSTANT seg_5  : std_logic_vector(7 DOWNTO 0) := "10010010";
  CONSTANT seg_6  : std_logic_vector(7 DOWNTO 0) := "10000010";
  CONSTANT seg_7  : std_logic_vector(7 DOWNTO 0) := "11111000";
  CONSTANT seg_8  : std_logic_vector(7 DOWNTO 0) := "10000000";
  CONSTANT seg_9  : std_logic_vector(7 DOWNTO 0) := "10011000";
  CONSTANT seg_a  : std_logic_vector(7 DOWNTO 0) := "10001000";
  CONSTANT seg_b  : std_logic_vector(7 DOWNTO 0) := "10000011";
  CONSTANT seg_c  : std_logic_vector(7 DOWNTO 0) := "11000110";
  CONSTANT seg_d  : std_logic_vector(7 DOWNTO 0) := "10100001";
  CONSTANT seg_e  : std_logic_vector(7 DOWNTO 0) := "10000110";
  CONSTANT seg_f  : std_logic_vector(7 DOWNTO 0) := "10001110";
  BEGIN
  PROCESS (i_inputs)
    BEGIN
      CASE i_inputs IS
        WHEN "0000" => o_display <= seg_0;
        WHEN "0001" => o_display <= seg_1;
        WHEN "0010" => o_display <= seg_2;
        WHEN "0011" => o_display <= seg_3;
        WHEN "0100" => o_display <= seg_4;
        WHEN "0101" => o_display <= seg_5;
        WHEN "0110" => o_display <= seg_6;
        WHEN "0111" => o_display <= seg_7;
        WHEN "1000" => o_display <= seg_8;
        WHEN "1001" => o_display <= seg_9;
        WHEN "1010" => o_display <= seg_a;
        WHEN "1011" => o_display <= seg_b;
        WHEN "1100" => o_display <= seg_c;    
        WHEN "1101" => o_display <= seg_d;
        WHEN "1110" => o_display <= seg_e;
        WHEN "1111" => o_display <= seg_f;
        WHEN OTHERS => o_display <= "11111111";
        END CASE;
    END PROCESS;
END arch;