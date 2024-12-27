local options = {}

options.setup = function(config, wezterm)
  config.enable_tab_bar = true

  config.window_decorations = "RESIZE"

  -- Transparency
  config.window_background_opacity = 1
  config.macos_window_background_blur = 10

  config.tab_bar_at_bottom = true

  config.color_scheme = "Rosé Pine Moon (base16)" -- or Macchiato, Frappe, Latte
  -- config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte

  -- To set status once and then every hour
  config.status_update_interval = 3600 * 1000

  local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

  bar.apply_to_config(config, {
    modules = {
      tabs = {
        active_tab_fg = 4,
        inactive_tab_fg = 5,
      },
      workspace = {
        enabled = true,
        icon = wezterm.nerdfonts.cod_window,
        color = 7,
      },
      leader = {
        enabled = true,
        icon = wezterm.nerdfonts.oct_rocket,
        color = 2,
      },
      pane = { enabled = false },
      username = { enabled = false },
      hostname = { enabled = false },
      clock = {
        enabled = true,
        icon = wezterm.nerdfonts.md_calendar_clock,
        color = 5,
      },
      cwd = {
        enabled = true,
        icon = wezterm.nerdfonts.oct_file_directory,
        color = 7,
      },
    },
  })

  config.font = wezterm.font("FiraCode Nerd Font Mono")
  config.font_size = 17
  config.line_height = 1.3
  config.cell_width = 0.95 -- letter spacing

  config.use_fancy_tab_bar = false
  -- config.tab_bar_style = {
  --   active_tab_left = wezterm.format({
  --     { Background = { Color = "#0b0022" } },
  --     { Foreground = { Color = "#2b2042" } },
  --     { Text = SOLID_LEFT_ARROW },
  --   }),
  -- }

  config.window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 0,
  }

  config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
end

return options
