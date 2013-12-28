" AUTOCMD
if has("autocmd")
	filetype plugin indent on

	augroup vimrcEx
		au!

		" Specific parameters for some types of file
		autocmd FileType text setlocal textwidth=80 noexpandtab
		autocmd FileType lex,yacc,make,c,cpp,objc setlocal ts=8 sts=8 sw=8 noexpandtab
		autocmd FileType java setlocal ts=4 sts=4 sw=4 noexpandtab
		autocmd FileType c,cpp,java setlocal cindent cino+='(0'set foldmethod=syntax
		autocmd FileType r set commentstring=#\ %s
		autocmd FileType matlab set commentstring=%\ %s

		" Add new types of file
		autocmd BufNewFile,BufRead *.zsh-theme setfiletype zsh
		autocmd BufNewFile,BufRead BUILD setfiletype json

		" Get back to the former cursor position
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\	exe "normal! g`\"" |

		" Reload vim config files when saving them
		autocmd BufWritePost autocmd.vim,colo.vim,config.vim,functions.vim,mappings.vim,plugins.vim,text.vim,vundle.vim,vimrc,.vimrc source $MYVIMRC

		" Help mode bindings
		" C-t to go back
		" q to quit
		autocmd filetype help nnoremap <buffer><CR> <C-]>
		autocmd filetype help nnoremap <buffer>q :q<CR>
	augroup END
else
	set autoindent " Auto indent every time
endif

