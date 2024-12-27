local keys = {}

local function is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
  Left = "h",
  Down = "j",
  Up = "k",
  Right = "l",
  -- reverse lookup
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function split_nav(resize_or_move, key, wezterm)
  return {
    key = key,
    mods = resize_or_move == "resize" and "META" or "CTRL",
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

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
    --
    -- move between split panes
    split_nav("move", "h", wezterm),
    split_nav("move", "j", wezterm),
    split_nav("move", "k", wezterm),
    split_nav("move", "l", wezterm),
    -- resize panes
    split_nav("resize", "h", wezterm),
    split_nav("resize", "j", wezterm),
    split_nav("resize", "k", wezterm),
    split_nav("resize", "l", wezterm),
  }
end

return keys
