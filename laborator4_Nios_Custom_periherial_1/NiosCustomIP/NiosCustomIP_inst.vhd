	component NiosCustomIP is
		port (
			clk_clk   : in  std_logic                    := 'X'; -- clk
			leds_leds : out std_logic_vector(9 downto 0)         -- leds
		);
	end component NiosCustomIP;

	u0 : component NiosCustomIP
		port map (
			clk_clk   => CONNECTED_TO_clk_clk,   --  clk.clk
			leds_leds => CONNECTED_TO_leds_leds  -- leds.leds
		);

