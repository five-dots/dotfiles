local wezterm = require "wezterm"
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Colors
config.color_scheme = "OneDark (base16)"
config.colors = {
  background = "#1e222a", -- Same as NvChad's onedark bgcolor
}

-- Font
config.font = wezterm.font_with_fallback {
  "UDEV Gothic NFLG",
}
config.font_size = 14

-- Tab
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- Transparency
-- config.window_background_opacity = 0.9

-- Windows: Set WSL as default domain
-- https://wezfurlong.org/wezterm/config/lua/config/default_domain.html
config.default_domain = "WSL:Ubuntu"

-- For Wezterm + Komorebi
-- https://github.com/wez/wezterm/issues/3934
-- https://wezfurlong.org/wezterm/config/lua/config/allow_win32_input_mode.html
config.allow_win32_input_mode = false

-- Disable default keybindings
config.keys = {
  {
    key = "Tab",
    mods = "CTRL",
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = "Tab",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DisableDefaultAssignment,
  },
}

-- -- Keybindings
-- local mappings = require "mappings"
-- mappings.apply_to_config(config)

return config
