-- Init code from "nvchad.configs.lspconfig.defaults()"
dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local util = require "configs.lspconfig.util"

-- Add/Edit default configs for custom servers
require "configs.lspconfig.bqls"
require "configs.lspconfig.lua_ls"
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
  "lua_ls",
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
    on_attach = util.on_attach, -- Use custom on_attach
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
