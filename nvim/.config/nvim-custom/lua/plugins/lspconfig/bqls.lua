local lsp_configs = require "lspconfig.configs"
local util = require "plugins.lspconfig.util"

lsp_configs.bqls = {
  default_config = {
    cmd = { "bq-language-server", "--stdio" },
    filetypes = { "sql" },
    root_dir = util.find_git_ancestor_ignore_dbt,
    settings = {
      bqExtensionVSCode = {
        diagnostic = {
          forVSCode = false,
        },
        formatting = {
          printKeywordsInUpperCase = false,
        },
      },
    },
  },
}
