local keys = {}

local wezterm = require("wezterm")

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

local function split_nav(resize_or_move, key)
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

local function kill_workspace(workspace)
  local success, stdout = wezterm.run_child_process({ "/opt/homebrew/bin/wezterm", "cli", "list", "--format=json" })

  if success then
    local json = wezterm.json_parse(stdout)
    if not json then
      return
    end

    local function filter(tbl, callback)
      local filt_table = {}

      for i, v in ipairs(tbl) do
        if callback(v, i) then
          table.insert(filt_table, v)
        end
      end
      return filt_table
    end

    local workspace_panes = filter(json, function(p)
      return p.workspace == workspace
    end)

    for _, p in ipairs(workspace_panes) do
      wezterm.run_child_process({
        "/opt/homebrew/bin/wezterm",
        "cli",
        "kill-pane",
        "--pane-id=" .. p.pane_id,
      })
    end
  end
end

keys.setup = function(config)
  config.keys = {
    -- move between split panes
    split_nav("move", "h"),
    split_nav("move", "j"),
    split_nav("move", "k"),
    split_nav("move", "l"),

    -- splits
    { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "=", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

    -- switch to tabs
    { key = "1", mods = "CMD", action = wezterm.action.ActivateTab(0) },
    { key = "2", mods = "CMD", action = wezterm.action.ActivateTab(1) },
    { key = "3", mods = "CMD", action = wezterm.action.ActivateTab(2) },
    { key = "4", mods = "CMD", action = wezterm.action.ActivateTab(3) },
    { key = "t", mods = "LEADER", action = wezterm.action.EmitEvent("toggle-tab-bar") },

    -- close pane
    { key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

    -- show debug overlay
    { key = "d", mods = "LEADER", action = wezterm.action.ShowDebugOverlay },

    -- workspaces
    { key = "s", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

    -- in cli, hop back and forward words with this shortcut
    { key = "b", mods = "CTRL", action = wezterm.action({ SendString = "\b" }) },
    { key = "w", mods = "CTRL", action = wezterm.action({ SendKey = { key = "f", mods = "ALT" } }) },

    {
      key = "k",
      mods = "LEADER",
      action = wezterm.action_callback(function(window)
        local w = window:active_workspace()
        kill_workspace(w)
      end),
    },
  }
end

return keys
