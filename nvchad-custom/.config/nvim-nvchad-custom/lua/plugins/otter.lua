return {
  "jmbuhr/otter.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>co", function() require("otter").activate() end, desc = "Activate otther"}
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
}
