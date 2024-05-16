-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Enable lsp folding for nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local lspconfig = require "lspconfig"

-- Add bqls config
local configs = require "lspconfig.configs"
if not configs.bqls then
  configs.bqls = {
    default_config = {
      cmd = { "bq-language-server", "--stdio" },
      filetypes = { "sql" },
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.fn.fnamemodify(fname, ':h')
      end,
      settings = {
        bqExtensionVSCode = {
          diagnostic = {
            forVSCode = false
          },
          formatting = {
            printKeywordsInUpperCase = false,
          },
        },
      },
    },
  }
end

local servers = {
  -- Default servers (lua_ls is set by default, no need to add it)
  "cssls",
  "html",
  -- Additional servers
  "bashls",
  "bqls",
  "gopls",
  "jsonls",
  "pyright",
  "tsserver",
  "yamlls",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

