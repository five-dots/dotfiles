
"フォント設定
set guifont=Consolas:h10:cSHIFTJIS

" メニューバーを非表示に
set guioptions-=m

"ツールバーを非表示に
set guioptions-=T

"左右のスクロールバーを非表示に
"set guioptions=r
"set guioptions=R
set guioptions-=l
set guioptions-=L

"水平スクロールバーを非表示に
set guioptions-=b

" colorscheme 設定
"colorscheme visualstudiodark
"colorscheme tender
"colorscheme molokai

" Windows サイズを保存
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
	autocmd!
	autocmd VimLeavePre * call s:save_window()
	function! s:save_window()
		let options = [
					\ 'set columns=' . &columns,
					\ 'set lines=' . &lines,
					\ 'winpos ' . getwinposx() . ' ' . getwinposy(),
					\ ]
		call writefile(options, g:save_window_file)
	endfunction
augroup END

if filereadable(g:save_window_file)
	execute 'source' g:save_window_file
endif

