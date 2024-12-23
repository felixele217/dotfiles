local keys = {}

keys.setup = function(config, wezterm)
  config.keys = {
    -- splits
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
    { key = "s", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

    --TODO: CTRL does not work here as it conflicts with <CTRL-n> of nvim cmp plugins
    -- { key = "n", mods = "CTRL", action = act.SwitchWorkspaceRelative(1) },
    -- { key = "p", mods = "CTRL", action = act.SwitchWorkspaceRelative(-1) },
  }
end

return keys
