local wezterm = require("wezterm")
local act = wezterm.action

-- Maximize on startup
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- Set right status
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

local config = wezterm.config_builder()

config.enable_tab_bar = true

config.window_decorations = "RESIZE"

-- Transparency
config.window_background_opacity = 0.85
config.macos_window_background_blur = 0

-- config.color_scheme = "Rosé Pine Moon (base16)" -- or Macchiato, Frappe, Latte
-- config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte

config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 17
config.line_height = 1.3
config.cell_width = 0.95 -- letter spacing

config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 0,
}

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- splitting
	{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "=", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- switch to tabs
	{ key = "1", mods = "CMD", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "CMD", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "CMD", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "CMD", action = wezterm.action.ActivateTab(3) },

	-- close pane
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- workspaces
	{ key = "9", mods = "CMD", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
	{ key = "n", mods = "CTRL", action = act.SwitchWorkspaceRelative(1) },
	{ key = "p", mods = "CTRL", action = act.SwitchWorkspaceRelative(-1) },
}

return config
