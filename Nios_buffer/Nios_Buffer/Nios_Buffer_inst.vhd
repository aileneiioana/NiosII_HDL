	component Nios_Buffer is
		port (
			clk_clk : in std_logic := 'X'  -- clk
		);
	end component Nios_Buffer;

	u0 : component Nios_Buffer
		port map (
			clk_clk => CONNECTED_TO_clk_clk  -- clk.clk
		);

