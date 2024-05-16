require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

-- Disable default mappings
del("t", "<esc>") -- Close terminal
del({ "n", "i" }, "<c-h>") -- Window left
del({ "n", "i" }, "<c-j>") -- Window down
del({ "n", "i" }, "<c-k>") -- Window up
del({ "n", "i" }, "<c-l>") -- Window right
del("n", "<tab>") -- Buffer next
del("n", "<s-tab>") -- Buffer prev
del("i", "<c-b>") -- Beginning of line
del("i", "<c-e>") -- End of line

del({ "n", "v" }, "<leader>/")  -- Comment toggle
del("n", "<leader>fo") -- Telescope find oldfiles
del("n", "<leader>n")  -- Toggle line number
del("n", "<leader>rn") -- Toggle relative number
del("n", "<leader>h") -- New horizontal terminal
del("n", "<leader>v") -- New vertical terminal

del({ "n", "t" }, "<a-i>") -- Toggle float terminal
del({ "n", "t" }, "<a-h>") -- Toggle horizontal terminal
del({ "n", "t" }, "<a-v>") -- Toggle vertical terminal

--[[
  Ex Command
]]
map("n", "z;", "<cmd>write<cr>")
map({ "n", "i" }, "<c-s>", "<cmd>write<cr>")

-- hjkl motion
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "gj", "j")
map("n", "gk", "k")
map("n", "<home>", "^")
map({ "n", "x" }, "<pageup>", "{")
map({ "n", "x" }, "<pagedown>", "}")

-- Window
map("n", "<left>",  "<cmd>wincmd h<cr>", { desc = "Switch Window left" })
map("n", "<down>",  "<cmd>wincmd j<cr>", { desc = "Switch Window down" })
map("n", "<up>",    "<cmd>wincmd k<cr>", { desc = "Switch Window up" })
map("n", "<right>", "<cmd>wincmd l<cr>", { desc = "Switch Window right" })

-- Tab next/prev
map("n", "<c-tab>", function() require("nvchad.tabufline").next() end)
map("n", "<c-s-tab>", function() require("nvchad.tabufline").prev() end)

-- Terminal
map( { "n", "t" },
  "<c-l>",
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
  "<c-k>",
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

map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Telescope Find oldfiles" })

