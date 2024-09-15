local lsp_configs = require "lspconfig.configs"
local lua_ls_config = require "lspconfig.server_configurations.lua_ls"

-- Edit lua_ls default config
local default_config = lua_ls_config.default_config
default_config.settings = {
  Lua = {
    diagnostics = {
      globals = { "vim" },
    },
    workspace = {
      library = {
        vim.fn.expand "$VIMRUNTIME/lua",
        vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
        vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
        vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        "${3rd}/luv/library",
      },
      maxPreload = 100000,
      preloadFileSize = 10000,
    },
  },
}

lsp_configs.lua_ls = {
  default_config = default_config,
}
