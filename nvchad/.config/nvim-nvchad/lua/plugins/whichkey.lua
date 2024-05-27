return {
  "folke/which-key.nvim",
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "whichkey")
    require("which-key").setup(opts)
    -- Add groups
    require("which-key").register({
      ["<leader>"] = {
        c = { name = "Code" },
        f = { name = "Find" },
        g = { name = "Git" },
        t = { name = "Toggle" },
      },
    })
  end,
}
