local lsp_util = require "lspconfig.util"
local M = {}

M.on_attach = function(_, bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end
  map("gd", require("telescope.builtin").lsp_definitions, "Go to definitions") -- or vim.lsp.buf.definition
  map("gD", vim.lsp.buf.declaration, "Go to declaration")
  map("gI", require("telescope.builtin").lsp_implementations, "Go to implementations") -- or vim.lsp.buf.implementation
  map("gr", require("telescope.builtin").lsp_references, "Go to references") -- or vim.lsp.buf.references
  map("K", vim.lsp.buf.hover, "Hover Documentation")

  map("<Leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("<Leader>ch", vim.lsp.buf.signature_help, "Signature help")
  map("<Leader>ci", "<Cmd>LspInfo<CR>", "LSP info")
  map("<Leader>cl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
  map("<Leader>cr", vim.lsp.buf.rename, "Rename")
  map("<Leader>cs", require("telescope.builtin").lsp_document_symbols, "Document symbols")
  map("<Leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
  map("<Leader>ct", require("telescope.builtin").lsp_type_definitions, "Type definitions") -- or vim.lsp.buf.type_definition
  map("<Leader>cw", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  map("<Leader>cW", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
end

-- Define root_dir function that ignores dbt projects
M.find_git_ancestor_ignore_dbt = function(fname)
  local root_dir = lsp_util.find_git_ancestor(fname)
  local is_dbt_project = lsp_util.path.is_file(lsp_util.path.join(root_dir, "dbt_project.yml"))
  if is_dbt_project then
    return nil
  end
  return root_dir
end

return M
