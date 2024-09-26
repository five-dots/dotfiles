return {
  "zk-org/zk-nvim",
  event = "VeryLazy",
  opts = {
    picker = "telescope",
    lsp = {
      config = {
        on_attach = function(_, bufnr)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gr", require("telescope.builtin").lsp_references, "Go to references")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
        end,
      },
    },
  },
  config = function(_, opts)
    require("zk").setup(opts)
  end,
}
