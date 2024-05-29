return {
  enabled = false,
  "Olical/conjure",
  ft = { "lua", "python" },
  init = function()
    vim.g["conjure#extract#tree_sitter#enabled"] = true
  end,
}
