return {
  "kevinhwang91/nvim-ufo",
  lazy = false,
  dependencies = {
    "kevinhwang91/promise-async"
  },
  init = function ()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
  keys = {
    { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },
    { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
    -- closeFoldsWith(0) と closeAllFolds() は同じ挙動
    { "zm", function() require("ufo").closeFoldsWith(0) end, desc = "Close folds with" },
    { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
  },
  opts = {
    provider_selector = function(_, _, _)
      return { "treesitter", "indent" }
    end,
    open_fold_hl_timeout = 150,

    -- fold 内の行数を表示
    -- https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#customize-fold-text
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" ↙ %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, {chunkText, hlGroup})
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, {suffix, "MoreMsg"})
      return newVirtText
    end,
  },
}
