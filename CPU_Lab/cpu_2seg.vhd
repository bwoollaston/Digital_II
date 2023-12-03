LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.ALL;
USE  IEEE.numeric_std.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY cpu_2seg IS
PORT(	  clock, reset 				        : IN STD_LOGIC;
        program_counter_out 		    : OUT STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        register_AC_out 			      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0 );
		    memory_data_register_out	  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0 );
		    memory_address_register_out	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0 )
    );
END cpu_2seg;

ARCHITECTURE a OF cpu_2seg IS
  TYPE STATE_TYPE IS ( fetch, decode, execute_add, execute_load,
                       execute_store, execute_store2, execute_jump );
  SIGNAL state_reg, state_next : STATE_TYPE;
  SIGNAL ir_reg, ir_next : unsigned(15 DOWNTO 0 );
  SIGNAL ac_reg, ac_next : unsigned(15 DOWNTO 0 );
  SIGNAL pc_reg, pc_next : unsigned( 7 DOWNTO 0 );
  SIGNAL mem_data_bus    : std_logic_vector(15 DOWNTO 0 );
  SIGNAL mem_address_bus : std_logic_vector( 7 DOWNTO 0 );
  SIGNAL memory_write : STD_LOGIC;
  BEGIN

  -- Use Altsyncram function for computer's memory (256 16-bit words)
  memory: altsyncram
      GENERIC MAP (
  	        operation_mode => "SINGLE_PORT",
  	        width_a => 16,
  	        widthad_a => 8,
  	        lpm_type => "altsyncram",
  	        outdata_reg_a => "UNREGISTERED",
  		      -- Reads in mif file for initial program and data values
  	        init_file => "program.mif",
  	        intended_device_family => "Cyclone")

      PORT MAP (
            wren_a => memory_write,
            clock0 => clock,
  			    address_a => mem_address_bus,
            data_a => std_logic_vector(ac_reg),
            q_a => mem_data_bus
      );

  -- Output major signals for simulation
  program_counter_out 		    <= std_logic_vector(pc_reg);
  register_AC_out 			      <= std_logic_vector(ac_reg);
  memory_data_register_out 	  <= mem_data_bus;
  memory_address_register_out <= mem_address_bus;

  PROCESS ( clock, reset )
  BEGIN
    IF(reset = '0') THEN
      state_reg <= fetch;
      pc_reg 	<= "00000000";
      ac_reg	<= "0000000000000000";
      mem_address_bus <= "00000000";

    ELSIF(clock'EVENT AND clock = '1') THEN
      state_reg <= state_next;
      pc_reg <= pc_next;
      ac_reg <= ac_next;

    END IF;
  END PROCESS;

  PROCESS(state_reg, pc_reg, ac_reg, ir_reg)
  BEGIN
    state_next <= state_reg;
    pc_next <= pc_reg;
    ir_next <= ir_reg;
    ac_next <= ac_reg;
    memory_write <= '0';

    CASE state_reg IS
      WHEN fetch =>
        state_next <= decode;
        ir_next <= unsigned(mem_data_bus);
        pc_next <= pc_reg + 1;
        mem_address_bus <= std_logic_vector(pc_reg);

      WHEN decode =>
        mem_address_bus <= std_logic_vector(ir_reg(7 DOWNTO 0));
        CASE mem_data_bus(15 DOWNTO 8) IS
          WHEN "00000000" =>
            state_next <= execute_add;
          WHEN "00000001" =>
            state_next <= execute_store;
          WHEN "00000010" =>
            state_next <= execute_load;
          WHEN "00000011" =>
            state_next <= execute_jump;
          WHEN OTHERS =>
            state_next <= state_reg;
        END CASE;

      WHEN execute_add =>
        state_next <= fetch;
        ac_next <= ac_reg + unsigned(mem_data_bus);
        mem_address_bus <= std_logic_vector(pc_reg);

      WHEN execute_load =>
        state_next <= fetch;
        ac_next <= unsigned(mem_data_bus);
        mem_address_bus <= std_logic_vector(pc_reg);

      WHEN execute_store =>
        -- write ac_reg to memory
        state_next <= execute_store2;
        memory_write <= '1';
        mem_address_bus <= std_logic_vector(ir_reg(7 DOWNTO 0));

      WHEN execute_store2 =>
        state_next <= fetch;
        mem_address_bus <= std_logic_vector(pc_reg);

      WHEN execute_jump =>
        state_next <= fetch;
        pc_next <= ir_reg( 7 DOWNTO 0 );
        mem_address_bus <= std_logic_vector(ir_reg(7 DOWNTO 0));

    END CASE;
  END PROCESS;
END a;
