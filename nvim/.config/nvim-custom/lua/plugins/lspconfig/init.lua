return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require "lspconfig"
    local util = require "plugins.lspconfig.util"

    local on_attach = util.on_attach
    local capabilities = util.capabilities

    -- Load server specific configs
    require "plugins.lspconfig.bqls"
    require "plugins.lspconfig.lua_ls"
    require "plugins.lspconfig.yamlls"

    local servers = {
      "autotools_ls", -- for Makefile
      "bashls",
      "bqls",
      "dockerls",
      "gopls",
      "jsonls",
      "lua_ls",
      "nushell",
      "pyright",
      "r_language_server",
      "taplo",
      "tsserver",
      "yamlls",
      "yamlls_dbt",
    }

    -- lsps with default config
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end

    -- Disable underline for diagnostics
    -- https://www.reddit.com/r/neovim/comments/lciqhp/disable_annoying_underline_when_make_errors/
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { underline = false })
  end,

  dependencies = {
    -- telescope.nvim
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.6",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- fidget.nvim
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
    -- neodev.nvim
    {
      "folke/neodev.nvim",
      opts = {},
    },
  },
}
