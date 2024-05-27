return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<Leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "Diff" },
    { "<Leader>gf", "<Cmd>DiffviewFileHistory %<CR>", desc = "File history" },
  },
  opts = {
    keymaps = {
      view = {
        { "n", "<Esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close" } },
      },
      file_panel = {
        { "n", "<Esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close" } },
        ["<up>"] = false,
        ["<down>"] = false,
      },
      file_history_panel = {
        { "n", "<Esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close" } },
        ["<up>"] = false,
        ["<down>"] = false,
      },
    },
  },
}
