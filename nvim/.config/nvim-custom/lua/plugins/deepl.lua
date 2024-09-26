return {
  "gw31415/deepl-commands.nvim",
  dependencies = {
    "gw31415/deepl.vim",
    "gw31415/fzyselect.vim", -- Optional
  },
  config = function()
    require("deepl-commands").setup {
      selector_func = require("fzyselect").start,
    }
    vim.g.deepl_authkey = os.getenv("DEEPL_API_KEY")

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
  end,
}
