local wezterm = require("wezterm")

-- Create and set workspaces
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window {}
  window:gui_window():maximize()
  -- local workspace = require("utils.workspace")
  -- workspace.clockin(wezterm, cmd, true)
  -- workspace.dotfiles(wezterm, cmd)
  -- workspace.app(wezterm, cmd)
end)

-- Set status
wezterm.on("update-status", function(window)
  wezterm.log_info(wezterm.mux.get_active_workspace())
  window:set_left_status("     " .. window:active_workspace() .. "     ")
  window:set_right_status("")
end)

-- Toggle tab bar visibility
wezterm.on("toggle-tab-bar", function(window, _)
  local overrides = window:get_config_overrides() or {}

  if overrides.enable_tab_bar == false then
    overrides.enable_tab_bar = true
  else
    overrides.enable_tab_bar = false
  end

  window:set_config_overrides(overrides)
end)

local config = wezterm.config_builder()

require("config.options").setup(config, wezterm)
require("config.keys").setup(config)

return config
