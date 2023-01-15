-- Options
do
    -- System
    vim.opt.clipboard:append("unnamedplus")

    -- Search
    vim.opt.hlsearch = false
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
end

-- Clipboard by win32yank
-- https://stackoverflow.com/questions/68435130/wsl-clipboard-win32yank-in-init-lua
if vim.fn.has("wsl") then
    vim.g.clipboard = {
        name = "win32yank-wsl",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf"
        },
        paste = {
            ["+"] = "win32yank.exe -o --crlf",
            ["*"] = "win32yank.exe -o --crlf"
        },
        cache_enable = 0,
    }
end

-- require("options")
-- require("plugins")

local use = require("packer").use

require("packer").startup(function()
  use "wbthomason/packer.nvim"

  --- LSP ---
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }
  -- use "neovim/nvim-lspconfig"


  --- Fuzzy finder ---

  -- use {
  --   "nvim-telescope/telescope.nvim",
  --   requires = {"nvim-lua/plenary.nvim"},
  --   -- TODO native fzf
  -- }


  --- Completion ---

  -- use "L3MON4D3/LuaSnip"

  -- Completion - nvim-cmp and sources
  -- use "hrsh7th/nvim-cmp"
  -- use "hrsh7th/cmp-buffer"
  -- use "hrsh7th/cmp-emoji"
  -- use "hrsh7th/cmp-path"
  -- use "hrsh7th/cmp-nvim-lsp"
  -- use "ray-x/cmp-treesitter"
  -- use "saadparwaiz1/cmp_luasnip"
  -- use "onsails/lspkind-nvim"


  --- Japanese ---

  -- use "tyru/eskk.vim"


  -- Lua development --

  -- use "rafcamlet/nvim-luapad"


  -- Text objects --
  use "justinmk/vim-sneak"
  use "tpope/vim-surround"
  use "terrortylor/nvim-comment"
  -- use "windwp/nvim-autopairs"
  -- use {
  --   "AckslD/nvim-revJ.lua",
  --   requires = {"wellle/targets.vim"},
  -- }

  --- UI ---
  -- use "nvim-treesitter/nvim-treesitter"
  -- use "glepnir/dashboard-nvim"
  -- use "kyazdani42/nvim-web-devicons"
  -- use "karb94/neoscroll.nvim"
  -- use "norcalli/nvim-colorizer.lua"
  -- use "folke/which-key.nvim"
  -- use "yamatsum/nvim-cursorline"
  -- use "lukas-reineke/indent-blankline.nvim"

  -- UI - lualine.nvim
  -- use {
  --   "hoob3rt/lualine.nvim",
  --   requires = {"kyazdani42/nvim-web-devicons", opt = true}
  -- }
  -- use "arkav/lualine-lsp-progress"

  -- UI - colorscheme
  -- use "olimorris/onedarkpro.nvim"
  -- use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}

  --- Misc ---
  use {
    "glacambre/firenvim",
    run = function() vim.fn['firenvim#install'](0) end
  }

end)

-- require("lsp")
-- require("status_line")
require("keybindings")
-- require("ui")
-- require("neovide")
-- require("indent")

-- Text objects --

if not vim.g.vscode then
    require("nvim_comment").setup()
end

-- TODO setup
-- require("revj").setup({})

-- Lua development --

-- require("luapad").setup({})
