local M = {}

---@param default boolean
M.clockin = function(wezterm, cmd, default)
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

	if default then
		wezterm.mux.set_active_workspace(w_clockin.active_workspace)
	end
end

---@param default boolean
M.dotfiles = function(wezterm, cmd, default)
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

	if default then
		wezterm.mux.set_active_workspace(w_dotfiles.active_workspace)
	end
end

---@param default boolean
M.app = function(wezterm, cmd, default)
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

	if default then
		wezterm.mux.set_active_workspace(w_app.active_workspace)
	end
end

return M
