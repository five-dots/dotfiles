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

-- DeepL commands
vim.api.nvim_create_user_command("DeepLToJA", function(cx)
  local input = vim.fn.join(vim.fn.getline(cx.line1, cx.line2), "\n")
  local status, output = pcall(function()
    return vim.fn.split(vim.fn["deepl#translate"](input, "JA"), "\n")
  end)
  if not status then
    vim.notify(output, vim.log.levels.ERROR, { title = "DeepL.vim" })
  elseif cx.bang then
    vim.fn.setline(cx.line1, output)
  else
    vim.fn.append(cx.line2, output)
  end
end, { bang = true, range = true })

vim.api.nvim_create_user_command("DeepLToEN", function(cx)
  local input = vim.fn.join(vim.fn.getline(cx.line1, cx.line2), "\n")
  local status, output = pcall(function()
    return vim.fn.split(vim.fn["deepl#translate"](input, "EN"), "\n")
  end)
  if not status then
    vim.notify(output, vim.log.levels.ERROR, { title = "DeepL.vim" })
  elseif cx.bang then
    vim.fn.setline(cx.line1, output)
  else
    vim.fn.append(cx.line2, output)
  end
end, { bang = true, range = true })
