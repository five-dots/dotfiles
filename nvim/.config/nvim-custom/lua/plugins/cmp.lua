local cmp = require "cmp"

return {
  "hrsh7th/nvim-cmp",
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  opts = function()
    local lspkind = require "lspkind"

    local border = function()
      local hl = "FloatBorder"
      return {
        { "╭", hl },
        { "─", hl },
        { "╮", hl },
        { "│", hl },
        { "╯", hl },
        { "─", hl },
        { "╰", hl },
        { "│", hl },
      }
    end

    return {
      completion = {
        completeopt = "menu,menuone,preview,noinsert,noselect",
      },
      view = {
        docs = {
          auto_open = false,
        },
      },
      window = {
        completion = { border = border() },
        documentation = { border = border() },
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = "symbol_text",
          maxwidth = 40,
          ellipsis_char = "...",
        },
      },
      mapping = {
        ["<Home>"] = cmp.mapping.abort(),
        ["<PageUp>"] = cmp.mapping.scroll_docs(-4),
        ["<PageDown>"] = cmp.mapping.scroll_docs(4),

        -- Right for cmp and copilot
        ["<Right>"] = cmp.mapping(function(fallback)
          local suggestion = require "copilot.suggestion"
          if cmp.get_active_entry() then
            cmp.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace }
          elseif suggestion.is_visible() then
            suggestion.accept()
          else
            fallback()
          end
        end, { "i", "s" }), -- i=insert, c=command, s=select

        -- Down for cmp and copilot
        ["<Down>"] = cmp.mapping(function(fallback)
          local suggestion = require "copilot.suggestion"
          if cmp.visible() then
            cmp.select_next_item()
          elseif suggestion.is_visible() then
            suggestion.next()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Up for cmp and copilot
        ["<Up>"] = cmp.mapping(function(fallback)
          local suggestion = require "copilot.suggestion"
          if cmp.visible() then
            cmp.select_prev_item()
          elseif suggestion.is_visible() then
            suggestion.prev()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Toggle completion
        ["<C-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.close()
          else
            cmp.complete()
          end
        end, { "i", "s" }),

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
        end, { "i", "s" }),
      },
      sources = {
        { name = "cmp_r" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "dictionary" },
        -- { name = "nvim_lua" },
        -- { name = "luasnip" },
      },
    }
  end,
  config = function(_, opts)
    cmp.setup(opts)
  end,
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    -- "saadparwaiz1/cmp_luasnip",
    -- "L3MON4D3/LuaSnip",
    -- "hrsh7th/cmp-nvim-lua",
    {
      "hrsh7th/cmp-cmdline",
      event = { "CmdLineEnter" },
      opts = {
        history = true,
        updateevents = "CmdlineEnter,CmdlineChanged",
      },
      config = function()
        -- Enable ":" completion
        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "path" },
            { name = "cmdline" },
          },
          matching = { disallow_symbol_nonprefix_matching = false },
        })
        -- Enable "/" and "?" completion
        cmp.setup.cmdline({ "/", "?" }, {
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
      config = function()
        local dict_dir = os.getenv "XDG_CONFIG_HOME" .. "/nvim-cmp-dict/"
        local dict = {
          ["*"] = { dict_dir .. "all" },
          ft = {
            sql = { dict_dir .. "sql" },
          },
        }
        require("cmp_dictionary").setup {
          paths = dict["*"],
        }
        -- Enable dict by filetype
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "*",
          callback = function(ev)
            local paths = dict.ft[ev.match] or {}
            vim.list_extend(paths, dict["*"])
            require("cmp_dictionary").setup {
              paths = paths,
            }
          end,
        })
      end,
    },
    -- copilot.lua
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      config = function()
        require("copilot").setup {
          suggestion = {
            auto_trigger = true,
          },
          panel = {
            enabled = false,
          },
          filetypes = {
            yaml = true,
          },
        }
      end,
    },
    -- lspkind.nvim
    {
      "onsails/lspkind.nvim",
    },
    -- cmp-r
    {
      "R-nvim/cmp-r",
    },
  },
}
