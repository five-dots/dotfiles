-- Toggle diagnostic
vim.api.nvim_create_user_command("DiagnosticToggle", function()
  local config = vim.diagnostic.config
  local vt = config().virtual_text
  config {
    virtual_text = not vt,
    underline = not vt,
    signs = not vt,
  }
end, { desc = "Toggle diagnostic" })

-- bqls commands
vim.api.nvim_create_user_command("BQUpdateCache", function()
  vim.lsp.buf_request(0, "bq/updateCache", nil, function() end)
end, { desc = "Update BQ Cache" })

vim.api.nvim_create_user_command("BQClearCache", function()
  vim.lsp.buf_request(0, "bq/clearCache", nil, function() end)
end, { desc = "Clear BQ Cache" })

vim.api.nvim_create_user_command("BQDryRun", function()
  vim.lsp.buf_request(0, "bq/dryRun", { uri = "file://" .. vim.fn.expand "%:p" }, function() end)
end, { desc = "Dry run BQ" })

