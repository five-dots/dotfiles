return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    { "<Leader>cd", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
    { "<Leader>cD", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Diagnostics (Buffer)" },
  },
  config = function()
    require("trouble").setup()
  end,
}
