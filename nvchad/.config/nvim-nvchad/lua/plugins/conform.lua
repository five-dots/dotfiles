local conform = require "conform"

return {
  "stevearc/conform.nvim",
  -- event = 'BufWritePre', -- uncomment for format on save
  keys = {
    {
      "<Leader>cf",
      function()
        conform.format { lsp_fallback = true }
      end,
      desc = "Format files",
    },
  },
  opts = {
    formatters = {
      shfmt = {
        prepend_args = { "--indent", "4", "--binary-next-line" },
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      yaml = { "yamlfmt" },
    },
    -- format_on_save = {
    --   -- These options will be passed to conform.format()
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },
  },
  config = function(_, opts)
    conform.setup(opts)
  end,
}
