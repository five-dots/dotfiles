return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup()
    -- Add groups
    require("which-key").register {
      ["<Leader>"] = {
        a = { name = "AI" },
        c = { name = "Code" },
        d = { name = "Debug" },
        f = { name = "Find" },
        g = { name = "Git" },
        t = { name = "Toggle" },
      },
    }
  end,
}
