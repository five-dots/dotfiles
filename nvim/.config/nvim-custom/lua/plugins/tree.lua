return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    actions = {
      open_file = {
        resize_window = false,
        -- Disabled as nvim crashes when using window_picker
        window_picker = {
          enable = false,
        },
      },
    },
    git = {
      enable = true,
      ignore = false,
    },
    view = {
      number = true,
      relativenumber = true,
      side = "right",
      width = 50,
    },
    renderer = {
      root_folder_label = false,
      highlight_git = "all",
      special_files = {},
      icons = {
        show = {
          git = false,
        },
        glyphs = {
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },
        },
      },
    },
    on_attach = function(bufnr)
      local api = require "nvim-tree.api"
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      --[[ 
        Delete default mappings
      ]]
      -- Delete s/S for leap.nvim
      vim.keymap.del("n", "s", { buffer = bufnr }) -- api.node.run.system
      vim.keymap.del("n", "S", { buffer = bufnr }) -- api.tree.search_node

      -- Delete C-v as it conflicts with Paste
      vim.keymap.del("n", "<C-v>", { buffer = bufnr }) -- api.node.open.vertical
      -- Delete C-v as it's hard to reach
      vim.keymap.del("n", "<C-x>", { buffer = bufnr }) -- api.node.open.horizontal

      --[[ 
        Reassign mappings
      ]]
      vim.keymap.set("n", "!", api.node.run.system, opts "Run System")
      vim.keymap.set("n", "<C-h>", api.node.open.horizontal, opts "Open: Horizontal Split")
      vim.keymap.set("n", "<Tab>", api.node.open.vertical, opts "Open: Vertical Split")
      vim.keymap.set("n", "<C-p>", api.node.open.preview, opts "Open Preview")
    end,
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
