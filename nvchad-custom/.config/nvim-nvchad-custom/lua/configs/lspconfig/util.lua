local lsp_util = require "lspconfig.util"
local M = {}

-- Define root_dir function that ignores dbt projects
function M.find_git_ancestor_ignore_dbt(fname)
  local root_dir = lsp_util.find_git_ancestor(fname)
  local is_dbt_project = lsp_util.path.is_file(lsp_util.path.join(root_dir, "dbt_project.yml"))
  if is_dbt_project then
    return nil
  end
  return root_dir
end

return M
