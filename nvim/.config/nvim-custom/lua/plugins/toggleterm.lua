return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = function(_, _)
    local Terminal = require("toggleterm.terminal").Terminal

    -- Default terminal
    local toggleterm_default = Terminal:new({
      direction = "horizontal",
      size = 30,
      hidden = true,
    })
    function ToggleTermDefault(direction)
      toggleterm_default.direction = direction
      toggleterm_default:toggle()
    end

    -- Lazygit
    local toggleterm_lazygit_default = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true,
    })
    function ToggleTermLazygit()
      toggleterm_lazygit_default:toggle()
    end

    return {
      { "<leader>g", "<cmd>lua ToggleTermLazygit()<cr>", desc = "Toggle Lazygit" },
      -- { "<c-n>", "<cmd>lua ToggleTermDefault()<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
      { "<c-n>", function() ToggleTermDefault("float") end, desc = "Toggle terminal", mode = { "n", "t" } },
      { "<c-k>", function() ToggleTermDefault("horizontal") end, desc = "Toggle terminal", mode = { "n", "t" } },
    }
  end,
  opts = {
    open_mapping = [[<c-\]],
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end
}
