-- https://github.com/kevinhwang91/nvim-ufo?tab=readme-ov-file#customize-fold-text
local function fold_virt_text_line_nums(virtText, lnum, endLnum, width, truncate)
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
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

-- https://github.com/kevinhwang91/nvim-ufo/issues/26
local function fold_virt_text_line_nums_bottom_line(virt_text, lnum, end_lnum, width, truncate)
  local result = {}
  local _end = end_lnum - 1
  local final_text = vim.trim(vim.api.nvim_buf_get_text(0, _end, 0, _end, -1, {})[1])
  local suffix = final_text:format(end_lnum - lnum)
  local suffix_width = vim.fn.strdisplaywidth(suffix)
  local target_width = width - suffix_width
  local cur_width = 0
  for _, chunk in ipairs(virt_text) do
    local chunk_text = chunk[1]
    local chunk_width = vim.fn.strdisplaywidth(chunk_text)
    if target_width > cur_width + chunk_width then
      table.insert(result, chunk)
    else
      chunk_text = truncate(chunk_text, target_width - cur_width)
      local hl_group = chunk[2]
      table.insert(result, { chunk_text, hl_group })
      chunk_width = vim.fn.strdisplaywidth(chunk_text)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if cur_width + chunk_width < target_width then
        suffix = suffix .. (" "):rep(target_width - cur_width - chunk_width)
      end
      break
    end
    cur_width = cur_width + chunk_width
  end
  local line_nums = (" ← %d → "):format(end_lnum - lnum)
  table.insert(result, { line_nums, "NonText" })
  table.insert(result, { suffix, "TSPunctBracket" })
  return result
end

return {
  "kevinhwang91/nvim-ufo",
  event = "VeryLazy",
  keys = {
    { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },
    { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
    -- closeFoldsWith(0) is the same behavior as closeAllFolds()
    { "zm", function() require("ufo").closeFoldsWith(0) end, desc = "Close folds with" },
    { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
  },
  dependencies = {
    "kevinhwang91/promise-async",
  },
  init = function()
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
  end,
  opts = {
    provider_selector = function(_, _, _)
      return { "treesitter", "indent" }
    end,
    open_fold_hl_timeout = 150,
    fold_virt_text_handler = fold_virt_text_line_nums,
  },
}
