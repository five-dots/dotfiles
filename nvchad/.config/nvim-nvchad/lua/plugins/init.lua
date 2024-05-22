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
        "typescript-language-server",
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
        "javascript",
        "markdown",
        "python",
        "r",
        "sql",
        "typescript",
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
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        --[[ デフォルトの mapping を削除 ]]
        -- leap.nvim が使えるように s/S を削除する
        vim.keymap.del("n", "s", { buffer = bufnr }) -- api.node.run.system
        vim.keymap.del("n", "S", { buffer = bufnr }) -- api.tree.search_node
        -- Ctrl-V は Paste が動いてしまうため削除
        vim.keymap.del("n", "<C-v>", { buffer = bufnr }) -- api.node.open.vertical
        -- Ctrl-X は押しにくいため削除
        vim.keymap.del("n", "<C-x>", { buffer = bufnr }) -- api.node.open.horizontal

        --[[ 再割り当てする  ]]
        -- Run sysmtem は ! に割り当て
        vim.keymap.set('n', '!', api.node.run.system, opts('Run System'))
        -- 分割して開く系や Preview をより使いやすいキーに mapping
        vim.keymap.set('n', '<C-h>', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', '<Tab>', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', '<C-p>', api.node.open.preview, opts('Open Preview'))
      end,
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
      update_focused_file = {
        enable = false,
      },
    },
  },

  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdLineEnter" },
    opts = {
      completion = {
        completeopt = "menu,menuone,preview,noinsert,noselect",
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
        ["<Home>"] = cmp.mapping.abort(),
        ["<PageUp>"] = cmp.mapping.scroll_docs(-4),
        ["<PageDown>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        -- Preset された CR の挙動をリセットする
        ["<CR>"] = cmp.mapping(function(fallback) fallback() end),

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
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "dictionary" },
        { name = "copilot" },
      },
    },

    dependencies = {
      -- cmp-cmdline
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
      -- cmp-dictionary
      {
        "uga-rosa/cmp-dictionary",
        opts = {
          paths = { os.getenv("HOME") .. "/.nvim-cmp-dict" },
        },
      },
      -- copilot-cmp
      {
        "zbirenbaum/copilot-cmp",
        config = function ()
          require("copilot_cmp").setup()
        end,
        dependencies = {
          -- copiot.lua
          {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter",
            config = function()
              require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
              })
            end,
          },
        },
      },
    },
  },

  -- which-key.nvim
  {
    "folke/which-key.nvim",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
      -- Add groups
			require("which-key").register({
				["<leader>"] = {
					c = { name = "+[C]ode" },
					f = { name = "+[F]ind" },
					g = { name = "+[G]it" },
					t = { name = "+[T]oggle" },
				},
			})
    end,
  },

  -- gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
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

  -- leap.nvim
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", "<Plug>(leap-forward)" , desc = "Leap forward", mode = { "n", "x", "o" } },
      -- Visual mode (x) の S は、nvim-surround で使うので割り当てない
      { "S", "<Plug>(leap-backward)" , desc = "Leap backward", mode = { "n","o" } },
      { "gs", "<Plug>(leap-from-window)" , desc = "Leap from window", mode = { "n", "x", "o" } },
    },
  },

  -- gp.nvim
  {
    "robitx/gp.nvim",
    event = "VeryLazy",
    config = function()
      require("gp").setup()
    end,
  },

  -- diffview.nvim
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = {
      keymaps = {
        view = {
          { "n", "<Esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close" } },
        },
        file_panel = {
          { "n", "<Esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close" } },
          ["<up>"] = false,
          ["<down>"] = false,
        },
        file_history_panel = {
          { "n", "<Esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close" } },
          ["<up>"] = false,
          ["<down>"] = false,
        },
      },
    },
  },
}
