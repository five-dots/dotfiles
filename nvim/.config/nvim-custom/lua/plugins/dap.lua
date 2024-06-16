return {
  "rcarriga/nvim-dap-ui",
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    -- Automatically open/close dap-ui when a debug session starts/stops
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
      vim.cmd "NvimTreeResize 50"
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
      vim.cmd "NvimTreeResize 50"
    end

    -- dap.listeners.before.event_terminated.dapui_config = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited.dapui_config = function()
    --   dapui.close()
    -- end

    dapui.setup()
  end,

  dependencies = {
    -- nvim-dap
    {
      "mfussenegger/nvim-dap",
    },
    -- nvim-nio
    {
      "nvim-neotest/nvim-nio",
    },
    -- nvim-dap-python
    {
      "mfussenegger/nvim-dap-python",
      config = function()
        require("dap-python").setup "python"
      end,
    },
  },
}
