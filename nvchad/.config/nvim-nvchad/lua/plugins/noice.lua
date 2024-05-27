return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    -- cmdline = { enabled = false },
    messages = { enabled = false },
    notify = { enabled = false },
    popupmenu = { enabled = false },
    lsp = {
      progress = { enabled = false },
      message = { enabled = false },
      hover = { enabled = false },
      signature = { enabled = false },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
