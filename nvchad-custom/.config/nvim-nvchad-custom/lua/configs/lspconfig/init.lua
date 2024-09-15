-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- Add/Edit default configs for custom servers
require "configs.lspconfig.bqls"
require "configs.lspconfig.yamlls"

local servers = {
  -- Default servers
  "html",
  "cssls",
  -- Additional servers
  "autotools_ls", -- for Makefile
  "bashls",
  "bqls",
  "dockerls",
  "gopls",
  "jsonls",
  "nushell",
  "pyright",
  "r_language_server",
  "taplo",
  "ts_ls",
  "yamlls",
  "yamlls_dbt",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
