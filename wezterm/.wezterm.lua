-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Maximize on startup
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

-- Transparency
config.window_background_opacity = 0.95
config.macos_window_background_blur = 50

config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte



config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 17
config.line_height = 1.4

wezterm.on("gui-startup", function()
    -- local tab, pane, window = mux.spawn_window {}
    window:gui_window():maximize()
end)

config.window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 0,
}
-- config.window_padding = {
--     left = 0,
--     right = 0,
--     top = 0,
--     bottom = 0,
-- }


-- and finally, return the configuration to wezterm
return config
