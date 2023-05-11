library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity i2c_master is
  generic(
    GC_SYSTEM_CLK : integer := 50_000_000;
    GC_I2C_CLK    : integer := 200_000
    );
  port
    (
      clk       : in    std_logic;
      arst_n    : in    std_logic;
      valid     : in    std_logic;
      addr      : in    std_logic_vector(6 downto 0);
      rnw       : in    std_logic;
      data_wr   : in    std_logic_vector(7 downto 0);
      data_rd   : out   std_logic_vector(7 downto 0);
      busy      : out   std_logic;
      ack_error : out   std_logic;
      sda       : inout std_logic;
      scl       : inout std_logic
      );
end entity;

architecture behave of i2c_master is


  -- Number of system clk periods within one scl clk period
  --
  constant C_SCL_PERIOD      : integer := (GC_SYSTEM_CLK/GC_I2C_CLK);
  constant C_SCL_HALF_PERIOD : integer := C_SCL_PERIOD/2;
  constant C_STATE_TRIGGER   : integer := C_SCL_PERIOD/4;
  constant C_SCL_TRIGGER     : integer := C_SCL_PERIOD*3/4;

  signal scl_clk      : std_logic;
  signal scl_high_ena : std_logic;
  signal state_ena    : std_logic;
  signal scl_oe       : std_logic;
  signal ack_error_i  : std_logic;
  signal sda_i        : std_logic;
  signal addr_rnw_i   : std_logic_vector(7 downto 0);
  signal data_tx      : std_logic_vector(7 downto 0);
  signal data_rx      : std_logic_vector(7 downto 0);
  signal bit_cnt      : integer range 0 to 7 := 0;
  alias rnw_i         : std_logic is addr_rnw_i(0);


  type   t_state is (sIDLE, sSTART, sADDR, sACK1, sWRITE, sREAD, sACK2, sMACK, sSTOP);
  signal state : t_state;

begin

  -- Process to generate the SCL clock
  p_sclk : process(arst_n, clk)
    variable cnt : integer range 0 to C_SCL_PERIOD;
  begin
    if arst_n = '0' then
      cnt     := 0;
      scl_clk <= '0';
    elsif rising_edge(clk) then
      cnt := cnt + 1;
      if cnt = C_SCL_PERIOD then
        cnt := 0;
      end if;
      if cnt < C_SCL_HALF_PERIOD then   -- low for the first half period
        scl_clk <= '0';
      elsif cnt < C_SCL_PERIOD then     -- high for the second half period
        scl_clk <= '1';
      end if;
    end if;
  end process;

  -- Process to generate the to control signals state_ena and scl_high_ena
  p_ctrl : process(arst_n, clk)
    variable cnt : integer range 0 to C_SCL_PERIOD;
  begin
    if arst_n = '0' then
      cnt          := 0;
      state_ena    <= '0';
      scl_high_ena <= '0';
    elsif rising_edge(clk) then
      -- default values to make sure trigger signals will only be set for 1 system
      -- clk periods
      state_ena    <= '0';
      scl_high_ena <= '0';

      cnt := cnt + 1;
      if cnt = C_SCL_PERIOD then
        cnt := 0;
      end if;
      if cnt = C_STATE_TRIGGER then     -- low for the first half period
        state_ena <= '1';
      elsif cnt = C_SCL_TRIGGER then    -- high for the second half period
        scl_high_ena <= '1';
      end if;

    end if;
  end process;






  p_state : process(clk,arst_n)
  begin
    if arst_n = '0' then
      state <= sIDLE;
    elsif rising_edge(clk) then
      scl_oe <= '1';
      case state is

        when sIDLE =>
          scl_oe  <= '0';
          busy    <= '0';
          sda_i   <= '1';
          bit_cnt <= 7;
          -- Waiting for external trigger to start state machine
          if valid = '1' and state_ena = '1' then
            addr_rnw_i  <= addr & rnw;
            data_tx     <= data_wr;
            state       <= sSTART;
            ack_error_i <= '0';
          end if;

        when sSTART =>
          busy <= '1';
          if state_ena = '1' then
            state <= sADDR;
          end if;
          -- Generate start condition
          if scl_high_ena = '1'then
            sda_i <= '0';
          end if;

        when sADDR =>
          busy  <= '1';
          sda_i <= addr_rnw_i(bit_cnt);
          if state_ena = '1' then
            if bit_cnt = 0 then
              state   <= sACK1;
              bit_cnt <= 7;
            else
              bit_cnt <= bit_cnt - 1;
            end if;
          end if;

        when sACK1 =>
          busy  <= '1';
          sda_i <= '1';
          if state_ena = '1' then
            if rnw_i = '1' then
              state <= sREAD;
            else
              state <= sWRITE;
            end if;
          end if;
          --Check if acknowledge is given by slave(ack by pulling sda low)
          if scl_high_ena = '1' and sda /= '0' then
            ack_error_i <= '1';
          end if;

        when sREAD =>
          busy  <= '1';
          sda_i <= '1';
          if state_ena = '1' then
            if bit_cnt = 0 then
              state   <= sMACK;
              bit_cnt <= 7;
              data_rd <= data_rx;
            else
              bit_cnt <= bit_cnt - 1;
            end if;
          end if;
          if scl_high_ena = '1' then
            data_rx(bit_cnt) <= sda;
          end if;

        when sWRITE =>
          busy  <= '1';
          sda_i <= data_tx(bit_cnt);
          if state_ena = '1' then
            if bit_cnt = 0 then
              state   <= sACK2;
              bit_cnt <= 7;
            else
              bit_cnt <= bit_cnt - 1;
            end if;
          end if;

        when sACK2 =>
          sda_i <= '1';
          busy  <= '0';
          if state_ena = '1' then
            if valid = '1' then
              if rnw = '0' then         -- continue to write another byte
                data_tx <= data_wr;
                state   <= sWRITE;
              else               -- repeated start to initiate a new read.
                addr_rnw_i <= addr & rnw;
                state      <= sSTART;
              end if;
            else
              state <= sSTOP;
              sda_i <= '0';
            end if;
          end if;

          --Check if acknowledge is given by slave(ack by pulling sda low)
          if scl_high_ena = '1' and sda /= '0' then
            ack_error_i <= '1';
          end if;

        when sMACK =>
          busy <= '0';

          sda_i <= '1';
          if valid = '1' then
            sda_i <= '0';
          end if;

          if state_ena = '1' then
            if valid = '1'then
              if rnw = '1' then         -- continue to read another byte
                state <= sREAD;
              else
                addr_rnw_i <= addr & rnw;
                state      <= sSTART;
                data_tx    <= data_wr;
              end if;
            else
              state <= sSTOP;
              sda_i <= '0';
            end if;
          end if;

        when sSTOP =>
          busy <= '1';
          if state_ena = '1' then
            state <= sIDLE;
          end if;
          if scl_high_ena = '1' then
            sda_i <= '1';
          end if;
        when others =>
          state <= sIDLE;
      end case;
    end if;
  end process;

  ack_error <= ack_error_i;
  sda       <= '0' when sda_i = '0'                      else 'Z';
  scl       <= '0' when (scl_clk = '0' and scl_oe = '1') else 'Z';


end architecture;
