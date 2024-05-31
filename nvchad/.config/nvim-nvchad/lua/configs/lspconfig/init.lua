local lspconfig = require "lspconfig"

-- Define custome on_attach function
local map = vim.keymap.set
local on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  map("n", "gd", vim.lsp.buf.definition, opts "LSP go to definition")
  map("n", "gD", vim.lsp.buf.declaration, opts "LSP go to declaration")
  map("n", "gi", vim.lsp.buf.implementation, opts "LSP go to implementation")
  map("n", "gr", vim.lsp.buf.references, opts "LSP show references")
  map("n", "K", vim.lsp.buf.hover, opts "LSP hover information")

  map("n", "<leader>cd", vim.diagnostic.setloclist, { desc = "Diagnostics" })
  map("n", "<leader>ch", vim.lsp.buf.signature_help, opts "Signature help")
  map("n", "<leader>ci", "<Cmd>LspInfo<CR>", opts "LSP info")
  map("n", "<leader>cl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")
  map("n", "<leader>cr", function()
    require "nvchad.lsp.renamer"()
  end, opts "Rename")
  map("n", "<leader>ct", vim.lsp.buf.type_definition, opts "Type definition")
  map("n", "<leader>cw", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>cW", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")

  -- setup signature popup
  local conf = require("nvconfig").ui.lsp
  if conf.signature and client.server_capabilities.signatureHelpProvider then
    require("nvchad.lsp.signature").setup(client, bufnr)
  end
end

-- Load nvchad's default functions
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Enable lsp folding for nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Add/Edit default configs for custom servers
require "configs.lspconfig.bqls"
require "configs.lspconfig.lua_ls"
require "configs.lspconfig.yamlls"

dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local servers = {
  -- Default servers
  "cssls",
  "html",
  "lua_ls",
  -- Additional servers
  "bashls",
  "bqls",
  "gopls",
  "jsonls",
  "pyright",
  "tsserver",
  "yamlls",
  "yamlls_dbt",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end
