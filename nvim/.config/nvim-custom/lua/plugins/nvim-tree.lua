return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = {
    "NvimTreeFocus",
    "NvimTreeToggle",
    -- "NvimTreeOpen",
    -- "NvimTreeFindFile",
    -- "NvimTreeCollapse",
  },
  keys = {
    { "<leader>te", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
    { "<leader>e", "<cmd>NvimTreeFocus<cr>", desc = "Focus nvim-tree" },
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    git = {
      enable = true,
      ignore = false,
    },
    view = {
      width = 40,
      number = true,
      relativenumber = true,
    },
    renderer = {
      root_folder_label = false,
      highlight_git = "all",
      special_files = {},
      icons = {
        show = {
          git = false,
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
