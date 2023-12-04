LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY cpu_2seg_tb IS
END cpu_2seg_tb;

ARCHITECTURE arch OF cpu_2seg_tb IS
  CONSTANT T         : TIME := 20 ns;
  -- asynchronous inputs
  SIGNAL s_CLK, s_RST : std_logic := '0';
  SIGNAL s_PC : std_logic_vector( 7 DOWNTO 0 );
  SIGNAL s_AC : std_logic_vector(15 DOWNTO 0 );
  SIGNAL s_DATA: std_logic_vector(15 DOWNTO 0 );
  SIGNAL s_ADDRESS: std_logic_vector(7 DOWNTO 0 );
  BEGIN
  cpu_inst : ENTITY work.cpu_2seg(a)
             PORT MAP(
               clock => s_CLK, reset => s_RST,
               program_counter_out => s_PC,
               register_AC_out => s_AC,
               memory_data_register_out => s_DATA,
               memory_address_register_out => s_ADDRESS
             );

  PROCESS
  BEGIN
    s_CLK <= '0';
    WAIT FOR T/2;
    s_CLK <= '1';
    WAIT FOR T/2;
  END PROCESS;

  PROCESS
  BEGIN
    s_RST <= '1';
    WAIT UNTIL falling_edge(s_CLK);
    s_RST <= '0';
    WAIT UNTIL falling_edge(s_CLK);

    FOR i IN 0 TO 25 LOOP
      WAIT UNTIL falling_edge(s_CLK);
    END LOOP;
    ASSERT FALSE
    REPORT "Simulation Complete"
    SEVERITY FAILURE;
  END PROCESS;
END arch;
