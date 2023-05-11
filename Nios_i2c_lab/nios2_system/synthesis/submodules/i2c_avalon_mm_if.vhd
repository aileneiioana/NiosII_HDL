library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity i2c_avalon_mm_if is
  port (clk        : in    std_logic;
        reset_n    : in    std_logic;
        read       : in    std_logic;
        write      : in    std_logic;
        chipselect : in    std_logic;
        address    : in    std_logic_vector(2 downto 0);
        writedata  : in    std_logic_vector(31 downto 0);
        readdata   : out   std_logic_vector(31 downto 0);
        sda        : inout std_logic;
        scl        : inout std_logic);
end i2c_avalon_mm_if;
architecture Structure of i2c_avalon_mm_if is


  --R: Read only register
  --W: Write only register
  --RW: Read and write register

  -- Memory mapped registers
  signal ctrl_reg  : std_logic_vector(31 downto 0);  -- RW
  signal addr_reg  : std_logic_vector(31 downto 0);  -- RW
  signal write_reg : std_logic_vector(31 downto 0);  -- RW
  signal read_reg  : std_logic_vector(63 downto 0);  -- R


  -- Alias bits for the ctrl register
  alias cmd          : std_logic is ctrl_reg(0);  -- RW: Starts transaction on I2C bus when enabled. Automatically reset.
  alias rnw          : std_logic is ctrl_reg(1);  -- RW: Read (1) or write (0) write transaction on the I2C bus
  alias no_bytes     : std_logic_vector is ctrl_reg(4 downto 2);  --RW: Number of bytes to write or read for I2C transaction. 3 bit needed to allow for reading back 6 bytes in a row (16 bits of x,y,z accel. data)
  alias ack_error    : std_logic is ctrl_reg(5);  -- R
  alias busy         : std_logic is ctrl_reg(6);  -- R: register busy status bit from I2C master
  alias mm_if_busy : std_logic is ctrl_reg(7);  -- R: busy signal of this module's control state machine
  --alias wrapper_error : std_logic is ctrl_reg(7);
  --alias wrapper_rst   : std_logic is ctrl_reg(8);  -- RW: reset wrapper.

  signal mm_if_busy_state : std_logic;  --R: intermediate signaling of busy
  --for state machine. registered to mm_if_busy(ctrl_reg)
  signal cmd_rst            : std_logic;  --R: Clear cmd bit in ctrl_reg when command has been accepted.

  alias i2c_pointer     : std_logic_vector is addr_reg(15 downto 8);
  alias i2c_device_addr : std_logic_vector is addr_reg(6 downto 0);



  --i2c master signals
  signal i2c_valid     : std_logic;
  signal i2c_addr      : std_logic_vector(6 downto 0);
  signal i2c_rnw       : std_logic;
  signal i2c_data_wr   : std_logic_vector(7 downto 0);
  signal i2c_busy      : std_logic;
  signal i2c_data_rd   : std_logic_vector(7 downto 0);
  signal i2c_ack_error : std_logic;


  constant GC_SYSTEM_CLK : integer := 50_000_000;
  constant GC_I2C_CLK    : integer := 200_000;



--wrapper state machine
  type   statetype is (sIDLE, sADDR, sWRITE_DATA, sWAIT_DATA, sWAIT_STOP);
  signal state : statetype;




begin


  i2c_master_inst : entity work.i2c_master
    generic map (
      GC_SYSTEM_CLK => GC_SYSTEM_CLK,
      GC_I2C_CLK    => GC_I2C_CLK)
    port map (
      clk       => clk,
      arst_n    => reset_n,
      valid     => i2c_valid,
      addr      => i2c_addr,
      rnw       => i2c_rnw,
      data_wr   => i2c_data_wr,
      busy      => i2c_busy,
      data_rd   => i2c_data_rd,
      ack_error => i2c_ack_error,
      sda       => sda,
      scl       => scl
      );



  --general register interface
  p_mm_if : process(clk, reset_n)
  begin
    if reset_n = '0' then
      ctrl_reg  <= (others => '0');
      addr_reg  <= (others => '0');
      write_reg <= (others => '0');

    elsif rising_edge(clk) then
      -- register control signals from I2C master
      busy         <= i2c_busy;
      ack_error    <= i2c_ack_error;
      mm_if_busy <= mm_if_busy_state;  --update from state machine

      -- Automatically reset cmd after one clock cycle.
      if cmd_rst = '1' then
        cmd <= '0';
      end if;

      -- Write data from CPU interface
      if chipselect = '1' and write = '1' then
        case address is
          when "000" =>
            ctrl_reg(4 downto 0) <= writedata(4 downto 0);
          when "001" =>
            addr_reg <= writedata;
          when "010" =>
            write_reg(31 downto 0) <= writedata;
          when others =>
            null;
        end case;

        -- Read data to CPU interface
      elsif chipselect = '1' and read = '1' then
        case address is
          when "000" =>
            readdata <= ctrl_reg;
          when "001" =>
            readdata <= addr_reg;
          when "010" =>
            readdata <= write_reg(31 downto 0);
          when "011" =>
            readdata <= read_reg(31 downto 0);
          when "100" =>
            readdata <= read_reg(63 downto 32);
          when others =>
            readdata <= read_reg(31 downto 0);
        end case;
      end if;
      --end if;

    end if;
  end process;


--wrapper state machine

  p_mm_if_state : process(clk, reset_n)
    variable byte_count : integer range 0 to 6 := 0;
  begin
    if reset_n = '0' then
      state              <= sIDLE;
      i2c_rnw            <= '0';
      i2c_data_wr        <= X"00";
      i2c_valid          <= '0';
      i2c_addr           <= "0000000";
      byte_count         := 0;
      read_reg           <= (others => '0');
      --wrapper ctrl signals
      cmd_rst            <= '0';
      mm_if_busy_state <= '0';



    elsif rising_edge(clk) then
      mm_if_busy_state <= '1';
      cmd_rst            <= '0';
      case state is
        when sIDLE =>
          byte_count         := 0;
          i2c_valid          <= '0';
          i2c_rnw            <= '0';
          i2c_data_wr        <= X"00";
          i2c_addr           <= "0000000";
          mm_if_busy_state <= '0';
          if cmd = '1' then
            state              <= sADDR;
            cmd_rst            <= '1';
            byte_count         := to_integer(unsigned(no_bytes));
            mm_if_busy_state <= '1';
          end if;
-------------------------------------------------------------------------------
-- sADDR activate for writing address
-------------------------------------------------------------------------------
        when sADDR =>
          i2c_data_wr <= i2c_pointer;
          i2c_valid   <= '1';
          i2c_addr    <= i2c_device_addr;
          i2c_rnw     <= rnw;
          if busy = '0' and i2c_busy = '1' then  --wait for busy to be pulled
            state <= sWAIT_DATA;
          end if;



-------------------------------------------------------------------------------
-- sWAIT_DATA
-------------------------------------------------------------------------------
        when sWAIT_DATA =>
          if busy = '1' and i2c_busy = '0' then  -- wait for busy to be
                                                 -- pulled low sACK2 or sMACK
            if rnw = '0' then
              if byte_count = 0 then
                state <= sWAIT_STOP;
              else
                state <= sWRITE_DATA;
              end if;
            else

              read_reg((8*byte_count)-1 downto 8*(byte_count-1)) <= i2c_data_rd;  --sample first data
              byte_count                                         := byte_count - 1;
              if byte_count = 0 then
                state <= sWAIT_STOP;
              end if;
            end if;
          end if;


-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
        when sWRITE_DATA =>
          i2c_data_wr <= write_reg((8*byte_count)-1 downto 8*(byte_count-1));
          if busy = '0' and i2c_busy = '1' then  --busy just pulled high,cmd
            state      <= sWAIT_DATA;
            byte_count := byte_count - 1;
          end if;


-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
        when sWAIT_STOP =>
          --end of transaction
          i2c_valid <= '0';
          --wait for stop state to complete.
          if (busy = '1' and i2c_busy = '0') then  --busy just pulled low, stop
                                                   --completed
            state <= sIDLE;
          end if;
        when others =>
          state <= sIDLE;

      end case;



    end if;

  end process;



end Structure;
