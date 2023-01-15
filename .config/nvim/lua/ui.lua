
require("nvim-treesitter.configs").setup({
  ensure_installed = "all", -- all, maintained or list of languages
  ignore_install = {},
  highlight = {
    enable = true,
  }
})

require("nvim-web-devicons").setup({
  default = true;
})

require("nvim-autopairs").setup({})

require("neoscroll").setup()

require("colorizer").setup()

-- Color schem

-- vim.cmd("colorscheme onedark")

local onedarkpro = require("onedarkpro")
onedarkpro.setup({
  theme = "onedark",
})
onedarkpro.load()