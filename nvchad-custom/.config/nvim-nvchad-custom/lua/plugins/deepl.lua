return {
  "gw31415/deepl-commands.nvim",
  event = "BufEnter",
  dependencies = {
    "gw31415/deepl.vim",
    "gw31415/fzyselect.vim", -- Optional
  },
  config = function()
    require("deepl-commands").setup {
      selector_func = require("fzyselect").start,
    }
    vim.g.deepl_authkey = os.getenv("DEEPL_API_KEY")
  end,
}
