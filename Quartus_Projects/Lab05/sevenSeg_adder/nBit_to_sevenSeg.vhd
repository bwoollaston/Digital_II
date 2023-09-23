LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY nBit_to_sevenSeg IS
  PORT(
    i_A3, i_B3  : IN  std_logic_vector(2 DOWNTO 0);
    o_Y       : OUT std_logic_vector(7 DOWNTO 0)
  );
END nBit_to_sevenSeg;

ARCHITECTURE arch OF nBit_to_sevenSeg IS
  SIGNAL s_SUM  : std_logic_vector(2 DOWNTO 0) := "000";
  SIGNAL s_COUT : std_logic := '0';                        --signal for carry out
  SIGNAL s_SEG  : std_logic_vector(3 DOWNTO 0) := "0000";  --input for seven segment display

  BEGIN
  s_SEG <= s_COUT & s_SUM;    --concatinate signals to single bus

  --Declare instance of adder, set to 3-bit
  comp_nBitAdder  : ENTITY  work.nBitAdder(arch)
    GENERIC MAP(N=>3)
    PORT MAP(i_A=>i_A3,i_B=>i_B3,o_SUM=>s_SUM,o_COUT=>s_COUT);
  --Declare instance of seven segment decoder
  comp_sevenSeg   : ENTITY  work.sevenSeg(arch)
    PORT MAP(i_inputs=>s_SEG,o_display=>o_Y);

END arch;
