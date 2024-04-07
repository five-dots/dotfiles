require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

-- Disable default mappings
del("t", "<ESC>")
del({ "n", "i" }, "<C-h>")
del({ "n", "i" }, "<C-j>")
del({ "n", "i" }, "<C-k>")
del({ "n", "i" }, "<C-l>")
del("n", "<Tab>")
del("n", "<S-Tab>")
del("i", "<C-b>")
del("i", "<C-e>")

-- add yours here
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "gj", "j")
map("n", "gk", "k")
map("n", "<PageUp>", "{")
map("n", "<PageDown>", "}")
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<Left>",  "<C-w>h", { desc = "Switch Window left" })
map("n", "<Down>",  "<C-w>j", { desc = "Switch Window down" })
map("n", "<Up>",    "<C-w>k", { desc = "Switch Window up" })
map("n", "<Right>", "<C-w>l", { desc = "Switch Window right" })

-- Tab next/prev
map("n", "<C-Tab>", function() require("nvchad.tabufline").next() end)
map("n", "<C-S-Tab>", function() require("nvchad.tabufline").prev() end)

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

