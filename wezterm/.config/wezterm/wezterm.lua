local wezterm = require "wezterm"
local act = wezterm.action

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

-- Transparency
config.window_background_opacity = 0.9

-- Windows: Set WSL as default domain
-- https://wezfurlong.org/wezterm/config/lua/config/default_domain.html
config.default_domain = "WSL:Ubuntu"

-- For Wezterm + Komorebi
-- https://github.com/wez/wezterm/issues/3934
-- https://wezfurlong.org/wezterm/config/lua/config/allow_win32_input_mode.html
config.allow_win32_input_mode = false

-- -- Wezterm + Neovim integration
-- -- https://github.com/numToStr/Navigator.nvim/wiki/WezTerm-Integration
-- local function is_vi_process(pane)
--   -- get_foreground_process_name On Linux, macOS and Windows,
--   -- the process can be queried to determine this path. Other operating systems
--   -- (notably, FreeBSD and other unix systems) are not currently supported
--   return pane:get_foreground_process_name():find('n?vim') ~= nil
--   -- return pane:get_title():find("n?vim") ~= nil
-- end
--
-- local function conditional_activate_pane(window, pane, pane_direction, vim_direction)
--   if is_vi_process(pane) then
--     window:perform_action(
--       -- This should match the keybinds you set in Neovim.
--       act.SendKey({ key = vim_direction, mods = 'ALT' }),
--       pane
--     )
--   else
--     window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
--   end
-- end
--
-- wezterm.on('ActivatePaneDirection-left',  function(window, pane) conditional_activate_pane(window, pane, 'Left',  'h') end)
-- wezterm.on('ActivatePaneDirection-down',  function(window, pane) conditional_activate_pane(window, pane, 'Down',  'j') end)
-- wezterm.on('ActivatePaneDirection-up',    function(window, pane) conditional_activate_pane(window, pane, 'Up',    'k') end)
-- wezterm.on('ActivatePaneDirection-right', function(window, pane) conditional_activate_pane(window, pane, 'Right', 'l') end)
--
-- -- Keybindings
-- local mappings = require "mappings"
-- mappings.apply_to_config(config)

return config
