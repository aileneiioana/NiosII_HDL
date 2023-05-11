library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lab4 is
    port(
        clk                 : in std_logic;
        arst_n              : in std_logic;
        sw                  : in std_logic_vector (9 downto 0);
        led                 : out std_logic_vector (9 downto 0);
        ext_ena_n           : in std_logic;
        sda                 : inout std_logic;
        scl                 : inout std_logic;
        ----------------------------------
        -- Hentet fra løsningsforslag:

        adxl345_alt_addr    : out   std_logic;
        adxl345_cs_n        : out   std_logic;
        adxl345_irq_n       : in    std_logic_vector(1 downto 0)
        -------------------------------
    );
end entity;

architecture top_level of lab4 is
    --------------------------------
    --hentet fra løsningsforslag
    signal irq_n_r, irq_n_rr : std_logic_vector(2 downto 0);
    signal arst_n_r : std_logic;
    signal rst_n    : std_logic;
----------------------------------
component nios2_system is
    port (
        clk_clk                                  : in  std_logic                    := 'X';             -- clk
        interrupt_pio_external_connection_export : in  std_logic_vector(2 downto 0) := (others => 'X'); -- export
        led_pio_external_connection_export       : out std_logic_vector(9 downto 0);                    -- export
        reset_reset_n                            : in  std_logic                    := 'X';             -- reset_n
        sw_pio_external_connection_export        : in  std_logic_vector(9 downto 0) := (others => 'X');  -- export
        i2c_avalon_mm_if_0_conduit_end_scl_export : inout std_logic                    := 'X';             -- export
        i2c_avalon_mm_if_0_conduit_end_sda_export : inout std_logic                    := 'X'              -- export
    );
end component nios2_system;




	
    begin
        --------------------------------
        --hentet fra løsningsforslag
        -- Set ADXL345's I2C address to 0x53.
        adxl345_alt_addr <= '0';
        -- Set ADXL345's mode to I2C;
          adxl345_cs_n     <= '1';

        p_rst_sync : process(arst_n, clk) is
        begin
          if arst_n = '0' then
            arst_n_r <= '0';
            rst_n    <= '0';
          elsif rising_edge(clk) then
            arst_n_r <= '1';
            rst_n    <= arst_n_r;
          end if;
        end process;
        ----------------------------------
        synch : process(clk) 
        begin
            if rising_edge(clk) then
                irq_n_r <= adxl345_irq_n & ext_ena_n; -- la til adxl345_irq_n etter å ha sett fasit
                irq_n_rr <= irq_n_r;
            end if;
        end process;

        u0 : component nios2_system
		port map (
			clk_clk                                  => clk,                                                     
			sw_pio_external_connection_export        => sw,        
			led_pio_external_connection_export       => led,      
			interrupt_pio_external_connection_export => irq_n_rr,   
			reset_reset_n                            => rst_n, -- sett til rst_n                     
            i2c_avalon_mm_if_0_conduit_end_scl_export => scl, -- i2c_avalon_mm_if_0_conduit_end_scl.export
			i2c_avalon_mm_if_0_conduit_end_sda_export => sda  -- i2c_avalon_mm_if_0_conduit_end_sda.export
        );

end architecture;


