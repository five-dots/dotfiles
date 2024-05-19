require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

-- Disable default mappings
del("t", "<Esc>") -- Close terminal
del({ "n", "i" }, "<C-h>") -- Window left
del({ "n", "i" }, "<C-j>") -- Window down
del({ "n", "i" }, "<C-k>") -- Window up
del({ "n", "i" }, "<C-l>") -- Window right
del("n", "<Tab>") -- Buffer next
del("n", "<S-Tab>") -- Buffer prev
del("i", "<C-b>") -- Beginning of line
del("i", "<C-e>") -- End of line

del({ "n", "v" }, "<Leader>/")  -- Comment toggle
del("n", "<Leader>fo") -- Telescope find oldfiles
del("n", "<Leader>n")  -- Toggle line number
del("n", "<Leader>rn") -- Toggle relative number
del("n", "<Leader>h") -- New horizontal terminal
del("n", "<Leader>v") -- New vertical terminal

del({ "n", "t" }, "<A-i>") -- Toggle float terminal
del({ "n", "t" }, "<A-h>") -- Toggle horizontal terminal
del({ "n", "t" }, "<A-v>") -- Toggle vertical terminal

--[[
  Ex Command
]]
map("n", "z;", "<Cmd>write<CR>")
map({ "n", "i" }, "<C-s>", "<Cmd>write<CR>")

-- hjkl motion
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "gj", "j")
map("n", "gk", "k")
map("n", "<Home>", "^")
map({ "n", "x" }, "<PageUp>", "{")
map({ "n", "x" }, "<PageDown>", "}")

-- Window
map("n", "<Left>",  "<Cmd>wincmd h<CR>", { desc = "Switch Window left" })
map("n", "<Down>",  "<Cmd>wincmd j<CR>", { desc = "Switch Window down" })
map("n", "<Up>",    "<Cmd>wincmd k<CR>", { desc = "Switch Window up" })
map("n", "<Right>", "<Cmd>wincmd l<CR>", { desc = "Switch Window right" })

-- Tab next/prev
map("n", "<C-Tab>", function() require("nvchad.tabufline").next() end)
map("n", "<C-S-Tab>", function() require("nvchad.tabufline").prev() end)

-- Terminal
map( { "n", "t" },
  "<C-l>",
  function ()
    require("nvchad.term").toggle {
      pos = "float",
      id = "float",
    }
  end,
  { desc = "Toggle float terminal" }
)
map(
  { "n", "t" },
  "<C-k>",
  function ()
    require("nvchad.term").toggle {
      pos = "sp",
      id = "horizontal",
      size = 0.4,
    }
  end,
  { desc = "Toggle horizontal terminal" }
)

--[[
  Leader
]]

map("n", "<Leader>fr", "<Cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })

