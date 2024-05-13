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
        -- Default lsp servers
  			"html-lsp",
        "css-lsp",
        "lua-language-server",
        -- Additional lsp servers
        "bash-language-server",
        "gopls",
        "json-lsp",
        "pyright",
        "yaml-language-server",
        -- Additional linters
        "shellcheck",
        "sqlfluff",
        -- Default formatters
        "prettier",
        "stylua",
        -- Additional formatters
        "black",
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

  -- nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup{}
    end,
  },

  -- nvim-ufo 
  {
    -- Reference: https://github.com/chrisgrieser/.config/blob/main/nvim/lua/plugins/folding-plugins.lua
    "kevinhwang91/nvim-ufo",
    event = "VimEnter",
    dependencies = {
      "kevinhwang91/promise-async"
    },
    init = function ()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
    keys = {
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      -- closeFoldsWith(0) と closeAllFolds() は同じ挙動
      { "zm", function() require("ufo").closeFoldsWith(0) end, desc = "Close folds with" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    },
    opts = function()
      -- https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#customize-fold-text
      local function fold_virt_text_line_nums(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" ↙ %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, "MoreMsg"})
        return newVirtText
      end

      -- https://github.com/kevinhwang91/nvim-ufo/issues/26
      local function fold_virt_text_line_nums_bottom_line(virt_text, lnum, end_lnum, width, truncate)
        local result = {}
        local _end = end_lnum - 1
        -- Get the last folded line text
        local final_text = vim.trim(vim.api.nvim_buf_get_text(0, _end, 0, _end, -1, {})[1])
        local suffix = final_text:format(end_lnum - lnum)
        local suffix_width = vim.fn.strdisplaywidth(suffix)
        local target_width = width - suffix_width
        local cur_width = 0
        for _, chunk in ipairs(virt_text) do
          local chunk_text = chunk[1]
          local chunk_width = vim.fn.strdisplaywidth(chunk_text)
          if target_width > cur_width + chunk_width then
            table.insert(result, chunk)
          else
            chunk_text = truncate(chunk_text, target_width - cur_width)
            local hl_group = chunk[2]
            table.insert(result, { chunk_text, hl_group })
            chunk_width = vim.fn.strdisplaywidth(chunk_text)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if cur_width + chunk_width < target_width then
              suffix = suffix .. (' '):rep(target_width - cur_width - chunk_width)
            end
            break
          end
          cur_width = cur_width + chunk_width
        end
        local line_nums = (" ← %d → "):format(end_lnum - lnum)
        table.insert(result, { line_nums, "NonText" })
        table.insert(result, { suffix, "TSPunctBracket" })
        return result
      end

      return {
        provider_selector = function(_, ft, _)
          local lsp_ft = {}
          if vim.tbl_contains(lsp_ft, ft) then
            return { "lsp", "indent" }
          end
          return { "treesitter", "indent" }
        end,
        open_fold_hl_timeout = 150,
        fold_virt_text_handler = fold_virt_text_line_nums,
      }
    end
  },
}
