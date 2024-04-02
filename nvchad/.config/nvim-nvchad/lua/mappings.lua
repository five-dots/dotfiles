require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

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

