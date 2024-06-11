local map = vim.keymap.set

-- Leader key
map("", "<Space>", "<Nop>")

--[[
  Ex Command
]]
map("n", "z;", "<Cmd>write<CR>")
map("n", "<Esc>", "<Cmd>nohlsearch<CR>")

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
-- <C-S-Tab> does not work with zellij
map("n", "<A-o>", "<Cmd>bnext<CR>")
map("n", "<A-i>", "<Cmd>bprevious<CR>")

-- Fold
map("n", "zr", function()
  require("ufo").openFoldsExceptKinds()
end, { desc = "Open folds except kinds" })
map("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "Open all folds" })
-- closeFoldsWith(0) is the same behavior as closeAllFolds()
map("n", "zm", function()
  require("ufo").closeFoldsWith(0)
end, { desc = "Close folds with" })
map("n", "zM", function()
  require("ufo").closeAllFolds()
end, { desc = "Close all folds" })

--[[
  Leader
]]
map("n", "<Leader>e", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus Explorer" })
map("n", "<Leader>x", "<Cmd>BD<CR>", { desc = "Delete buffer" })

-- Code
map("n", "<Leader>cf", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format file" })

map("n", "<Leader>cd", "<Cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
map("n", "<Leader>cD", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Diagnostics (Buffer)" })

-- Find
map("n", "<Leader>fa", "<Cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "All files" })
map("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "Files" })
map("n", "<Leader>fm", "<Cmd>Telescope live_grep<CR>", { desc = "Matches by grep" })
map("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>", { desc = "Help pages" })
map("n", "<Leader>fr", "<Cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- Toggle
map("n", "<Leader>te", "<Cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
map("n", "<Leader>ti", "<Cmd>IBLToggle<CR>", { desc = "Indent blankline" })
map("n", "<Leader>tf", function()
  require("flash").toggle()
end, { desc = "Flash search" })

-- Window
map("n", "<Leader>w", "<C-w>", { desc = "Window" })
