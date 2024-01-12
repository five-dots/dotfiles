local wezterm = require "wezterm"
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "DoomOne"

-- Font
config.font = wezterm.font_with_fallback {
  "JetBrainsMono Nerd Font",
  "MeiryoKe_Console"
}
config.font_size = 13

-- Tab
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

config.window_background_opacity = 0.8

-- Windows: Set WSL as default domain
-- https://wezfurlong.org/wezterm/config/lua/config/default_domain.html
config.default_domain = "WSL:Ubuntu"

return config