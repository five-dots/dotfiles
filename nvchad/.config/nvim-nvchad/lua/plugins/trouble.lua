return {
  "folke/trouble.nvim",
  keys = {
    {
      "<Leader>cd",
      "<Cmd>Trouble diagnostics toggle<CR>",
      desc = "Diagnostics",
    },
    {
      "<Leader>cD",
      "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
      desc = "Diagnostics (Buffer)",
    },
    -- {
    --   "<Leader>cs",
    --   "<Cmd>Trouble symbols toggle focus=false<CR>",
    --   desc = "Symbols",
    -- },
    -- {
    --   "<Leader>cl",
    --   "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>",
    --   desc = "LSP Definitions / references / ...",
    -- },
    -- {
    --   "<Leader>cL",
    --   "<Cmd>Trouble loclist toggle<CR>",
    --   desc = "Loclist",
    -- },
    -- {
    --   "<leader>cQ",
    --   "<cmd>Trouble qflist toggle<cr>",
    --   desc = "Quickfix list",
    -- },
  },
  opts = {}, -- for default options, refer to the configuration section for custom setup.
}
