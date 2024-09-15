local util = require "conform.util"

return {
  formatters = {
    shfmt = {
      prepend_args = { "--indent", "4", "--binary-next-line" },
    },
    sqlfluff = {
      command = util.find_executable({ ".venv/bin/sqlfluff" }, "sqlfluff"),
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    sh = { "shfmt" },
    -- sql = { "sqlfluff", "sqlfmt" }, -- Use LSP fallback
    yaml = { "yamlfmt" },
  },
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}
