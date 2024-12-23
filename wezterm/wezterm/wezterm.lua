local wezterm = require("wezterm")
local mux = wezterm.mux

-- Create and set workspaces
wezterm.on("gui-startup", function(cmd)
	local workspace = require("utils.workspace")

	workspace.create_clockin_workspace(wezterm, cmd)
	workspace.create_dotfiles_workspace(wezterm, cmd)

	mux.set_active_workspace("clockin")
end)

-- Set status
wezterm.on("update-status", function(window)
	window:set_left_status("     " .. window:active_workspace() .. "     ")
	window:set_right_status("")
end)

local config = wezterm.config_builder()

require("config.options").setup(config, wezterm)
require("config.keys").setup(config, wezterm)

return config
