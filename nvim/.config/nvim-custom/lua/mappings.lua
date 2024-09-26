-- stylua: ignore start
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
map("n", "<A-h>", function() require("tmux").move_left() end)
map("n", "<A-j>", function() require("tmux").move_bottom() end)
map("n", "<A-k>", function() require("tmux").move_top() end)
map("n", "<A-l>", function() require("tmux").move_right() end)
map("n", "<C-A-h>", function() require("tmux").resize_left() end)
map("n", "<C-A-j>", function() require("tmux").resize_bottom() end)
map("n", "<C-A-k>", function() require("tmux").resize_top() end)
map("n", "<C-A-l>", function() require("tmux").resize_right() end)

-- Bufferline
-- <C-S-Tab> does not work with zellij
map("n", "<A-o>", "<Cmd>bnext<CR>")
map("n", "<A-i>", "<Cmd>bprevious<CR>")

-- Fold
map("n", "zr", function() require("ufo").openFoldsExceptKinds() end, { desc = "Open folds except kinds" })
map("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
-- closeFoldsWith(0) is the same behavior as closeAllFolds()
map("n", "zm", function() require("ufo").closeFoldsWith(0) end, { desc = "Close folds with" })
map("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })

--[[
  Leader
]]
map("n", "<Leader>e", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus Explorer" })
map("n", "<Leader>x", "<Cmd>Bdelete<CR>", { desc = "Delete buffer" })

-- AI
map("n", "<Leader>ac", "<Cmd>GpChatNew<CR>", { desc = "ChatGPT" })
map("n", "<Leader>at", "<Cmd>GpChatToggle<CR>", { desc = "Toggle ChatGPT" })
map("n", "<Leader>an", "<Cmd>GpNextAgent<CR>", { desc = "Next agent" })

-- Code
map("n", "<Leader>cf", function() require("conform").format { lsp_fallback = true } end, { desc = "Format file" })
map("n", "<Leader>cd", "<Cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
map("n", "<Leader>cD", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Diagnostics (Buffer)" })

-- Debug
map("n", "<Leader>dc", "<Cmd>DapContinue<CR>", { desc = "Continue" })
map("n", "<Leader>db", "<Cmd>DapToggleBreakpoint<CR>", { desc = "Breakpoint" })
map("n", "<Leader>dq", "<Cmd>DapTerminate<CR>", { desc = "Terminate" })
map("n", "<Leader>d.", function() require("dapui").eval() end, { desc = "Eval" })

map("n", "<Leader>di", "<Cmd>DapStepInto<CR>", { desc = "Step into" })
map("n", "<Leader>do", "<Cmd>DapStepOver<CR>", { desc = "Step over" })
map("n", "<Leader>dO", "<Cmd>DapStepOut<CR>", { desc = "Step out" })

-- Find
map("n", "<Leader>fa", "<Cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", { desc = "All files" })
map("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "Files" })
map("n", "<Leader>fm", "<Cmd>Telescope live_grep<CR>", { desc = "Matches by grep" })
map("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>", { desc = "Help pages" })
map("n", "<Leader>fr", "<Cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- Toggle
map("n", "<Leader>tc", function() require("copilot.suggestion").toggle_auto_trigger() end, { desc = "Copilot auto suggestion" })
map("n", "<Leader>td", "<cmd>DiagnosticToggle<CR>", { desc = "Diagnostic" })
map("n", "<Leader>tD", function() require("dapui").toggle() end, { desc = "Debugger UI" })
map("n", "<Leader>te", "<Cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
map("n", "<Leader>ti", "<Cmd>IBLToggle<CR>", { desc = "Indent blankline" })
map("n", "<Leader>tl", "<Cmd>set wrap!<CR>", { desc = "Line wrap" })

-- Window
map("n", "<Leader>w", "<C-w>", { desc = "Window" })

-- stylua: ignore end
