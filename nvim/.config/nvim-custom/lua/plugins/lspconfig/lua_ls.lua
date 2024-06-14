local lsp_configs = require "lspconfig.configs"
local lua_ls_config = require "lspconfig.server_configurations.lua_ls"

-- Edit lua_ls default config
local default_config = lua_ls_config.default_config
default_config.settings = {
  -- disable missing fields
  Lua = {
    completion = {
      callSnippet = "Replace",
    },
    diagnostics = {
      disable = { "missing-fields" },
      telemetry = { enable = false },
    },
  },
}

lsp_configs.lua_ls = {
  default_config = default_config,
}
