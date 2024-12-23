local M = {}

M.create_clockin_workspace = function(wezterm, cmd)
	-- spawn inital window
	local t_nvim, p_nvim, w_clockin = wezterm.mux.spawn_window({
		workspace = "clockin",
		cwd = wezterm.home_dir .. "/code/clockin",
		args = cmd or {},
	} or {})

	-- maximize window
	w_clockin:gui_window():maximize()

	-- spawn and set tabs
	local t_term, p_dev, _ = w_clockin:spawn_tab({})
	t_nvim:activate()

	-- setup pane cli's
	p_nvim:send_text("vim\n")
	p_dev:send_text("clear\n")
	p_dev:send_text("npm run dev\n")

	-- create split
	local p_cli = p_dev:split({ direction = "Left", size = 0.7 })
end

M.create_dotfiles_workspace = function(wezterm, cmd)
	-- spawn initial window
	local t_nvim, p_nvim, w_dotfiles = wezterm.mux.spawn_window({
		workspace = "dotfiles",
		cwd = wezterm.home_dir .. "/code/dotfiles",
		args = cmd or {},
	} or {})

	-- launch vim
	p_nvim:send_text("vim\n")

	-- spawn and set tabs
	local t_term, p_cli, _ = w_dotfiles:spawn_tab({})
	t_nvim:activate()
end

M.create_app_workspace = function(wezterm, cmd)
	-- spawn initial window
	local t_nvim, p_nvim, w_app = wezterm.mux.spawn_window({
		workspace = "app",
		cwd = wezterm.home_dir .. "/code/app",
		args = cmd or {},
	} or {})

	-- launch vim
	p_nvim:send_text("vim\n")

	-- spawn and set tabs
	local t_term, p_dev, _ = w_app:spawn_tab({})
	t_nvim:activate()

	-- setup pane cli's
	p_nvim:send_text("vim\n")
	p_dev:send_text("clear\n")
	p_dev:send_text("npm run dev\n")

	-- create split
	local p_cli = p_dev:split({ direction = "Left", size = 0.7 })
end

return M
