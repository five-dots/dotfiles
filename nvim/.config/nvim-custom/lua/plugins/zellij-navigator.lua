return {
  "hiasr/vim-zellij-navigator.nvim",
  enabled = false,
  event = "VeryLazy",
  dependencies = {
    {
      "swaits/zellij-nav.nvim",
      config = function()
        require("zellij-nav").setup()
      end,
    },
    {
      "dynamotn/Navigator.nvim",
      config = function()
        require("Navigator").setup()
      end,
    },
  },
  config = function()
    require("vim-zellij-navigator").setup()
  end,
}
