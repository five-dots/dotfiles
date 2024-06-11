return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
        end
        map("gd", require("telescope.builtin").lsp_definitions, "Go to definitions")
        -- map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gI", require("telescope.builtin").lsp_implementations, "Go to implementations")
        -- map("gI", vim.lsp.buf.implementation, "Go to implementation")
        map("gr", require("telescope.builtin").lsp_references, "Go to references")
        -- map("gr", vim.lsp.buf.references, "Go to references")
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
        map("<Leader>ct", require("telescope.builtin").lsp_type_definitions, "Type definitions")
        -- map("<Leader>ct", vim.lsp.buf.type_definition, "Type definition")
        map("<Leader>cw", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
        map("<Leader>cW", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        --   map("<leader>th", function()
        --     vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
        --   end, "Inlay Hints")
        -- end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      bashls = {},
      gopls = {},
      jsonls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      },
      pyright = {},
      yamlls = {},
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- Linters
      "shellcheck",
      "sqlfluff",
      -- Formatters
      "black",
      "stylua",
    })
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }

    -- Disable underline for diagnostics
    -- https://www.reddit.com/r/neovim/comments/lciqhp/disable_annoying_underline_when_make_errors/
    vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { underline = false })
  end,
  dependencies = {
    -- mason.nvim
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
    -- mason-lspconfig.nvim
    {
      "williamboman/mason-lspconfig.nvim",
    },
    -- mason-tool-installer.nvim
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    -- telescope.nvim
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.6",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- fidget.nvim
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
    -- neodev.nvim
    {
      "folke/neodev.nvim",
      opts = {},
    },
  },
}
