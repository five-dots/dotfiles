return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      separator_style = "slant",
      show_buffer_close_icons = false,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
  end
}