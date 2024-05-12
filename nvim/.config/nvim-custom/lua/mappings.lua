local map = vim.keymap.set

-- Leader key
map("", "<space>", "<nop>")

--[[
  Ex Command
]]
map("n", "z;", "<cmd>write<cr>")
map("n", "<esc>", "<cmd>nohlsearch<cr>")
map({ "n", "i" }, "<c-s>", "<cmd>write<cr>")

--[[
  Motion
]]
map("n", "j", "gj")
map("n", "gj", "j")
map("n", "k", "gk")
map("n", "gk", "k")

map("n", "<home>", "^")
map("n", "<pageup>", "{")
map("n", "<pagedown>", "}")

-- Window
map("n", "<left>",  "<cmd>wincmd h<cr>")
map("n", "<down>",  "<cmd>wincmd j<cr>")
map("n", "<up>",    "<cmd>wincmd k<cr>")
map("n", "<right>", "<cmd>wincmd l<cr>")

--[[
  Leader
]]
map("n", "<leader>w", "<c-w>", { desc = "window" })

