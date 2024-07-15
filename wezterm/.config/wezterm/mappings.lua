local wezterm = require "wezterm"
local act = wezterm.action

local M = {}

function M.apply_to_config(config)
  config.keys = {
    -- hjkl move
    {
      key = "h",
      mods = "ALT",
      action = act.ActivatePaneDirection "Left",
      -- action = act.EmitEvent "ActivatePaneDirection-left" ,
    },
    {
      key = "j",
      mods = "ALT",
      action = act.ActivatePaneDirection "Down",
      -- action = act.EmitEvent "ActivatePaneDirection-down" ,
    },
    {
      key = "k",
      mods = "ALT",
      action = act.ActivatePaneDirection "Up",
      -- action = act.EmitEvent "ActivatePaneDirection-up" ,
    },
    {
      key = "l",
      mods = "ALT",
      action = act.ActivatePaneDirection "Right",
      -- action = act.EmitEvent "ActivatePaneDirection-right" ,
    },
    -- Resize pane
    {
      key = "h",
      mods = "ALT|CTRL",
      action = act.AdjustPaneSize { "Left", 10 },
    },
    {
      key = "j",
      mods = "ALT|CTRL",
      action = act.AdjustPaneSize { "Down", 5 },
    },
    {
      key = "k",
      mods = "ALT|CTRL",
      action = act.AdjustPaneSize { "Up", 5 },
    },
    {
      key = "l",
      mods = "ALT|CTRL",
      action = act.AdjustPaneSize { "Right", 10 },
    },
    -- Close pane
    {
      key = "q",
      mods = "ALT",
      action = act.CloseCurrentPane { confirm = false },
    },
    -- Split pane
    {
      key = "\\",
      mods = "ALT",
      action = act.SplitPane { direction = "Right" },
    },
    {
      key = "-",
      mods = "ALT",
      action = act.SplitPane { direction = "Down" },
    },
    -- Swap pane
    {
      key = "w",
      mods = "ALT",
      action = act.PaneSelect {
        mode = "SwapWithActiveKeepFocus",
      },
    },
    -- Toggle zoom
    {
      key = "m",
      mods = "ALT",
      action = act.TogglePaneZoomState,
    },
    -- New tab
    {
      key = "t",
      mods = "ALT",
      action = act.SpawnTab 'CurrentPaneDomain',
    },
    -- Lazygit in new tab
    {
      key = "g",
      mods = "ALT",
      action = act.SpawnCommandInNewTab {
        args = { "lazygit" },
      },
    },
  }

  -- Switch tab by Alt-1..9
  for i = 1, 9 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = "ALT",
      action = act.ActivateTab(i - 1),
    })
  end
end

return M
