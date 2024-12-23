local wezterm = require("wezterm")

-- Create and set workspaces
wezterm.on("gui-startup", function(cmd)
  local workspace = require("utils.workspace")

  workspace.clockin(wezterm, cmd, true)
  workspace.dotfiles(wezterm, cmd)
  workspace.app(wezterm, cmd)
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
