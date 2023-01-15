local f = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- Leader key
f("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Motion
f("n", "<Home>", "^", opts)

-- Move - vim-sneak
f("n", "f", "<Plug>Sneak_f", {silent = true})
f("n", "F", "<Plug>Sneak_F", {silent = true})
f("n", "t", "<Plug>Sneak_t", {silent = true})
f("n", "T", "<Plug>Sneak_T", {silent = true})

if not vim.g.vscode then
    -- Native Neovim

    -- Ex Command
    f("n", "z;", "<Cmd>write<CR>", {silent = true})

    -- Motion
    f("n", "j", "gj", opts)
    f("n", "gj", "j", opts)
    f("n", "k", "gk", opts)
    f("n", "gk", "k", opts)

    f("n", "<PageUp>", "{", opts)
    f("n", "<PageDown>", "}", opts)

    -- Leader map
    f("n", "<Leader>w", "<C-w>", opts)

    f("n", "<Left>",  "<Cmd>wincmd h<CR>", {silent = true})
    f("n", "<Down>",  "<Cmd>wincmd j<CR>", {silent = true})
    f("n", "<Up>",    "<Cmd>wincmd k<CR>", {silent = true})
    f("n", "<Right>", "<Cmd>wincmd l<CR>", {silent = true})

else
    -- VSCode Neovim
    -- ! インサートモードの設定は、keybindings.json へ記載すること
    -- ! インサートモード以外の場合でも、Ctrl Key を利用するものは、keybindings.json へ記載する

    -- Ex Command
    f("n", "z;", "<Cmd>Write<CR>", opts)

    -- Motion
    -- https://github.com/asvetliakov/vscode-neovim/issues/58
    f("n", "j", "gj", {silent = true})
    f("n", "k", "gk", {silent = true})

    -- Comment
    -- https://github.com/vscode-neovim/vscode-neovim/wiki/commentary.vim
    f("x", "gc",  "<Plug>VSCodeCommentary", {silent = true})
    f("n", "gc",  "<Plug>VSCodeCommentary", {silent = true})
    f("o", "gc",  "<Plug>VSCodeCommentary", {silent = true})
    f("n", "gcc", "<Plug>VSCodeCommentaryLine", {silent = true})

    -- Fold
    f("n", "za", "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>", opts)
    f("n", "zc", "<Cmd>call VSCodeNotify('editor.fold')<CR>", opts)
    f("n", "zC", "<Cmd>call VSCodeNotify('editor.foldRecursively')<CR>", opts)
    f("n", "zo", "<Cmd>call VSCodeNotify('editor.unfold')<CR>", opts)
    f("n", "zO", "<Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>", opts)
    f("n", "zm", "<Cmd>call VSCodeNotify('editor.foldAll')<CR>", opts)
    f("n", "zr", "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>", opts)

    -- Leader map
    -- f("n", "<Leader><Leader>", "<Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>", opts)

    -- Leader map: Project/Workspace
    f("n", "<Leader><Tab>.", ":<C-u>call VSCodeNotify('workbench.action.openRecent')<CR>", opts)

    -- Leader map: File
    f("n", "<Leader>ff", ":<C-u>call VSCodeNotify('workbench.explorer.fileView.focus')<CR>", opts)
    f("n", "<Leader>fr", ":<C-u>call VSCodeNotify('workbench.action.quickOpen')<CR>", opts)

    -- Leader map: Search
    f("n", "<Leader>sd", ":<C-u>call VSCodeNotify('workbench.action.findInFiles')<CR>", opts)

    -- Leader map: Open
    f("n", "<Leader>og", ":<C-u>call VSCodeNotify('workbench.view.scm')<CR>", opts)
    f("n", "<Leader>ox", ":<C-u>call VSCodeNotify('workbench.view.extensions')<CR>", opts)

    -- Leader map: Toggle
    f("n", "<Leader>tt", ":<C-u>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>", opts)
    f("n", "<Leader>ta", ":<C-u>call VSCodeNotify('workbench.action.toggleActivityBarVisibility')<CR>", opts)
    f("n", "<Leader>ts", ":<C-u>call VSCodeNotify('workbench.action.toggleStatusbarVisibility')<CR>", opts)
    f("n", "<Leader>tm", ":<C-u>call VSCodeNotify('workbench.action.toggleMenuBar')<CR>", opts)

    -- Leader map: Window
    f("n", "<Leader>wv", "<Cmd>call <SNR>10_split('v')<CR>", opts)
    f("n", "<Leader>ws", "<Cmd>call <SNR>10_split('h')<CR>", opts)

    f("n", "<Leader>wd", "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>", opts)
    f("n", "<Leader>wq", "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>", opts)

    f("n", "<Leader>wo", "<Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>", opts)

    f("n", "<Leader>w_", "<Cmd>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>", opts)
    f("n", "<Leader>w=", "<Cmd>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>", opts)
    f("n", "<Leader>wgd", "<Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>", opts)

    f("n", "<Leader>wN", "<Cmd>call <SNR>10_splitNew('h', '__vscode_new__')<CR>", opts)

    -- Move window focus
    f("n", "<Left>",  "<Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>", opts)
    f("n", "<Down>",  "<Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>", opts)
    f("n", "<Up>",    "<Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>", opts)
    f("n", "<Right>", "<Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>", opts)

    f("n", "<Leader>wh", "<Cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>", opts)
    f("n", "<Leader>wj", "<Cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>", opts)
    f("n", "<Leader>wk", "<Cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>", opts)
    f("n", "<Leader>wl", "<Cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>", opts)

    f("n", "<Leader>wp", "<Cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>", opts)
    f("n", "<Leader>wn", "<Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>", opts)
    f("n", "<Leader>wt", "<Cmd>call VSCodeNotify('workbench.action.focusFirstEditorGroup')<CR>", opts)
    f("n", "<Leader>wb", "<Cmd>call VSCodeNotify('workbench.action.focusLastEditorGroup')<CR>", opts)

    -- Move window position
    f("n", "<Leader>wH", "<Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>", opts)
    f("n", "<Leader>wJ", "<Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>", opts)
    f("n", "<Leader>wK", "<Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>", opts)
    f("n", "<Leader>wL", "<Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>", opts)

    -- Move window group
    f("n", "<Leader>w<C-h>", "<Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupLeft')<CR>", opts)
    f("n", "<Leader>w<C-j>", "<Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupDown')<CR>", opts)
    f("n", "<Leader>w<C-k>", "<Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupUp')<CR>", opts)
    f("n", "<Leader>w<C-l>", "<Cmd>call VSCodeNotify('workbench.action.moveActiveEditorGroupRight')<CR>", opts)

    -- Window size
    f("n", "<Leader>w<", "<Cmd>call <SNR>10_manageEditorWidth(v:count, 'decrease')<CR>", opts)
    f("n", "<Leader>w>", "<Cmd>call <SNR>10_manageEditorWidth(v:count, 'increase')<CR>", opts)
    f("n", "<Leader>w-", "<Cmd>call <SNR>10_manageEditorHeight(v:count, 'decrease')<CR>", opts)
    f("n", "<Leader>w+", "<Cmd>call <SNR>10_manageEditorHeight(v:count, 'increase')<CR>", opts)
end