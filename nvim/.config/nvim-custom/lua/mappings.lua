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

--[[
  Leader
]]
map("n", "<Leader>e", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus Explorer" })

-- Toggle
map("n", "<Leader>te", "<Cmd>NvimTreeToggle<CR>", { desc = "Explorer" })

-- Window
map("n", "<Leader>w", "<C-w>", { desc = "Window" })
