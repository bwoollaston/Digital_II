LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY control_fsmd_tb IS
END control_fsmd_tb;

ARCHITECTURE arch OF control_fsmd_tb IS
  CONSTANT bit_width : INTEGER := 8;
  CONSTANT T         : TIME := 20 ns;

  -- asynchronous inputs
  SIGNAL s_CLK, s_RST : std_logic := '0';

  -- input signals
  SIGNAL s_start_tick : std_logic := '0';
  SIGNAL s_x, s_y : std_logic_vector(bit_width-1 DOWNTO 0) := (OTHERS =>'0');

  -- output signals
  SIGNAL s_control_ready, s_control_done, s_gcd_start, s_bin2bcd_start : std_logic := '0';
  SIGNAL s_bcd0, s_bcd1, s_bcd2, s_bcd3 : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');

  BEGIN
  control_fsmd_inst : ENTITY work.control_fsmd(arch)
    GENERIC MAP(N => bit_width)
    PORT MAP(
      i_CLK => s_CLK,
      i_RST => s_RST,
      i_start_tick => s_start_tick,
      i_x => s_x,
      i_y => s_y,
      o_gcd_start => s_gcd_start,
      o_bin2bcd_start => s_bin2bcd_start,
      o_bcd0 => s_bcd0,
      o_bcd1 => s_bcd1,
      o_bcd2 => s_bcd2,
      o_bcd3 => s_bcd3,
      o_ready_tick => s_control_ready,
      o_done_tick => s_control_done
    );

    PROCESS
    BEGIN
      s_CLK <= '0';
      WAIT FOR T/2;
      s_CLK <= '1';
      WAIT FOR T/2;
    END PROCESS;

    --begin test bench process with asynch reset pulse
    s_RST <= '1', '0' AFTER T/2;

    PROCESS
    BEGIN
      -- set input vectors
      s_x <= std_logic_vector(to_unsigned(255, bit_width));
      s_y <= std_logic_vector(to_unsigned(221, bit_width));
      WAIT UNTIL falling_edge(s_CLK);
      s_start_tick <= '1';
      WAIT UNTIL falling_edge(s_CLK);
      s_start_tick <= '0';
      WAIT UNTIL (s_control_done = '1');
      WAIT UNTIL falling_edge(s_CLK);
      WAIT UNTIL falling_edge(s_CLK);

      s_x <= std_logic_vector(to_unsigned(199, bit_width));
      s_y <= std_logic_vector(to_unsigned(251, bit_width));
      WAIT UNTIL falling_edge(s_CLK);
      s_start_tick <= '1';
      WAIT UNTIL falling_edge(s_CLK);
      s_start_tick <= '0';
      WAIT UNTIL (s_control_done = '1');
      WAIT UNTIL falling_edge(s_CLK);
      WAIT UNTIL falling_edge(s_CLK);

      s_x <= std_logic_vector(to_unsigned(0, bit_width));
      s_y <= std_logic_vector(to_unsigned(88, bit_width));
      WAIT UNTIL falling_edge(s_CLK);
      s_start_tick <= '1';
      WAIT UNTIL falling_edge(s_CLK);
      s_start_tick <= '0';
      WAIT UNTIL (s_control_done = '1');
      WAIT UNTIL falling_edge(s_CLK);
      WAIT UNTIL falling_edge(s_CLK);

      ASSERT FALSE
      REPORT "Simulation Complete"
      SEVERITY FAILURE;
    END PROCESS;
END arch;
