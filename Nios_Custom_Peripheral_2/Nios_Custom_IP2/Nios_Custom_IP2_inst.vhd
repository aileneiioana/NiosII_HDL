	component Nios_Custom_IP2 is
		port (
			clk_clk : in std_logic := 'X'  -- clk
		);
	end component Nios_Custom_IP2;

	u0 : component Nios_Custom_IP2
		port map (
			clk_clk => CONNECTED_TO_clk_clk  -- clk.clk
		);

