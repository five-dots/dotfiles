return {
  "hiasr/vim-zellij-navigator.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "swaits/zellij-nav.nvim",
      config = function()
        require("zellij-nav").setup()
      end,
    },
  },
  config = function()
    require("vim-zellij-navigator").setup()
  end,
}
