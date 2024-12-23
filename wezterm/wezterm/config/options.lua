local options = {}

options.setup = function(config, wezterm)
	config.enable_tab_bar = false

	config.window_decorations = "RESIZE"

	-- Transparency
	config.window_background_opacity = 1
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
end

return options
