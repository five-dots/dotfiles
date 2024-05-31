local lsp_configs = require "lspconfig.configs"
local lsp_util = require "lspconfig.util"
local util = require "configs.lspconfig.util"
local yamlls_config = require "lspconfig.server_configurations.yamlls"

-- Edit yamlls default config
local default_config = yamlls_config.default_config
default_config.root_dir = util.find_git_ancestor_ignore_dbt
default_config.single_file_support = false

lsp_configs.yamlls = {
  default_config = default_config,
}

-- Add yamlls for dbt
local default_dbt_config = yamlls_config.default_config
default_dbt_config.root_dir = lsp_util.root_pattern "dbt_project.yml"
default_dbt_config.single_file_support = false
default_dbt_config.filetypes = { 'yaml' }
default_dbt_config.settings = {
  -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
  redhat = {
    telemetry = { enabled = false },
  },
  -- Add dbt's JSON schemas (https://github.com/dbt-labs/dbt-jsonschema)
  yaml = {
    schemas = {
      ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/dbt_yml_files-latest.json"] = {
        "/analyses/**/*.yml",
        "/macros/**/*.yml",
        "/models/**/*.yml",
        "/seeds/**/*.yml",
        "/snanpshots/**/*.yml",
        "/tests/**/*.yml",
      },
      ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/dbt_project-latest.json"] = "dbt_project.yml",
      ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/selectors-latest.json"] = "selectors.yml",
      ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/latest/packages-latest.json"] = "packages.yml",
    },
  },
}

lsp_configs.yamlls_dbt = {
  default_config = default_dbt_config,
}
