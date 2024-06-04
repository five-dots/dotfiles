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
map("n", "<Left>",  "<Cmd>wincmd h<CR>")
map("n", "<Down>",  "<Cmd>wincmd j<CR>")
map("n", "<Up>",    "<Cmd>wincmd k<CR>")
map("n", "<Right>", "<Cmd>wincmd l<CR>")

--[[
  Leader
]]
map("n", "<Leader>e", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus Explorer" })

-- Toggle
map("n", "<Leader>te", "<Cmd>NvimTreeToggle<CR>", { desc = "Explorer" })

-- Window
map("n", "<Leader>w", "<C-w>", { desc = "Window" })
