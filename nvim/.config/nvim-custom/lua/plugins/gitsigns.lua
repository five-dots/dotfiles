return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "│" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function opts(desc)
        return { buffer = bufnr, desc = desc }
      end

      local function next_hunk()
        if vim.wo.diff then
          vim.cmd.normal { "]h", bang = true }
        else
          gs.nav_hunk "next"
        end
      end
      local function prev_hunk()
        if vim.wo.diff then
          vim.cmd.normal { "[h", bang = true }
        else
          gs.nav_hunk "prev"
        end
      end

      local map = vim.keymap.set

      map("n", "]h", next_hunk, opts "Next hunk")
      map("n", "[h", prev_hunk, opts "Previous hunk")

      map("n", "<Leader>gb", gs.blame_line, opts "Blame line")
      map("n", "<Leader>gp", gs.preview_hunk, opts "Preview hunk")
      map("n", "<Leader>gr", gs.reset_hunk, opts "Reset hunk")
      map("n", "<Leader>gs", gs.stage_hunk, opts "Stage hunk")
      map("n", "<Leader>gu", gs.undo_stage_hunk, opts "Undo stage hunk")
      map("n", "<Leader>tb", gs.toggle_current_line_blame, opts "Blame line")

      -- https://github.com/folke/which-key.nvim/discussions/564
      local wk = require "which-key"
      wk.register({
        g = { name = "Git" },
      }, {
        prefix = "<Leader>",
        buffer = bufnr,
      })
    end,
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
  end,
}
