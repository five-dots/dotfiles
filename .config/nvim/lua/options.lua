
-- Set options

function SetOptions()--{{{
  local opts = {
    -- System
    clipboard = "unnamedplus",
    timeoutlen = 300,

    -- UI
    termguicolors = true,
    guifont = "JetBrainsMono Nerd Font:h12",

    -- Search
    hlsearch = false,

    -- Case sensitivity
    ignorecase = true,
    smartcase = true,

    -- Pop up menu height (default = 0)
    pumheight = 0,

    smartindent = true,

    splitbelow = true,
    splitright = true,

    -- list
    -- list = true,
    listchars = {
      eol      = '↲',
      space    = '⋅',
      trail    = '-',  -- 末尾のスペース
      lead     = '-',  -- 先頭のスペース
      tab      = '»-',
      extends  = '»',
      precedes = '«',
      nbsp     = '+',
    }
  }

  for opt, val in pairs(opts) do
    vim.api.nvim_set_option(opt, val)
  end
end--}}}

function SetWindowOptions(fold_method)--{{{
  local opts = {
    number = true,
    relativenumber = true,
  }

  if fold_method then
    opts.foldmethod = fold_method
  else
    -- Use tree-sitter expr as default
    opts.foldmethod = "expr"
    opts.foldexpr = "nvim_treesitter#foldexpr()"
  end

  for opt, val in pairs(opts) do
    vim.api.nvim_win_set_option(0, opt, val)
  end
 end--}}}

function SetBufferOptions(tab_width)--{{{
  local opts = {
    -- Tab settings
    tabstop = tab_width,
    shiftwidth = 0,
    expandtab = true,
  }

  for opt, val in pairs(opts) do
    vim.api.nvim_buf_set_option(0, opt, val)
  end
end
--}}}

-- Settings{{{

SetOptions()

-- General
vim.cmd("augroup general")
vim.cmd("autocmd!")
vim.cmd("autocmd FileType * lua SetOptions()")
vim.cmd("augroup END")

-- Lua
vim.cmd("augroup lua")
vim.cmd("autocmd!")
vim.cmd("autocmd FileType lua lua SetWindowOptions('marker')")
vim.cmd("autocmd FileType lua lua SetBufferOptions(2)")
vim.cmd("augroup END")

-- Vim-script
vim.cmd("augroup vim")
vim.cmd("autocmd!")
vim.cmd("autocmd FileType vim lua SetWindowOptions('marker')")
vim.cmd("autocmd FileType vim lua SetBufferOptions(2)")
vim.cmd("augroup END")

-- Python
vim.cmd("augroup python")
vim.cmd("autocmd!")
vim.cmd("autocmd FileType python lua SetWindowOptions()")
vim.cmd("autocmd FileType python lua SetBufferOptions(4)")
vim.cmd("augroup END")

-- R
vim.cmd("augroup r")
vim.cmd("autocmd!")
vim.cmd("autocmd FileType r lua SetWindowOptions()")
vim.cmd("autocmd FileType r lua SetBufferOptions(2)")
vim.cmd("augroup END")

-- JSON
vim.cmd("augroup json")
vim.cmd("autocmd!")
vim.cmd("autocmd FileType json lua SetWindowOptions()")
vim.cmd("autocmd FileType json lua SetBufferOptions(2)")
vim.cmd("augroup END")
--}}}
