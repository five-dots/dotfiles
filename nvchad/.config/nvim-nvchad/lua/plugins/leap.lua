return {
  "ggandor/leap.nvim",
  keys = {
    { "s", "<Plug>(leap-forward)", desc = "Leap forward", mode = { "n", "x", "o" } },
    -- Visual mode (x) の S は、nvim-surround で使うので割り当てない
    { "S", "<Plug>(leap-backward)", desc = "Leap backward", mode = { "n", "o" } },
    { "gs", "<Plug>(leap-from-window)", desc = "Leap from window", mode = { "n", "x", "o" } },
  },
}
