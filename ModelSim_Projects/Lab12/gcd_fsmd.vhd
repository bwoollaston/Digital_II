LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY gcd_fsmd IS
  GENERIC( N : INTEGER := 8 );
  PORT(
    i_CLK, i_RST  : IN std_logic;   --asynchronous inputs
    i_start_tick  : IN std_logic;
    i_x, i_y  : IN std_logic_vector(N-1 DOWNTO 0);
    o_ready, o_done_tick  : OUT std_logic;
    o_gcd : OUT std_logic_vector(N-1 DOWNTO 0)
  );
END gcd_fsmd;

ARCHITECTURE arch OF gcd_fsmd IS

  -- initialize zero vector for generic operation
  CONSTANT zero_vector_c  : std_logic_vector(N-1 DOWNTO 0) := (OTHERS=>'0');

  -- define states for state machine
  TYPE gcd_states_t IS(STATE_IDLE, STATE_OP, STATE_DONE);
    ATTRIBUTE syn_encoding : string;
    ATTRIBUTE syn_encoding OF gcd_states_t : type is "safe, one-hot";

  -- instantiate state machine state variables
  SIGNAL state_reg, state_next : gcd_states_t := STATE_IDLE;
  SIGNAL x_reg, x_next, y_reg, y_next, gcd_reg, gcd_next : unsigned(N-1 DOWNTO 0);

  BEGIN
  -- Segment 1
  PROCESS(i_CLK, i_RST)
    BEGIN
    IF(i_RST = '1') THEN
      state_reg <= STATE_IDLE;
      x_reg     <= (OTHERS => '0');
      y_reg     <= (OTHERS => '0');
      gcd_reg   <= (OTHERS => '0');
    ELSIF(i_CLK'EVENT AND i_CLK='1') THEN
      state_reg <= state_next;
      x_reg     <= x_next;
      y_reg     <= y_next;
      gcd_reg   <= gcd_next;
    END IF;
  END PROCESS;

  --Segment 2 (next state logic)
  PROCESS(state_reg, i_start_tick, i_x, i_y, x_reg, x_next, y_reg, gcd_reg)
    BEGIN
    --inital assignments to prevent infered latching
    state_next  <= state_reg;
    x_next      <= x_reg;
    y_next      <= y_reg;
    o_ready     <= '0';
    o_done_tick <= '0';
    gcd_next    <= gcd_reg;

    CASE state_reg IS
      WHEN STATE_IDLE =>
        IF(i_start_tick = '1') THEN
          x_next <= unsigned(i_x);
          y_next <= unsigned(i_y);
          gcd_next  <= (OTHERS => '0');
          IF(i_x = zero_vector_c OR i_y = zero_vector_c) THEN
            state_next <= STATE_DONE;
            x_next <= (OTHERS => '0');
            y_next <= (OTHERS => '0');
          ELSE
            state_next <= STATE_OP;
          END IF;
        END IF;

      WHEN STATE_OP =>
        IF( x_reg = y_reg ) THEN
          state_next <= STATE_DONE;
          gcd_next <= x_next;
        ELSE
          state_next <= STATE_OP;
          IF(x_reg < y_reg) THEN
            y_next <= y_reg - x_reg;
          ELSE
            x_next <= x_reg - y_reg;
          END IF;
        END IF;

      WHEN STATE_DONE =>
        state_next <= STATE_IDLE;
        o_done_tick <= '1';

      END CASE;
  END PROCESS;
  o_gcd <= std_logic_vector(gcd_reg);

END arch;
