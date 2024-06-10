return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  config = function()
    -- Add missing filetypes
    local ft = require "Comment.ft"
    ft.kdl = { "//%s", "/*%s*/" }

    require("Comment").setup()
  end,
}
