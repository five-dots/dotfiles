local cmp = require "cmp"

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
        "lua-language-server", "stylua",
  			"html-lsp", "css-lsp", "prettier",
        "pyright",
  		},
  	},
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css",
        "python",
  		},
  	},
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        ignore = false,
      },
      view = {
        adaptive_size = true,
        side = "right",
        width = 40,
      },
      renderer = {
        icons = {
          show = {
            git = false,
          },
        },
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = {
      completion = {
        keyword_length = 2,
      },
      view = {
        docs = {
          auto_open = false,
        },
      },
      mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-S-Tab>"] = cmp.mapping.complete(),
        ["<PageUp>"] = cmp.mapping.scroll_docs(-4),
        ["<PageDown>"] = cmp.mapping.scroll_docs(4),

        -- Toggle docs
        ["<Insert>"] = cmp.mapping(function(fallback)
          if not cmp.visible() then
            fallback()
          end
          if cmp.visible_docs() then
            cmp.close_docs()
          else
            cmp.open_docs()
          end
        end, { "i", "s" }), -- i=insert, c=command, s=select
      },
    },
  },
}
