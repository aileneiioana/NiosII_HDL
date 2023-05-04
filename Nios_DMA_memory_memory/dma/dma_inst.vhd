	component dma is
		port (
			clk_clk : in std_logic := 'X'  -- clk
		);
	end component dma;

	u0 : component dma
		port map (
			clk_clk => CONNECTED_TO_clk_clk  -- clk.clk
		);

