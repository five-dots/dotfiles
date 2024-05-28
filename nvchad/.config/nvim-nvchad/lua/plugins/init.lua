return {
  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- mason.nvim
  {
    "williamboman/mason.nvim",
    opts = require "configs.mason",
  },

  -- nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  -- nvim-tree.lua
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.nvimtree",
  },

  -- gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    opts = require "configs.gitsigns",
  },
}
