return {
  ensure_installed = {
    -- Default lsp servers
    "html-lsp",
    "css-lsp",
    "lua-language-server",
    -- Additional lsp servers
    "bash-language-server",
    "gopls",
    "json-lsp",
    "pyright",
    "typescript-language-server",
    "yaml-language-server",
    -- Additional linters
    "shellcheck",
    "sqlfluff",
    -- Default formatters
    "prettier",
    "shfmt",
    "stylua",
    "yamlfmt",
    -- Additional formatters
    "black",
    -- Additional dap adapters
    "bash-debug-adaptor",
  },
}
