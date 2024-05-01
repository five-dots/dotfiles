require("options")
require("mappings")
require("autocmds")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.comment"),
  require("plugins.guess-indent"),
  require("plugins.indent-blankline"),
  require("plugins.lualine"),
  require("plugins.noice"),
  require("plugins.nvim-autopairs"),
  require("plugins.nvim-cmp"),
  require("plugins.nvim-lspconfig"),
  require("plugins.nvim-surround"),
  require("plugins.nvim-tree"),
  require("plugins.nvim-treesitter"),
  require("plugins.nvim-ufo"),
  require("plugins.onedark"),
  require("plugins.telescope"),
  require("plugins.toggleterm"),
  require("plugins.vimdoc-ja"),
  require("plugins.which-key"),
})
