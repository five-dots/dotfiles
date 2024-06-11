return {
  "neovim/nvim-lspconfig",
  config = function()
    require("configs.lspconfig")
  end,
  dependencies = {
    -- mason.nvim
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
    -- mason-lspconfig.nvim
    {
      "williamboman/mason-lspconfig.nvim",
    },
    -- mason-tool-installer.nvim
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    -- telescope.nvim
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.6",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- fidget.nvim
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
    -- neodev.nvim
    {
      "folke/neodev.nvim",
      opts = {},
    },
  },
}
