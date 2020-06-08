
" Load vsvim setting for common use{{{
if filereadable(expand('~/_vsvimrc'))
	source ~/_vsvimrc
endif
"}}}

" Misc setting (autocmd etc){{{
autocmd BufNewFile,BufRead *.txt set filetype=txt
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Fold method
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType markdown setlocal foldmethod=marker
autocmd FileType txt setlocal foldmethod=marker

" PlantUML
autocmd FileType plantuml command! OpenUml :!start chrome %

" Load windows setting  (i.e Ctrl-c, Ctrl-v)
source $VIMRUNTIME/mswin.vim
"}}}

" NeoBundle Setting{{{
if has('vim_starting')
	set nocompatible
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

"NeoBundle 'Shougo/vimfiler'
"NeoBundle 'Shougo/vimproc'
"NeoBundle 'Yggdroot/indentline'				" Diplay indent
"NeoBundle 'dhruvasagar/vim-table-mode'
"NeoBundle 'glidenote/memolist.vim'
"NeoBundle 'godlygeek/tabular'
"NeoBundle 'itchyny/lightline.vim'
"NeoBundle 'jbmorgado/vim-pine-script'
"NeoBundle 'kakkyz81/evervim'
"NeoBundle 'kannokanno/previm'
"NeoBundle 'mattn/unite-source-simplenote'
"NeoBundle 'mattn/vimplenote-vim'
"NeoBundle 'mattn/webapi-vim'
"NeoBundle 'mattn/webapi-vim'
"NeoBundle 'moznion/hateblo.vim'
"NeoBundle 'mrtazz/simplenote.vim'
"NeoBundle 'nelstrom/vim-markdown-folding'
"NeoBundle 'tomasr/molokai'
"NeoBundle 'tyru/open-browser.vim'
"NeoBundle 'vim-scripts/Txtfmt-The-Vim-Highlighter'
NeoBundle 'Shougo/neobundle.vim'
"NeoBundle 'Shougo/neocomplete.vim'
"NeoBundle 'Shougo/neomru.vim' 				" Most Resetly Used
"NeoBundle 'Shougo/neosnippet'
"NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'aklt/plantuml-syntax'
"NeoBundle 'bronson/vim-trailing-whitespace' " Highlight trainling space
"NeoBundle 'cohama/lexima.vim'				" Complete brackets
"NeoBundle 'itchyny/calendar.vim'
"NeoBundle 'itchyny/lightline.vim' 			" Status line enhancement
NeoBundle 'jacoborus/tender.vim'
"NeoBundle 'jkramer/vim-checkbox'
"NeoBundle 'kana/vim-metarw'
"NeoBundle 'kana/vim-submode'
"NeoBundle 'lazywei/vim-matlab'
"NeoBundle 'plasticboy/vim-markdown'
"NeoBundle 'scrooloose/nerdtree'
"NeoBundle 'tpope/vim-fugitive' 				" git from vim
"NeoBundle 'vimwiki/vimwiki'					" vim wiki by markdown syntax

NeoBundleCheck
call neobundle#end()
filetype plugin indent on
"}}}

" Basic settings (set ..) {{{
set tabstop=4
set shiftwidth=4
set noexpandtab
" set relativenumber
set number
" set noundofile
set nobackup
set noswapfile
set imsearch=-1
set nohlsearch
set hidden
set autochdir
set nowrap
set smartcase       " Use upper case if upper case is used
set browsedir=last 	" Set file dir as current dir

" Encoding
"set encoding=cp932
"set fileencoding=cp932
"set fileencodings=ucs-boms,cp932,utf-8,euc-jp
"set fileformats=dos,unix,mac

"}}}

" Keymap Settings{{{

" Normal + Visual  	 	= noremap
" Commandline + Insert 	= noremap!
" Normal 			 	= nnoremap
" Visual  			 	= vnoremap
" Commandline  			= cnoremap
" Insert  				= inoremap

" Space as Leader
let mapleader="\<Space>"

" Keymap for Vim only (not for Visual Studio
inoremap <ESC> <ESC>:set iminsert=0<CR>

" ALT + kj: move row
" nnoremap <A-j> :m+<CR>==
" nnoremap <A-k> :m-2<CR>==
" inoremap <A-j> <Esc>:m+<CR>==gi
" inoremap <A-k> <Esc>:m-2<CR>==gi
" vnoremap <A-j> :m'>+<CR>gv=gv
" vnoremap <A-k> :m-2<CR>gv=gv

" ALT + hl: move left/right in insert mode
"inoremap <A-h> <ESC>ha
"inoremap <A-l> <ESC>la

" Window/Tab related settings
" nnoremap s <Nop>
" nnoremap sj <C-w>j
" nnoremap sk <C-w>k
" nnoremap sl <C-w>l
" nnoremap sh <C-w>h
" nnoremap sJ <C-w>J
" nnoremap sK <C-w>K
" nnoremap sL <C-w>L
" nnoremap sH <C-w>H
" nnoremap sn gt
" nnoremap sp gT
" nnoremap sr <C-w>r
" nnoremap s= <C-w>=
" nnoremap sw <C-w>w
" nnoremap so <C-w>_<C-w>|
" nnoremap sN :<C-u>bn<CR>
" nnoremap sP :<C-u>bp<CR>
" nnoremap st :<C-u>tabnew<CR>
" nnoremap ss :<C-u>sp<CR>
" nnoremap ss :<C-u>new<CR>
" nnoremap sv :<C-u>vs<CR>
" nnoremap sv :<C-u>vnew<CR>
" nnoremap sq :<C-u>q<CR>
" nnoremap sQ :<C-u>bd<CR>

" Unite
"nnoremap sT :<C-u>Unite tab<CR>
"nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
"nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" vim-submode
" call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
" call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
" call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
" call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
" call submode#map('bufmove', 'n', '', '>', '<C-w>>')
" call submode#map('bufmove', 'n', '', '<', '<C-w><')
" call submode#map('bufmove', 'n', '', '+', '<C-w>+')
" call submode#map('bufmove', 'n', '', '-', '<C-w>-')
"}}}

" Custom Command{{{
command! Src source $HOME/_vimrc
command! Srcg source $HOME/_gvimrc
command! Editrc e $HOME/_vimrc
command! Editrcg e $HOME/_gvimrc
"}}}

" neocomplete, neosnippets settings{{{

" 設定は、このサイトを参考 [https://qiita.com/ahiruman5/items/4f3c845500c172a02935]

" " Vim 起動時に neocomplete を有効にする
" let g:neocomplete#enable_at_startup = 1

" " smartcase 有効化. 大文字が入力されるまで大文字小文字の区別を無視する
" let g:neocomplete#enable_smart_case = 1

" " 3 文字以上の単語に対して補完を有効にする
" let g:neocomplete#min_keyword_length = 3

" " 区切り文字まで補完する
" let g:neocomplete#enable_auto_delimiter = 1

" " 1 文字目の入力から補完のポップアップを表示
" let g:neocomplete#auto_completion_start_length = 1

" " バックスペースで補完のポップアップを閉じる
" inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

" " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
" imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"

" " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
" imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

"}}}
