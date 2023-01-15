
local cfg = require("lspconfig")

-- Common {{{
local base_capabilities = vim.lsp.protocol.make_client_capabilities()

-- vim.cmd("autocmd ColorScheme * highlight NormalFloat guibg=#1f2335")
-- vim.cmd("autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335")

-- TODO fix boarder chars
local border = {
      {"╔", "FloatBorder"},
      {"═", "FloatBorder"},
      {"╗", "FloatBorder"},
      {"║", "FloatBorder"},
      {"╝", "FloatBorder"},
      {"═", "FloatBorder"},
      {"╚", "FloatBorder"},
      {"║", "FloatBorder"},
      -- {" ", "FloatBorder"},
      -- {"▔", "FloatBorder"},
      -- {" ", "FloatBorder"},
      -- {"▕", "FloatBorder"},
      -- {" ", "FloatBorder"},
      -- {"▁", "FloatBorder"},
      -- {" ", "FloatBorder"},
      -- {"▏", "FloatBorder"},
}
--}}}

-- Lua {{{

-- sumneko/lua-language-server: https://github.com/sumneko/lua-language-server
-- nvim-lspconfig: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua

local on_attach_sumneko_lua = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border})
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})

  -- Mappings.
  local opts = {noremap=true, silent=true}

  -- See `:help vim.lsp.*` for documentation on any of the below functions

  -- Not supported
  -- buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  -- Not supported
  -- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

  -- TODO Not work (missing runtime path setting?)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  buf_set_keymap("n", "<Leader>ll", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<Leader>la", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>lr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)

  -- Not supported
  -- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

  buf_set_keymap("n", "<LocalLeader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<Leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<Leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

  -- Not suported ?
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local sumneko_home = "/home/shun/repos/github/sumneko/lua-language-server"
local sumneko_bin = sumneko_home .. "/bin/Linux/lua-language-server"
local sumneko_log = vim.fn.stdpath("cache") .. "/sumneko_lsp"

-- local lua_runtime_path = vim.split(package.path, ";")
-- table.insert(lua_runtime_path, "lua/?.lua")
-- table.insert(lua_runtime_path, "lua/?/init.lua")

-- What values for Lua.runtime.path and Lua.workspace.library? #259
-- https://github.com/sumneko/lua-language-server/issues/259

cfg.sumneko_lua.setup({
  cmd = {sumneko_bin, "-E", sumneko_home .. "/main.lua", "--logpath=" .. sumneko_log};
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {"vim"},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
  -- TODO 意味を調べる
  capabilities = require("cmp_nvim_lsp").update_capabilities(base_capabilities),
  on_attach = on_attach_sumneko_lua,
})
--}}}

-- Python {{{

-- https://github.com/microsoft/pyright

cfg.pyright.setup({})
--}}}

-- R {{{

cfg.r_language_server.setup({
  cmd = { "R", "--slave", "-e", "languageserver::run()" };
  filetypes = {"r", "rmd"},
  log_level = 2,
  -- root_dir = root_pattern(".git") or os_homedir,
})
--}}}

-- JSON{{{

-- nvim-lspでtsconfig.jsonとかの補完をする方法(JSON schema)
-- https://zenn.dev/nazo6/articles/989d44e16b1abb

local on_attach_jsonls = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = {noremap=true, silent=true}

  -- See `:help vim.lsp.*` for documentation on any of the below functions

  -- Not supported
  -- buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  -- Not supported
  -- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

  -- TODO Not work (missing runtime path setting?)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)

  -- Not supported
  -- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

  -- Not suported ?
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Enable snippet capability for completion
local jsonls_capabilities = base_capabilities
jsonls_capabilities.textDocument.completion.completionItem.snippetSupport = true

cfg.jsonls.setup({
  cmd = {"vscode-json-language-server", "--stdio"},
  filetypes = {"json", "jsonc"},
  settings = {
    json = {
      -- JSON Schema Store: https://www.schemastore.org/json/
      schemas = {
        -- https://github.com/sumneko/lua-language-server/wiki/Setting-without-VSCode
        {
          fileMatch = {"sumneko_lua_config.json", ".luarc.json"},
          url = {"https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json"},
        }
      },
    },
  },
  capabilities = jsonls_capabilities,
  on_attach = on_attach_jsonls,
})
--}}}

-- nvim-cmp{{{

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
   ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
   ["<C-f>"]     = cmp.mapping.scroll_docs(4),
   ["<C-Space>"] = cmp.mapping.complete(),
   ["<C-e>"]     = cmp.mapping.close(),
   ["<TAB>"]     = cmp.mapping.confirm({select = true}),
   ["<CR>"]      = cmp.mapping.confirm({select = true}),
  },
  sources = {
    {name = "buffer"},
    {name = "path"},
    {name = "nvim_lsp"},
    {name = "treesitter"},
    {name = "luasnip"},
    -- {name = "emoji"},
  },
  formatting = {
    format = lspkind.cmp_format({with_text = true, maxwidth = 50})
  },
})
--}}}

