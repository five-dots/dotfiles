
" Leader key
"let mapleader = "\<Space>"
let mapleader = "\,"

" --- Keymap ---
" Normal Mode + Visual Mode = noremap
" Commandline Mode + Insert Mode = noremap!
" Normal Mode = nnoremap
" Visual Mode = vnoremap
" Commandline Mode = cnoremap
" Insert Mode inoremap

" Move
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <Down> gj
nnoremap <Up> gk

noremap <S-h> ^
noremap <S-l> $
noremap <S-j> }
noremap <S-k> {

nnoremap <CR> A<CR><ESC>
nnoremap <S-CR> O<ESC>D

set ignorecase
set smartcase

" Visual Studio Command Runner
" :vsc Command.Name
" nnoremap <Leader>fe :vsc View.SolutionExplorer<CR>
nnoremap gi :vsc Edit.GoToImplementation<CR>

"" R keymaps
nnoremap <Leader>= <ESC>yiwo<ESC>pa <- 
nnoremap <Leader>d <ESC>mayiwoview_data(<ESC>pmb:vsc RTools.ExecuteInInteractive<CR>`bdd`a
nnoremap <Leader>f <ESC>? <- function(<CR>0v/{<CR>%:vsc RTools.ExecuteInInteractive<CR>?}<CR>
nnoremap <Leader>r :vsc RTools.Reset<CR>
nnoremap <Leader>t <ESC>mayiwoview_types(<ESC>pmb:vsc RTools.ExecuteInInteractive<CR>`bdd`a
