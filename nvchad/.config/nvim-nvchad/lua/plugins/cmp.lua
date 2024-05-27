local cmp = require "cmp"

return {
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
      ["<Home>"] = cmp.mapping.abort(),
      ["<PageUp>"] = cmp.mapping.scroll_docs(-4),
      ["<PageDown>"] = cmp.mapping.scroll_docs(4),

      -- cmp とcopilot の両方に対応した Tab を定義する
      ["<Tab>"] = cmp.mapping(function(fallback)
        local suggestion = require "copilot.suggestion"
        if cmp.get_active_entry() then
          cmp.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace }
        elseif suggestion.is_visible() then
          suggestion.accept()
        else
          fallback()
        end
      end, { "i", "s" }), -- i=insert, c=command, s=select

      -- cmp とcopilot の両方に対応した Down を定義する
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

      -- cmp とcopilot の両方に対応した Up を定義する
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

      -- Preset された CR の挙動をリセットする
      ["<CR>"] = cmp.mapping(function(fallback)
        fallback()
      end),

      -- Toggle completion
      ["<C-S-Tab>"] = cmp.mapping(function()
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
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "dictionary" },
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
            { name = "path" },
          }, {
            { name = "cmdline" },
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
      -- init = function ()
      --   local dict = {
      --     ["*"] = { os.getenv("XDG_CONFIG_HOME") .. "/nvim-cmp-dict/all" },
      --     ft = {
      --       sql = { os.getenv("XDG_CONFIG_HOME") .. "/nvim-cmp-dict/sql" },
      --     },
      --   }
      --   vim.api.nvim_create_autocmd("FileType", {
      --     pattern = "*",
      --     callback = function(ev)
      --       print(ev.match)
      --       local paths = dict.ft[ev.match] or {}
      --       vim.list_extend(paths, dict["*"])
      --       require("cmp_dictionary").setup({
      --         paths = paths,
      --       })
      --     end
      --   })
      -- end,
      opts = {
        paths = { os.getenv "XDG_CONFIG_HOME" .. "/nvim-cmp-dict/all" },
      },
    },
    -- copilot.lua
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      keys = {
        {
          "<Leader>tc",
          function()
            require("copilot.suggestion").toggle_auto_trigger()
          end,
          desc = "Copilot auto suggestion",
        },
      },
      config = function()
        require("copilot").setup {
          suggestion = {
            auto_trigger = true,
          },
          panel = {
            enabled = false,
          },
        }
      end,
    },
  },
}
