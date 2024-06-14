local wezterm = require "wezterm"
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "OneDark (base16)"

-- Font
config.font = wezterm.font_with_fallback {
  "JetBrainsMono Nerd Font",
  "MeiryoKe_Console"
}
config.font_size = 13

-- Tab
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

config.window_background_opacity = 0.7

-- Windows: Set WSL as default domain
-- https://wezfurlong.org/wezterm/config/lua/config/default_domain.html
config.default_domain = "WSL:Ubuntu"

-- For Wezterm + Komorebi
-- https://github.com/wez/wezterm/issues/3934
-- https://wezfurlong.org/wezterm/config/lua/config/allow_win32_input_mode.html
config.allow_win32_input_mode = false

-- Key Binding
config.keys = {
  -- Disable next tab by Ctrl-Tab
  {
    key = "Tab",
    mods = "CTRL",
    action = wezterm.action.DisableDefaultAssignment,
  },
  -- Disable prev tab by Ctrl-Shift-Tab
  {
    key = "Tab",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return config
