	component HelloNiosIntr is
		port (
			clk_clk : in std_logic := 'X'  -- clk
		);
	end component HelloNiosIntr;

	u0 : component HelloNiosIntr
		port map (
			clk_clk => CONNECTED_TO_clk_clk  -- clk.clk
		);

