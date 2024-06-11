return {
  "qpkorr/vim-bufkill",
  event = "VeryLazy",
  init = function()
    vim.g.BufKillCreateMappings = 0
  end
}
