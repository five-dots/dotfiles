return {
  "aserowy/tmux.nvim",
  config = function()
    return require("tmux").setup {
      navigation = {
        enable_default_keybindings = false,
      },
      resize = {
        enable_default_keybindings = false,
        resize_step_x = 5,
        resize_step_y = 5,
      },
    }
  end,
}
