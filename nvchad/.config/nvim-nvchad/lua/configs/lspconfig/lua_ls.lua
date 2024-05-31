local lsp_configs = require "lspconfig.configs"
local luals_config = require "lspconfig.server_configurations.lua_ls"

-- Edit lua_ls default config
local default_config = luals_config.default_config
default_config.settings = {
  Lua = {
    diagnostics = {
      globals = { "vim" },
    },
    workspace = {
      library = {
        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
        [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
      },
      maxPreload = 100000,
      preloadFileSize = 10000,
    },
  },
}

lsp_configs.lua_ls = {
  default_config = default_config,
}
