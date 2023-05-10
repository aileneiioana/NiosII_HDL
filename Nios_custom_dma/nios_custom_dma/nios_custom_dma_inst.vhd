	component nios_custom_dma is
		port (
			clk_clk : in std_logic := 'X'  -- clk
		);
	end component nios_custom_dma;

	u0 : component nios_custom_dma
		port map (
			clk_clk => CONNECTED_TO_clk_clk  -- clk.clk
		);

