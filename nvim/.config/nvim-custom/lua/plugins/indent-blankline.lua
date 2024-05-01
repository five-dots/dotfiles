return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufEnter",
  keys = {
    { "<leader>ti", "<cmd>IBLToggle<cr>", desc = "Toggle indent-blankline" },
    { "<leader>tI", "<cmd>IBLToggleScope<cr>", desc = "Toggle indent-blankline scope" },
  },
  main = "ibl",
  opts = {},
}
