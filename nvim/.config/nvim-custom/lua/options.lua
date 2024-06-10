local opt = vim.opt
local g = vim.g

--[[ 
  leader/localleader key の設定
  - leader, localleader 共にデフォルトでは設定されていないが、leader が空の場合は`\` がデフォルトで使われる
  - plugin のロード前に設定すること 
]]
g.mapleader = " "
g.maplocalleader = ","

--[[
  Remote plugin 関連の機能
  - 各言語で必要なパッケージ
    - python: `pynvim` pip パッケージをインストール
    - node: `neovim` npm パッケージをインストール
    - perl: `Neovim::Ext` cpan パッケージをインストール
    - ruby: `neovim` gem パッケージをインストール
  - `:checkhealth` で設定が問題ないか確認
--]]

-- Remote plugin 用の Provider の無効化
g["loaded_node_provider"] = 0
g["loaded_python3_provider"] = 0
g["loaded_perl_provider"] = 0
g["loaded_ruby_provider"] = 0

--[[
  Option の設定
  - `:h option-list`
--]]

--[[
  number
  - Default: nonumber, norelativenumber
  - 行番号の表示

  relativenumber
  - Default: norelativenumber
  - 相対行で表示

  numberwidth
  - Default: 4
  - 行番号表示の最小桁数
]]
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

--[[
  mouse
  - Default: nvi
  - Mouse をどのモードで有効化するかを指定する
    - n: Normal mode
    - v: Visual mode
    - i: Insert mode
    - c: Command-line mode
    - h: all previous modes when editing a help file
    - a: all previous modes
    - r: for |hit-enter| and |more-prompt| prompt
  - Double-click: 単語選択, Triple-click: 行選択, Quadruple-click: 矩形選択
]]
opt.mouse = "a"
opt.mousemoveevent = true

--[[
  showmode
  - Default: showmode
  - Statusline でモードを表示している場合は false にする
]]
-- opt.showmode = false

--[[
  clipboard
  - Default: ""
  - Neovim とOS の Clipboard を連携させる設定
  - `:h clipboard`
]]
opt.clipboard = "unnamedplus"

--[[
  breakindent
  - Default: nobreakindent
  - 長い行の折り返しがある場合、折り返された行にもインデントを反映する設定
]]
opt.breakindent = true

--[[
  undofile
  - Default: noundofile
  - バッファに書き込む際に履歴を undofile に記録する設定
  - nvim を終了しても undo の履歴を遡ることができる

  undodir
  - Default: $XDG_STATE_HOME/nvim/undo (~/.local/state/nvim/undo)
  - undofile 保存場所は undodir で指定
--]]
opt.undofile = true

--[[
  ignorecase
  - Default: ignorecase
  - 検索時に大文字・小文字を区別しない
  - 先頭に \c, \C をつけることで、アドホックに設定を変更することもできる
    - \c: ignorecase  で検索
    - \C: noignorecase で検索

  smartcase
  - Default: nosmartcase
  - ignorecase が設定されていて、かつ検索文字列に大文字が含まれる場合は ignorecase を無視する
--]]
opt.ignorecase = true
opt.smartcase = true

--[[
  signcolumn
  - Default: "auto"
  - signcolumn はデバッガのブレークポイントなどエディタの左端の sign を表示する場所のこと
  - "auto" は表示すべき sign がある場合のみ表示
  - "yes" は常に表示
  - "yes:2" のようにして signcolumn の幅を増やすことも可能
--]]
opt.signcolumn = "yes"

--[[
  updatetime
  - Default: 4000 (in ms)

  timeoutlen
  - Default: 1000 (in ms)
  - キーのシーケンスを待つ時間
  - which-key.nvim の表示を早くしたい場合は短く設定する
]]
opt.updatetime = 250
opt.timeoutlen = 300

--[[
  splitright
  - Default: nosplitright
  - `:vsplit` した際に現在の Window の右側に分割する

  splitbelow
  - Default: nosplitbelow
  - `:split` した際に現在の Window の下側に分割する
]]
opt.splitright = true
opt.splitbelow = true

--[[
  list
  -- Default: nolist
  -- 特殊文字を表示するか

  listchars
  - Default: "tab:> ,trail:-,nbsp:+"
]]
opt.list = true
opt.listchars = {
  tab = "» ",
  -- lead = "·",
  -- trail = "·",
  -- eol = "↲",
  nbsp = "␣", -- non-breakable space (Ctrl-v x a 0 で入力できる)
  extends = "»", -- nowrap の折り返し末尾
  precedes = "«", -- nowrap の折り返し先頭
}

--[[
  inccommand
  - Default: "nosplit"
  - 文字列の置換の際などに、incremental にプレビューを表示してくれる
  - "split" に設定すると、別バッファにプレビューを表示してくれる
]]
-- opt.inccommand = "split"

--[[
  cursorline
  - Default: nocursorline
  - 自分のいる行をハイライトする

  cursorlineopt
  - Default: "both"
  - ハイライト方法の指定
    - "line": 行全体
    - "number": 行番号のみ
    - "both": "line" + "number"
    - "screenline"
]]
opt.cursorline = true
opt.cursorlineopt = "number"

--[[
  scrolloff
  - Default: 0
  - スクロールする際に上下に何行残すか
]]
opt.scrolloff = 10

--[[
  インデント関連設定
  - 全てスペースで扱う場合は expandtab にして、tabstop の値のみを設定すればよい

  expandtab
  - Default: noexpandtab
  - タブの代わりにスペースを挿入する

  tabstop
  - Default: 8
  - スペース何個分でひとつのタブとしてカウントするか

  softtabstop
  - Default: 0 (0 の場合はこの機能が Off になる)
  - tab で何個分のスペースを挿入するか
  - 挿入されたスペースの数が tabstop に到達するとタブに変換される (expandtab off の時)

  shiftwidth
  - Default: 0 (0 の時は、tabstop の値が利用される)
  - インデントの際に、何個分のスペースを挿入するか
  - 改行や、 <<, >> の際に利用される
  - 挿入されたスペースの数が tabstop に到達するとタブに変換される (expandtab off の時)

  smartindent
  - Default: nosmartindent
]]

-- guess-indent.nvim を利用して自動設定するので、ここでは設定しない
-- opt.expandtab = true
-- opt.tabstop = 2
-- opt.shiftwidth = 4
-- opt.smartindent = true

--[[
  foldmethod
  - Default: manual

  foldexpr
  - Default: 0
  - foldmethod=expr のときに使われる

  foldtext
  - Default: foldtext()
  - 折りたたみの表示方法

  foldenable
  - Default: foldenable
  - バッファを開いたときに Fold された状態にするか
  - `zi` で Toggle できる

  foldcolumn
  - Default: 0 (0 は foldcolumn が無効になる)
  - バッファの左側にfold の存在を示す+ を表示する
  - 1 に設定すると固定長[1] の表示領域が確保される
  - auto:1 にすると fold が存在するときのみ表示領域が出現する

  foldlevel
  - Default: 0
]]

-- nvim-ufo を利用するので、ここでは設定しない
-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- opt.foldtext = "v:lua.vim.treesitter.foldtext()"
-- opt.foldenable = false
-- opt.foldcolumn = "1"

