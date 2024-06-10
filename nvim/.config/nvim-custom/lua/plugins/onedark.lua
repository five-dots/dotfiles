return {
  "navarasu/onedark.nvim",
  lazy = false,
  enabled = false,
  priority = 1000,
  opts = {
    style = "darker",
    code_style = {
      comments = "italic",
      keywords = "italic,bold",
      functions = "bold",
      strings = "none",
      variables = "none",
    },
    transparent = true,
    lualine = {
      transparent = true,
    },
  },
  config = function(_, opts)
    require("onedark").setup(opts)
    require("onedark").load()
  end
}
