return {
  "hrsh7th/nvim-cmp",
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    -- "L3MON4D3/LuaSnip",
    -- "hrsh7th/cmp-nvim-lua",
    -- "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require "cmp"
    cmp.setup {
      mapping = {
        ["<up>"] = cmp.mapping.select_prev_item(),
        ["<down>"] = cmp.mapping.select_next_item(),
        ["<c-s-tab>"] = cmp.mapping.complete(),
        ["<home>"] = cmp.mapping.abort(),
        ["<pageup>"] = cmp.mapping.scroll_docs(-4),
        ["<pagedown>"] = cmp.mapping.scroll_docs(4),

        -- Toggle docs
        ["<insert>"] = cmp.mapping(
          function(fallback)
            if not cmp.visible() then
              fallback()
            end
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end,
          -- i=insert, c=command, s=select
          { "i", "s" }
        ),
      },
      sources = {
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "path" },
        -- { name = "luasnip" },
        -- { name = "nvim_lua" },
      },
    }

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}
