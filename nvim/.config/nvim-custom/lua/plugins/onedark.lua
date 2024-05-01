return {
  "navarasu/onedark.nvim",
  -- keys = {
  --   { "<leader>ts", function() require("onedark").toggle() end, desc = "Toggle onedark style" },
  -- },
  opts = {
    toggle_style_key = "<leader>ts",
    toggle_style_list = {
      "dark",
      "darker",
      "cool",
      "deep",
      "warm",
      "warmer",
      "light",
    },
    -- Options: italic, bold, underline, none
    code_style = {
      comments = "italic",
      keywords = "none",
      functions = "none",
      strings = "none",
      variables = "none"
    },
  },
  config = function(_, opts)
    require("onedark").setup(opts)
    require("onedark").load()
  end,
}
