local wezterm = require("wezterm")

-- Maximize on startup
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

-- Transparency
config.window_background_opacity = 1
config.macos_window_background_blur = 20

-- config.color_scheme = "Rosé Pine Moon (base16)" -- or Macchiato, Frappe, Latte
-- config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 16
config.line_height = 1.3

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

    { key = "1", mods = "CMD",    action = wezterm.action.ActivateTab(0) },
    { key = "2", mods = "CMD",    action = wezterm.action.ActivateTab(1) },
    { key = "3", mods = "CMD",    action = wezterm.action.ActivateTab(2) },
    { key = "4", mods = "CMD",    action = wezterm.action.ActivateTab(3) },
    { key = "w", mods = "CMD",    action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}

return config
