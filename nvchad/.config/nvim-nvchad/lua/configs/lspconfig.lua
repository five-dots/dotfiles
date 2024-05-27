local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local conf = require("nvconfig").ui.lsp

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
  if conf.signature and client.server_capabilities.signatureHelpProvider then
    require("nvchad.lsp.signature").setup(client, bufnr)
  end
end

-- local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Enable lsp folding for nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Add bqls config
if not configs.bqls then
  configs.bqls = {
    default_config = {
      cmd = { "bq-language-server", "--stdio" },
      filetypes = { "sql" },
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.fn.fnamemodify(fname, ":h")
      end,
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
end

vim.api.nvim_create_user_command("BQUpdateCache", function()
  vim.lsp.buf_request(0, "bq/updateCache", nil, function() end)
end, { desc = "Update BQ Cache" })

vim.api.nvim_create_user_command("BQClearCache", function()
  vim.lsp.buf_request(0, "bq/clearCache", nil, function() end)
end, { desc = "Clear BQ Cache" })

vim.api.nvim_create_user_command("BQDryRun", function()
  vim.lsp.buf_request(0, "bq/dryRun", { uri = "file://" .. vim.fn.expand "%:p" }, function() end)
end, { desc = "Dry run BQ" })

-- Enable lua_ls
dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
  settings = {
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
  },
}

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
