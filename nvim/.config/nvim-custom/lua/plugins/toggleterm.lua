return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = function(_, _)
    local Terminal = require("toggleterm.terminal").Terminal

    -- Lazygit
    function ToggleTermLazygit()
      Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
      }):toggle()
    end

    return {
      { "<leader>g", "<cmd>lua ToggleTermLazygit()<cr>", desc = "Toggle Lazygit" },
    }
  end,
  opts = {
    open_mapping = [[<c-\]],
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end
}
