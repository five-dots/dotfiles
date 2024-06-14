return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    -- copilot-status.nvim
    {
      "jonahgoldwastaken/copilot-status.nvim",
      dependencies = { "zbirenbaum/copilot.lua" }
    },
  },
  opts = {
    options = {
      theme = "onedark", -- default "auto"
      disabled_filetypes = {
        statusline = { "NvimTree" },
      },
      ignore_focus = {
        "NvimTree",
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = {
        "encoding",
        "fileformat",
        -- Show copilot status
        {
          function() return require("copilot_status").status_string() end,
          cnd = function() return require("copilot_status").enabled() end,
        },
        "filetype",
        -- Show LSP names
        function()
          local clients = {}
          for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
            if client.name == "copilot" then
              goto continue
            elseif client.name == "null-ls" then
              local sources = {}
              for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
                table.insert(sources, source.name)
              end
              table.insert(clients, "null-ls(" .. table.concat(sources, ", ") .. ")")
            else
              table.insert(clients, client.name)
            end
            ::continue::
          end
          -- Retrun empty string if no clients are attached
          if next(clients) == nil then
            return ""
          else
            return " " .. table.concat(clients, ", ")
          end
        end,
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    extensions = { "lazy", "toggleterm" },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
