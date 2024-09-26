return {
  -- conform.nvim
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    opts = require "configs.gitsigns",
  },
  -- nvim-tree.lua
  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.nvimtree",
  },
  -- nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },
  -- indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = require "configs.indent-blankline",
  },
}
