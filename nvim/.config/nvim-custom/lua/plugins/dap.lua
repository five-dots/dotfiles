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

    dap.adapters.bashdb = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
      name = "bashdb",
    }
    dap.configurations.sh = {
      {
        type = "bashdb",
        request = "launch",
        name = "Launch file",
        showDebugOutput = true,
        pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
        pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
        trace = true,
        file = "${file}",
        program = "${file}",
        cwd = "${workspaceFolder}",
        pathCat = "cat",
        pathBash = "/bin/bash",
        pathMkfifo = "mkfifo",
        pathPkill = "pkill",
        args = {},
        env = {},
        terminalKind = "integrated",
      }
    }
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
