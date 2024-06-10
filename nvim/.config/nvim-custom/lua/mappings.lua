local map = vim.keymap.set

-- Leader key
map("", "<Space>", "<Nop>")

--[[
  Ex Command
]]
map("n", "z;", "<Cmd>write<CR>")
map("n", "<Esc>", "<Cmd>nohlsearch<CR>")
map({ "n", "i" }, "<C-s>", "<Cmd>write<CR>")

--[[
  Motion
]]
map("n", "j", "gj")
map("n", "gj", "j")
map("n", "k", "gk")
map("n", "gk", "k")

map("n", "<Home>", "^")
map("n", "<PageUp>", "{")
map("n", "<PageDown>", "}")

-- Window
map("n", "<A-h>", "<Cmd>ZellijNavigateLeft<CR>")
map("n", "<A-j>", "<Cmd>ZellijNavigateDown<CR>")
map("n", "<A-k>", "<Cmd>ZellijNavigateUp<CR>")
map("n", "<A-l>", "<Cmd>ZellijNavigateRight<CR>")

-- Bufferline
map("n", "<A-o>", "<Cmd>bnext<CR>")
map("n", "<A-i>", "<Cmd>bprevious<CR>")

--[[
  Leader
]]
map("n", "<Leader>e", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus Explorer" })
map("n", "<Leader>x", "<Cmd>BD<CR>", { desc = "Delete buffer" })

-- Toggle
map("n", "<Leader>te", "<Cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
map("n", "<Leader>ti", "<Cmd>IBLToggle<CR>", { desc = "Indent blankline" })

-- Window
map("n", "<Leader>w", "<C-w>", { desc = "Window" })
