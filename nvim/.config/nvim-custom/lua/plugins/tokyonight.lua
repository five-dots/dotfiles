return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night", -- "storm", "moon", "night" or "day"
    styles = {
      comments = { italic = true },
      keywords = { italic = true, bold = true },
      functions = { bold = true },
      variables = {},
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end
}
