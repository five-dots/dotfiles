return {
  "navarasu/onedark.nvim",
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
