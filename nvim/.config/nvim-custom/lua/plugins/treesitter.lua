return {
  "nvim-treesitter/nvim-treesitter",
  -- Plugin が Install or Update されるタイミングで TSUpdate する
  build = ":TSUpdate",
  dependencies = {
    -- Additional parsers
    { "nushell/tree-sitter-nu" },
  },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "css",
      "csv",
      "dockerfile",
      "go",
      "html",
      "javascript",
      "json",
      "jsonc",
      "kdl",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "r",
      "regex",
      "sql",
      "toml",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    -- Prefer git instead of curl in order to improve connectivity in some environments
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.configs").setup(opts)
  end,
}
