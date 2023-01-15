-- This file can be loaded by calling `require("plugins")` from your init.lua

local use = require("packer").use

return require("packer").startup(function()
  use "wbthomason/packer.nvim"

  -- -- LSP
  -- use "neovim/nvim-lspconfig"
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

  -- -- Fuzzy finder
  -- use {
  --   "nvim-telescope/telescope.nvim",
  --   requires = {"nvim-lua/plenary.nvim"},
  --   -- TODO native fzf
  -- }

  -- -- Completion
  -- use "L3MON4D3/LuaSnip"

  -- -- Completion - nvim-cmp and sources
  -- use "hrsh7th/nvim-cmp"
  -- use "hrsh7th/cmp-buffer"
  -- use "hrsh7th/cmp-emoji"
  -- use "hrsh7th/cmp-path"
  -- use "hrsh7th/cmp-nvim-lsp"
  -- use "ray-x/cmp-treesitter"
  -- use "saadparwaiz1/cmp_luasnip"
  -- use "onsails/lspkind-nvim"

  -- -- Japanese
  -- use "tyru/eskk.vim"

  -- -- Lua development
  -- use "rafcamlet/nvim-luapad"

  -- Text objects
  use "justinmk/vim-sneak"
  use "tpope/vim-surround"
  use "terrortylor/nvim-comment"
  -- use "windwp/nvim-autopairs"
  -- use {
  --   "AckslD/nvim-revJ.lua",
  --   requires = {"wellle/targets.vim"},
  -- }

  -- -- UI
  -- use "nvim-treesitter/nvim-treesitter"
  -- use "glepnir/dashboard-nvim"
  -- use "kyazdani42/nvim-web-devicons"
  -- use "karb94/neoscroll.nvim"
  -- use "norcalli/nvim-colorizer.lua"
  -- use "folke/which-key.nvim"
  -- -- use "yamatsum/nvim-cursorline"
  -- -- use "lukas-reineke/indent-blankline.nvim"

  -- -- UI - lualine.nvim
  -- use {
  --   "hoob3rt/lualine.nvim",
  --   requires = {"kyazdani42/nvim-web-devicons", opt = true}
  -- }
  -- use "arkav/lualine-lsp-progress"

  -- -- UI - colorscheme
  -- use "olimorris/onedarkpro.nvim"
  -- use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}

  -- Misc
  use {
    "glacambre/firenvim",
    run = function() vim.fn['firenvim#install'](0) end 
  }

end)
