LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY uCounter_tb IS
END uCounter_tb;

ARCHITECTURE arch OF uCounter_tb IS
  CONSTANT FOUR                  : INTEGER := 4;     -- counter bits
  CONSTANT T                     : TIME := 20 ns;    -- clock period
  SIGNAL s_CLK, s_aRST            : std_logic;
  SIGNAL s_CLR, s_LD, s_EN, s_UP  : std_logic;
  SIGNAL s_D, s_Q                 : std_logic_vector(four-1 DOWNTO 0);
  SIGNAL s_MAX_TICK, s_MIN_TICK   : std_logic;

  BEGIN
    coutner_inst : ENTITY work.uCounter(arch)
    GENERIC MAP(N=>FOUR)
    PORT MAP(
      i_CLK   => s_CLK,
      i_aRST  => s_aRST,
      i_CLR   => s_CLR,
      i_LD    => s_LD,
      i_EN    => s_EN,
      i_UP    => s_UP,
      i_D     => s_D,
      o_Q     => s_Q,
      o_MAX_TICK  => s_MAX_TICK,
      o_MIN_TICK  => s_MIN_TICK );

    PROCESS
    BEGIN
      s_CLK <= '0';
      WAIT FOR T/2;
      s_CLK <= '1';
      WAIT FOR T/2;
    END PROCESS;

    s_aRST <= '1', '0' AFTER T/2;

    PROCESS
    BEGIN
      s_CLR <=  '0';
      s_LD  <=  '0';
      s_EN  <=  '0';
      s_UP  <=  '1';
      s_D   <=  (OTHERS=>'0');
      WAIT UNTIL falling_edge(s_CLK);
      WAIT UNTIL falling_edge(s_CLK);

      s_LD  <= '1';
      s_D   <= "0110";
      WAIT UNTIL falling_edge(s_CLK);

      s_LD  <= '0';
      WAIT UNTIL falling_edge(s_CLK);
      WAIT UNTIL falling_edge(s_CLK);

      s_CLR <= '1';
      WAIT UNTIL falling_edge(s_CLK);
      s_CLR <= '0';

      s_EN  <= '1';
      s_UP  <= '1';
      FOR i IN 1 TO 10 LOOP
        WAIT UNTIL falling_edge(s_CLK);
      END LOOP;
      s_EN  <= '0';
      WAIT UNTIL falling_edge(s_CLK);
      WAIT UNTIL falling_edge(s_CLK);

      s_EN  <= '1';
      WAIT UNTIL falling_edge(s_CLK);
      WAIT UNTIL falling_edge(s_CLK);

      s_UP  <= '0';
      FOR i IN 1 TO 10 LOOP
        WAIT UNTIL falling_edge(s_CLK);
      END LOOP;

      WAIT UNTIL s_Q = "0010";
      WAIT UNTIL falling_edge(s_CLK);
      s_UP  <= '1';

      WAIT ON s_MIN_TICK;
      WAIT UNTIL s_Q = "0010";
      WAIT UNTIL falling_edge(s_CLK);
      s_UP  <= '0';

      WAIT FOR 4*T;
      s_EN  <= '0';
      WAIT FOR 4*T;
      ASSERT FALSE
      REPORT "Simulation Complete"
      SEVERITY FAILURE;
    END PROCESS;
END arch;
