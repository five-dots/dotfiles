require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

-- Disable default mappings
del("t", "<esc>")
del({ "n", "i" }, "<c-h>")
del({ "n", "i" }, "<c-j>")
del({ "n", "i" }, "<c-k>")
del({ "n", "i" }, "<c-l>")
del("n", "<tab>")
del("n", "<s-tab>")
del("i", "<c-b>")
del("i", "<c-e>")

del("n", "<leader>fo")

-- add yours here
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "gj", "j")
map("n", "gk", "k")
map("n", "<pageup>", "{")
map("n", "<pagedown>", "}")
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<left>",  "<c-w>h", { desc = "Switch Window left" })
map("n", "<down>",  "<c-w>j", { desc = "Switch Window down" })
map("n", "<up>",    "<c-w>k", { desc = "Switch Window up" })
map("n", "<right>", "<c-w>l", { desc = "Switch Window right" })

-- Tab next/prev
map("n", "<c-tab>", function() require("nvchad.tabufline").next() end)
map("n", "<c-s-tab>", function() require("nvchad.tabufline").prev() end)

map(
  { "n", "t" },
  "<a-g>",
  function ()
    require("nvchad.term").toggle {
      pos = "float",
      id = "lazygit_float",
      cmd = "lazygit",
    }
  end,
  { desc = "Toggle Lazygit" }
)

-- 
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Telescope Find oldfiles" })

