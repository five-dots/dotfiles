return {
  "MeanderingProgrammer/render-markdown.nvim",
  event = "VeryLazy",
  keys = {
    { "<Leader>tm", "<Cmd>RenderMarkdown toggle<CR>", desc = "Render markdown" },
  },
  opts = {
    sign = {
      enabled = false,
    },
    heading = {
      position = "inline",
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      signs = { "󰫎 " },
      -- 全て H1 と同じ色を利用する
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH1Bg",
        "RenderMarkdownH1Bg",
        "RenderMarkdownH1Bg",
        "RenderMarkdownH1Bg",
        "RenderMarkdownH1Bg",
        -- "RenderMarkdownH2Bg",
        -- "RenderMarkdownH3Bg",
        -- "RenderMarkdownH4Bg",
        -- "RenderMarkdownH5Bg",
        -- "RenderMarkdownH6Bg",
      },
    },
    indent = {
      enabled = true,
      per_level = 1,
      skip_headings = true,
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.nvim", -- if you use the mini.nvim suite
    -- "echasnovski/mini.icons", -- if you use standalone mini plugins
    -- "nvim-tree/nvim-web-devicons", -- if you prefer nvim-web-devicons
  },
}
