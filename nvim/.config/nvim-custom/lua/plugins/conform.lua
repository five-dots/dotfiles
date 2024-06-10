return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  -- event = 'BufWritePre', -- uncomment for format on save
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
    require("conform").setup(opts)
  end,
}
