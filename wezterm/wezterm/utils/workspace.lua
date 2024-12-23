local M = {}

M.create_clockin_workspace = function(wezterm, cmd)
	-- spawn inital window
	local cl_nvim_tab, cl_nvim_pane, cl_window = wezterm.mux.spawn_window({
		workspace = "clockin",
		cwd = wezterm.home_dir .. "/code/clockin",
		args = cmd or {},
	} or {})

	-- maximize window
	cl_window:gui_window():maximize()

	-- spawn and set tabs
	local cl_term_tab, cl_dev_pane, _ = cl_window:spawn_tab({})
	cl_nvim_tab:activate()

	-- setup pane cli's
	cl_nvim_pane:send_text("vim\n")
	cl_dev_pane:send_text("clear\n")
	cl_dev_pane:send_text("npm run dev\n")

	-- create split
	local cl_cli_pane = cl_dev_pane:split({ direction = "Left", size = 0.7 })
end

M.create_dotfiles_workspace = function(wezterm, cmd)
	-- spawn initial window
	local df_nvim_tab, df_nvim_pane, df_window = wezterm.mux.spawn_window({
		workspace = "dotfiles",
		cwd = wezterm.home_dir .. "/code/dotfiles",
		args = cmd or {},
	} or {})

	-- launch vim
	df_nvim_pane:send_text("vim\n")
end

return M
