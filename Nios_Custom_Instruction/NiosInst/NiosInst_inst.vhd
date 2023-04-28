	component NiosInst is
		port (
			clk_clk : in std_logic := 'X'  -- clk
		);
	end component NiosInst;

	u0 : component NiosInst
		port map (
			clk_clk => CONNECTED_TO_clk_clk  -- clk.clk
		);

