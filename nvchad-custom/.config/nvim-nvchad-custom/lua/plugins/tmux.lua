return {
  "aserowy/tmux.nvim",
  event = "VeryLazy",
  keys = {
    -- Move nvim window or tmux pane by A-hjkl
    { "<A-h>", function() require("tmux").move_left() end },
    { "<A-j>", function() require("tmux").move_bottom() end },
    { "<A-k>", function() require("tmux").move_top() end },
    { "<A-l>", function() require("tmux").move_right() end },
    -- Resize nvim window or tmux pane by A-hjkl
    { "<C-A-h>", function() require("tmux").resize_left() end },
    { "<C-A-j>", function() require("tmux").resize_bottom() end },
    -- C-A-k が Kindle を起動するショートカットと競合する場合は、以下の記事を参考にして、無効化する
    -- https://kiyo7447.blogspot.com/2018/08/kindlectrlaltk.html
    { "<C-A-k>", function() require("tmux").resize_top() end },
    { "<C-A-l>", function() require("tmux").resize_right() end },
  },
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
