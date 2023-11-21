LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY control_fsmd IS
  GENERIC(N : INTEGER := 8);
  PORT(
    i_CLK, i_RST : IN std_logic; --async inputs
    i_start_tick : IN std_logic;
    i_x, i_y     : IN std_logic_vector(N-1 DOWNTO 0);
    o_done_tick, o_ready_tick : OUT std_logic;
    o_gcd_start, o_bin2bcd_start : OUT std_logic
    o_bcd0, o_bcd1, o_bcd2, o_bcd3 : OUT std_logic_vector(7 DOWNTO 0);
  );
END control_fsmd;

ARCHITECTURE arch OF control_fsmd IS

  CONSTANT c_leading_zeros : std_logic_vector(4 DOWNTO 0) := (OTHERS => '0');

  TYPE control_states_t IS(STATE_IDLE, STATE_GCD, STATE_BCD, STATE_DONE);
    ATTRIBUTE syn_encoding : string;
    ATTRIBUTE syn_encoding OF gcd_states_t : type is "safe, one-hot";

  SIGNAL state_reg, state_next : control_states_t := STATE_IDLE;
  SIGNAL r_gcd : std_logic_vector(N-1 DOWNTO 0);
  SIGNAL s_gcd_13b : std_logic_vector(12 DOWNTO 0);
  SIGNAL s_gcd_start, s_bin2bcd_start : std_logic := '0';
  SIGNAL s_gcd_ready, s_bin2bcd_ready : std_logic := '0';
  SIGNAL s_gcd_done, s_bin2bcd_done : std_logic := '0';

  BEGIN
  gcd_fsmd_inst : ENTITY work.gcd_fsmd(arch)
    GENERIC MAP(N => N)
    PORT MAP(
      i_CLK => i_CLK,
      i_RST => i_RST,
      i_start_tick => s_gcd_start,
      i_x => i_x,
      i_y => i_y,
      o_ready => s_gcd_ready,
      o_done_tick => s_gcd_done,
      o_gcd => r_gcd
    );
  bcd_fsmd_inst : ENTITY work.bcd_fsmd(arch)
    PORT MAP(
      clk   => i_CLK,
      reset => i_RST,
      start => s_bin2bcd_start,
      bin   => s_gcd_13b,
      ready => s_bin2bcd_ready,
      bcd0  => o_bcd0,
      bcd1  => o_bcd1,
      bcd2  => o_bcd2,
      bcd3  => o_bcd3
    );

  PROCESS(i_CLK, i_RST)
  BEGIN
    IF(i_RST = '1') THEN
      state_reg <= STATE_IDLE;
    ELSIF(i_CLK'EVENT AND i_CLK = '1') THEN
      state_reg <= state_next;
    END IF;
  END PROCESS;

  PROCESS(state_reg, i_x, i_y, i_start_tick, s_gcd_done)
  BEGIN
  state_next <= state_reg;
  s_gcd_start <= '0';
  s_bin2bcd_start <= '0';
  s_bin2bcd_done <= '0';

  CASE state_reg IS
    WHEN STATE_IDLE =>
      IF(i_start_tick = '1') THEN
        state_next <= STATE_GCD;
        s_gcd_start <= '1';

      END IF;
    WHEN STATE_GCD =>
      IF(s_gcd_done = '1') THEN
        state_next <= STATE_BCD;
        s_bin2bcd_start <= '1';

      END IF;
    WHEN STATE_BCD =>
      IF(s_bin2bcd_done) THEN
        state_next <= STATE_DONE;
      END IF;

    WHEN STATE_DONE =>
      state_next <= STATE_IDLE;
      s_bin2bcd_done <= '1';

  END CASE;

  END PROCESS

  o_bin2bcd_start <= s_bin2bcd_start;
  o_gcd_start <= s_gcd_start;
  o_ready_tick <= s_gcd_ready AND s_bin2bcd_ready;
  o_done_tick <= s_bin2bcd_done;
  s_gcd_13b <= c_leading_zeros & r_gcd; --add leading zeros to 8bit gcd output to match 13bit bin input
END arch;
