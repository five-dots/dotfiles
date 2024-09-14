require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

-- vim.g.maplocalleader = ","

-- Disable default mappings
del("n", "<C-h>") -- window left
del("n", "<C-j>") -- window down
del("n", "<C-k>") -- window up
del("n", "<C-l>") -- window right

del("n", "<Tab>") -- buffer next
del("n", "<S-Tab>") -- buffer prev
del("n", "<C-n>") -- nvimtree toggle window
del("n", "<C-s>") -- file save

del("i", "<C-h>") -- move left
del("i", "<C-j>") -- move down
del("i", "<C-k>") -- move up
del("i", "<C-l>") -- move right
del("i", "<C-b>") -- beginning of line
del("i", "<C-e>") -- end of line

del({ "n", "v" }, "<Leader>/") -- comment toggle

del("n", "<Leader>cc") -- blankline jump to current context
del("n", "<Leader>ch") -- toggle nvchaetsheet
del("n", "<Leader>cm") -- telescope git commits
del("n", "<Leader>ds") -- lsp diagnostics loclist
del("n", "<Leader>fa") -- telescope find all files
del("n", "<Leader>fb") -- telescope find buffers
del("n", "<Leader>ff") -- telescope find files
del("n", "<Leader>fh") -- telescope help page
del("n", "<Leader>fm") -- general format file
del("n", "<Leader>fo") -- telescope find oldfiles
del("n", "<Leader>fw") -- telescope live grep
del("n", "<Leader>fz") -- telescope find in current buffer
del("n", "<Leader>gt") -- telescope git status
del("n", "<Leader>h")  -- new horizontal terminal
del("n", "<Leader>ma") -- telescope find marks
del("n", "<Leader>n")  -- toggle line number
del("n", "<Leader>pt") -- telescope pick hidden term
del("n", "<Leader>rn") -- toggle relative number
del("n", "<Leader>th") -- telescope nvchad themes
del("n", "<Leader>v")  -- new vertical terminal
del("n", "<Leader>wK") -- whichkey all keymaps
del("n", "<Leader>wk") -- whichkey query lookup

del({ "n", "t" }, "<A-i>") -- toggle float terminal
del({ "n", "t" }, "<A-h>") -- toggle horizontal terminal
del({ "n", "t" }, "<A-v>") -- toggle vertical terminal

--[[
  Ex Command
]]
map("n", ";", ":")
map("n", "z;", "<Cmd>write<CR>")

-- hjkl motion
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "gj", "j")
map("n", "gk", "k")
map("n", "<Home>", "^")
map({ "n", "x" }, "<PageUp>", "{")
map({ "n", "x" }, "<PageDown>", "}")

-- Window move and resize with tmux integration
map("n", "<A-h>", function() require("tmux").move_left() end)
map("n", "<A-j>", function() require("tmux").move_bottom() end)
map("n", "<A-k>", function() require("tmux").move_top() end)
map("n", "<A-l>", function() require("tmux").move_right() end)
map("n", "<C-A-h>", function() require("tmux").resize_left() end)
map("n", "<C-A-j>", function() require("tmux").resize_bottom() end)
map("n", "<C-A-k>", function() require("tmux").resize_top() end)
map("n", "<C-A-l>", function() require("tmux").resize_right() end)

-- Bufferline
map("n", "<A-o>", "<Cmd>bnext<CR>")
map("n", "<A-i>", "<Cmd>bprevious<CR>")

--[[
  Leader
]]
map("n", "<Leader>e", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus Explorer" })

-- Find
map("n", "<Leader>fa", "<Cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "All files" })
map("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "Files" })
map("n", "<Leader>fm", "<Cmd>Telescope live_grep<CR>", { desc = "Matches by grep" })
map("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>", { desc = "Help pages" })
map("n", "<Leader>fr", "<Cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<Leader>ft", "<Cmd>Telescope terms<CR>", { desc = "Terminals" })
map("n", "<Leader>fT", "<Cmd>Telescope themes<CR>", { desc = "Themes" })

-- Git
-- map("n", "<Leader>gc", "<Cmd>Telescope git_commits<CR>", { desc = "Commits" })

-- Toggle
map("n", "<Leader>td", "<cmd>DiagnosticToggle<CR>", { desc = "Diagnostic" })
map("n", "<Leader>te", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
map("n", "<Leader>ti", "<Cmd>IBLToggle<CR>", { desc = "Indent blank line" })
map("n", "<Leader>tc", function() require("copilot.suggestion").toggle_auto_trigger() end, { desc = "Copilot auto suggestion" })
