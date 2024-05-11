local cmp = require "cmp"

return {
  -- conform.nvim
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- mason.nvim
  {
  	"williamboman/mason.nvim",
  	opts = {
  		ensure_installed = {
        -- default lsp
  			"html-lsp",
        "css-lsp",
        "lua-language-server",
        -- default formatter
        "prettier",
        "stylua",
        -- additional lsp
        "bash-language-server",
        "json-lsp",
        "lua-language-server",
        "pyright",
        "yaml-language-server",
  		},
  	},
  },

  -- nvim-treesitter
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
      ensure_installed = {
        -- defaults
        "css",
        "html",
        "lua",
        "vim",
        "vimdoc",
        -- language
        "bash",
        "dockerfile",
        "go",
        "markdown",
        "python",
        "r",
        "sql",
        -- data
        "csv",
        "json",
        "jsonc",
        "toml",
        "yaml",
        -- missing noice.nvim requirements
        "markdown_inline",
        "regex",
  		},
  	},
  },

  -- nvim-tree.lua
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        ignore = false,
      },
      view = {
        width = 40,
        number = true,
        relativenumber = true,
      },
      renderer = {
        special_files = {},
        icons = {
          show = {
            git = false,
          },
        },
      },
    },
  },

  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    opts = {
      completion = {
        completeopt = "menu,menuone,noselect",
      },
      view = {
        docs = {
          auto_open = false,
        },
      },
      mapping = {
        ["<up>"] = cmp.mapping.select_prev_item(),
        ["<down>"] = cmp.mapping.select_next_item(),
        ["<c-s-tab>"] = cmp.mapping.complete(),
        ["<home>"] = cmp.mapping.abort(),
        ["<pageup>"] = cmp.mapping.scroll_docs(-4),
        ["<pagedown>"] = cmp.mapping.scroll_docs(4),

        -- Toggle docs
        ["<insert>"] = cmp.mapping(function(fallback)
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

    dependencies = {
      {
        "hrsh7th/cmp-cmdline",
        event = { "CmdLineEnter" },
        opts = { history = true, updateevents = "CmdlineEnter,CmdlineChanged" },
        config = function()
          -- Enable ":" completion
          cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = 'path' }
            },
            {
              { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
          })

          -- Enable "/" completion
          cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = "buffer" },
            },
          })
        end,
      },
    },
  },

  -- noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- cmdline = { enabled = false },
      messages = { enabled = false },
      notify = { enabled = false },
      popupmenu = { enabled = false },
      lsp = {
        progress = { enabled = false },
        message = { enabled = false },
        hover = { enabled = false },
        signature = { enabled = false },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup{}
    end,
  },
}

