return {
  "robitx/gp.nvim",
  keys = {
    { "<Leader>ac", "<Cmd>GpChatNew<CR>", desc = "ChatGPT" },
    { "<Leader>at", "<Cmd>GpChatToggle<CR>", desc = "Toggle ChatGPT" },
    { "<Leader>an", "<Cmd>GpNextAgent<CR>", desc = "Next agent" },
  },
  opts = {
    providers = {
      copilot = {
        enabled = true,
      },
    },
  },
  config = function(_, opts)
    require("gp").setup(opts)
  end,
}
