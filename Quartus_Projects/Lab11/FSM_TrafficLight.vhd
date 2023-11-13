LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FSM_TrafficLight IS
  PORT(
    i_CLK             : IN  std_logic;
    i_NEMER, i_YNITE  : IN  std_logic;    --Mealy inputs
    o_IHNSR, o_IHEWR  : OUT std_logic;
    o_IHNSY, o_IHEWY  : OUT std_logic;
    o_IHNSG, o_IHEWG  : OUT std_logic
  );
END FSM_TrafficLight;

ARCHITECTURE arch OF FSM_TrafficLight IS
  --FSM States typedef
  TYPE light_state_t IS (STATE_0, STATE_1, STATE_2, STATE_3);
    --ATTRIBUTE syn_encoding OF light_state_t : TYPE IS "safe"; --use safe encoding
  SIGNAL state_reg, state_next : light_state_t;

  --Post frequency divider clock signal
  SIGNAL s_CLK_1Hz : std_logic;

  BEGIN
  --instantiate frequency divider set to 1Hz
  comp_freq_div : work.freq_div(a)
    PORT MAP(
      clock_50MHz   => i_CLK,
      clock_1Hz     => s_CLK_1Hz,
      clock_1MHz	  => OPEN,
  		clock_100KHz	=> OPEN,
  		clock_10KHz	  => OPEN,
  		clock_1KHz    => OPEN,
  		clock_100Hz	  => OPEN,
  		clock_10Hz    => OPEN
    );

  PROCESS(s_CLK_1Hz)
  BEGIN
    IF(s_CLK_1Hz'EVENT AND s_CLK_1Hz='1') THEN
      state_reg <= state_next;
    END IF;
  END PROCESS;

  PROCESS(state_reg, i_NEMER, i_YNITE)

  -- **is it okay to do the i_NEMER logic outside of the case statement

  BEGIN
  -- Initialize all outputs to Default (0)
  o_IHNSR <= '0';
  o_IHEWR <= '0';
  o_IHNSY <= '0';
  o_IHEWY <= '0';
  o_IHNSG <= '0';
  o_IHEWG <= '0';
  CASE state_reg IS
    WHEN STATE_0 =>
      IF(i_NEMER = '0') THEN
        state_next <= STATE_0;
        o_IHNSR <= '1';
        o_IHEWR <= '1';
      ELSE
        state_next <= STATE_1;
        IF(i_YNITE='1') THEN
          o_IHEWY <= '1';
        ELSE
          o_IHNSG <= '1';
          o_IHEWR <= '1';
        END IF;
      END IF;

    WHEN STATE_1 =>
      IF(i_NEMER = '0') THEN
        state_next <= STATE_1;
        o_IHNSR <= '1';
        o_IHEWR <= '1';
      ELSIF(i_YNITE='1') THEN
        state_next <= STATE_0;
        o_IHNSR <= '1';
      ELSE
        state_next <= STATE_2;
        o_IHNSY <= '1';
        o_IHEWR <= '1';
      END IF;

    WHEN STATE_2 =>
      o_IHNSR <= '1';
      IF(i_NEMER = '0') THEN
        state_next <= STATE_2;
        o_IHEWR <= '1';
      ELSE
        state_next <= STATE_3;
        o_IHEWG <= '1';
      END IF;

    WHEN STATE_3 =>
      o_IHNSR <= '1';
      IF(i_NEMER = '0') THEN
        state_next <= STATE_3;
        o_IHEWR <= '1';
      ELSE
        state_next <= STATE_0;
        o_IHEWY <= '1';
      END IF;
	END CASE;
	END PROCESS;
END arch;
