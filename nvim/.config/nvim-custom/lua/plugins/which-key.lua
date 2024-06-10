return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup()
    -- Add groups
    require("which-key").register {
      ["<leader>"] = {
        c = { name = "Code" },
        f = { name = "Find" },
        g = { name = "Git" },
        t = { name = "Toggle" },
      },
    }
  end,
}
