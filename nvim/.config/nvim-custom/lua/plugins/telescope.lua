return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local builtin = require("telescope.builtin")
    return {
      { "<leader>ff", builtin.find_files, desc = "[F]iles" },
      { "<leader>fr", builtin.oldfiles, desc = "[R]ecent files" },
      { "<leader>fb", builtin.buffers, desc = "[B]uffers" },
      { "<leader>f.", builtin.resume, desc = "[R]esume" },
      { "<leader>fh", builtin.help_tags, desc = "[H]elp" },
      { "<leader>fk", builtin.keymaps, desc = "[K]eymaps" },
      { "<leader>fg", builtin.live_grep, desc = "[G]rep" },
      { "<leader>fd", builtin.diagnostics, desc = "[D]iagnostics" },
      { "<leader>fw", builtin.grep_string, desc = "[W]ord" },
      { "<leader>fB", builtin.builtin, desc = "[B]uiltin" },
    }
  end,
}
