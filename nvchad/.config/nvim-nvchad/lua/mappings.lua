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

del({ "n", "v" }, "<Leader>/") -- Comment toggle
del("n", "<Leader>cc") -- Blankline Jump to current context
del("n", "<Leader>ch") -- Toggle NvChaetsheet
del("n", "<Leader>cm") -- Telescope Git commits
del("n", "<Leader>fm") -- Format Files
del("n", "<Leader>fo") -- Telescope find oldfiles
del("n", "<Leader>fw") -- Telescope Live grep
del("n", "<Leader>fz") -- Telescope find in current buffer
del("n", "<Leader>gt") -- Telescope Git status
del("n", "<Leader>h")  -- New horizontal terminal
del("n", "<Leader>lf") -- Lsp floating diagnostics
del("n", "<Leader>n")  -- Toggle line number
del("n", "<Leader>pt") -- Telescope Pick hidden term
del("n", "<Leader>q")  -- Lsp diagnostic loclist
del("n", "<Leader>rn") -- Toggle relative number
del("n", "<Leader>th") -- Telescope Nvchad themes
del("n", "<Leader>v")  -- New vertical terminal

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
  "<C-p>",
  function ()
    require("nvchad.term").toggle({
      pos = "float",
      id = "float",
    })
  end,
  { desc = "Toggle float terminal" }
)
map(
  { "n", "t" },
  "<C-k>",
  function ()
    require("nvchad.term").toggle({
      pos = "sp",
      id = "horizontal",
      size = 0.4,
    })
  end,
  { desc = "Toggle horizontal terminal" }
)

--[[
  Leader
]]

-- Code
map("n", "<leader>cd", vim.diagnostic.setloclist, { desc = "[D]iagnostics" })
map("n", "<Leader>cf", function() require("conform").format { lsp_fallback = true } end, { desc = "[F]ormat files" })

-- Find
map("n", "<Leader>fa", "<Cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "[A]ll files" })
map("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "[B]uffers" })
map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "[F]iles" })
map("n", "<Leader>fg", "<Cmd>Telescope live_grep<CR>", { desc = "[G]rep" })
map("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>", { desc = "[H]elp pages" })
map("n", "<Leader>fr", "<Cmd>Telescope oldfiles<CR>", { desc = "[R]ecent files" })
map("n", "<Leader>ft", "<Cmd>Telescope terms<CR>", { desc = "[T]erminals" })
map("n", "<Leader>fT", "<Cmd>Telescope themes<CR>", { desc = "[T]hemes" })

-- Git
map("n", "<Leader>gc", "<Cmd>Telescope git_commits<CR>", { desc = "[C]ommits" })

-- Toggle
map("n", "<Leader>ti", "<Cmd>IBLToggle<CR>", { desc = "[I]ndent blank line" })
