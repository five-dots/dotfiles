require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

-- Disable default mappings
del("t", "<ESC>")
del({ "n", "i" }, "<C-h>")
del({ "n", "i" }, "<C-j>")
del({ "n", "i" }, "<C-k>")
del({ "n", "i" }, "<C-l>")
del("i", "<C-b>")
del("i", "<C-e>")

-- add yours here
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<Left>",  "<C-w>h", { desc = "Switch Window left" })
map("n", "<Down>",  "<C-w>j", { desc = "Switch Window down" })
map("n", "<Up>",    "<C-w>k", { desc = "Switch Window up" })
map("n", "<Right>", "<C-w>l", { desc = "Switch Window right" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map(
  { "n", "t" },
  "<A-g>",
  function ()
    require("nvchad.term").toggle {
      pos = "float",
      id = "lazygit_float",
      cmd = "lazygit",
    }
  end,
  { desc = "Toggle Lazygit" }
)

