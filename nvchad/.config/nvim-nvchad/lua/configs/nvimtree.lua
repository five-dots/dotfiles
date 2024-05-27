return {
  on_attach = function(bufnr)
    local api = require "nvim-tree.api"
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- Default mappings
    api.config.mappings.default_on_attach(bufnr)

    --[[ デフォルトの mapping を削除 ]]
    -- leap.nvim が使えるように s/S を削除する
    vim.keymap.del("n", "s", { buffer = bufnr }) -- api.node.run.system
    vim.keymap.del("n", "S", { buffer = bufnr }) -- api.tree.search_node
    -- Ctrl-V は Paste が動いてしまうため削除
    vim.keymap.del("n", "<C-v>", { buffer = bufnr }) -- api.node.open.vertical
    -- Ctrl-X は押しにくいため削除
    vim.keymap.del("n", "<C-x>", { buffer = bufnr }) -- api.node.open.horizontal

    --[[ 再割り当てする  ]]
    -- Run sysmtem は ! に割り当て
    vim.keymap.set("n", "!", api.node.run.system, opts "Run System")
    -- 分割して開く系や Preview をより使いやすいキーに mapping
    vim.keymap.set("n", "<C-h>", api.node.open.horizontal, opts "Open: Horizontal Split")
    vim.keymap.set("n", "<Tab>", api.node.open.vertical, opts "Open: Vertical Split")
    vim.keymap.set("n", "<C-p>", api.node.open.preview, opts "Open Preview")
  end,
  git = {
    ignore = false,
  },
  view = {
    width = 40,
    number = true,
    relativenumber = true,
  },
  renderer = {
    special_files = {},
    icons = {
      show = {
        git = false,
      },
    },
  },
  update_focused_file = {
    enable = false,
  },
}
