" {{{1 VUNDLE
" BundleList                    - list configured bundles
" BundleInstall(!)              - install(update) bundles
" BundleSearch(!) foo           - search(or refresh cache first) for foo
" BundleClean(!)                - confirm(or auto- approve) removal of unused bundles
set nocompatible " No reason today to assure compatibility with vi
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle "gmarik/vundle"

" Github repos

" Helpers
Bundle 'bling/vim-airline'
Bundle 'kien/ctrlp.vim'
Bundle 'ervandew/supertab'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'edkolev/tmuxline.vim'

" Text manipulation
Bundle 'godlygeek/tabular'
Bundle 'tommcdo/vim-exchange'
Bundle 'wellle/targets.vim'

" Support for others languages
Bundle 'dag/vim-fish'
Bundle 'freefem.vim'

" Snipmate & Snippets
Bundle 'garbas/vim-snipmate'
Bundle 'tomtom/tlib_vim'
Bundle 'nyorem/vim-snippets'
Bundle 'MarcWeber/vim-addon-mw-utils'

" Tpope
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-dispatch'

" Colorschemes
Bundle 'altercation/vim-colors-solarized'

" Web development
Bundle 'othree/html5.vim'
" Bundle 'digitaltoad/vim-jade'
" Bundle 'wavded/vim-stylus'

" vim-scripts
Bundle 'SearchComplete'
Bundle 'DoxygenToolkit.vim'
Bundle 'a.vim'

" {{{1 BASIC CONFIGURATION

let mapleader = "," " ',' is more accessible

" UI
set t_Co=256 " 256 colors support
set ruler " Show current position
set nu " Show lines number
set relativenumber " Use relative numbers
set encoding=utf-8 " Default character encoding
set cursorline " Highlight current line
set title " Show filename in the window titlebar
set noshowmode " Dont't show the mode since Powerline does
set laststatus=2 " Always display status bar
set scrolloff=3 " Number of lines to see when scrolling
set visualbell " No sound !
set ttyfast " Send more characters to the screen => speed up redrawing

" Behaviors
set shell=bash " Default shell to use with :sh command
set hidden " Hidden buffer by default
set autoread " Automatically reload file if changes detected
set timeoutlen=1000 ttimeoutlen=0 " Avoiding delays with <Esc>
set modelines=0 " Prevent security exploits
set makeprg=make "Standard make
set showmatch " Show corresponding parentheses
set backspace=indent,eol,start " Use backspace
set history=50 " Maximum numbers of commands in q:
set showcmd " Show current command

" Mouse use
set mousehide
set mouse=a " Activate mouse
behave xterm

" Syntax Highlighting
filetype on
syn on
syntax on

" Spell checking
" zg(ood) : add a word to the dictionary (zG : temporarily)
" zw : misspelled word
" zuw et zug : undoing
" :runtime spell/cleanadd.vim : cleaning spell dictionary
set spelllang=fr

" Searching
set incsearch " Display current search results (during typing)
set ignorecase " Case insensitive
set smartcase " Intelligent case (if caps -> take care of the case)
set hlsearch " Search results highlighting

" Suggestions
set wildmenu " Display auto completion menu
set wildmode=list:longest,list:full " Display every possibilities

" {{{1 COLORSCHEMES

if has('gui_running')
	" GUI
	set guicursor+=a:blinkon0 " Deactivate cursor blinking
	set background=dark
	colorscheme solarized
else
	" CONSOLE
	if has("unix")
		let s:uname = system("uname -s")
		if s:uname == "Darwin\n"
			" MAC

			" MOLOKAI
			" colorscheme molokai
			" set background=light
			" let g:molokai_original = 1
			" let g:rehash256 = 1

			" SOLARIZED
			colorscheme solarized
			set background=light
			let g:solarized_termtrans = 1

			" Tomorrow
			" colorscheme Tomorrow-Night-Eighties
			" set background=light
		else
			" Other Unix distribs
			colorscheme desertEx
			set background=light
		endif
	endif
endif

" {{{1 PLUGINS

" Airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline#extensions#whitespace#checks = [ 'indent' ]

" Ctrlp
set wildignore+=*.class,*.o " Ignore some files
let g:ctrlp_max_height = 10 " Max height
" Make Ctrlp faster in a git repo
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0

" Tmuxline
" Not using powerline symbols
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '>',
    \ 'right' : '',
    \ 'right_alt' : '<',
    \ 'space' : ' '}
let g:tmuxline_preset = 'full'

" {{{1 USEFUL FUNCTIONS

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
	endif
	call SummarizeTabs()
endfunction

function! SummarizeTabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction

" Strip trailing whitespace
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction

" {{{1 AUTOCMD
if has("autocmd")
	filetype plugin indent on

	augroup vimrcEx
		au!

		" Specific parameters for some types of file
		autocmd FileType text setlocal textwidth=80 noexpandtab
		autocmd FileType lex,yacc,make,c,cpp,objc setlocal ts=8 sts=8 sw=8 noexpandtab
		autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab
		autocmd FileType c,cpp,java setlocal ts=4 sts=4 sw=4 expandtab cindent cino+='(0'
		autocmd FileType r set commentstring=#\ %s
		autocmd FileType matlab set commentstring=%\ %s

		" Add new types of file
		autocmd BufNewFile,BufRead *.zsh-theme setfiletype zsh

		" Get back to the former cursor position
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\	exe "normal! g`\"" |

		" Reload vim config files when saving them
		autocmd BufWritePost vimrc,.vimrc source $MYVIMRC
		autocmd BufRead vimrc,.vimrc set foldmethod=marker

		" Help mode bindings
		" C-t to go back
		" q to quit
		autocmd filetype help nnoremap <buffer><CR> <C-]>
		autocmd filetype help nnoremap <buffer>q :q<CR>
	augroup END
else
	set autoindent " Auto indent every time
endif

" {{{1 TEXT FORMATTING
set wrap " Cut lines according to the window's width
set linebreak " Don't cut words in the end of lines
set showbreak=… " Starting character when a line is too long
set smartindent " Intelligent indentation

" INVISIBLES
set listchars=tab:▸\ ,trail:·,nbsp:_	" Invisible characters
set list " Display invisible characters

" TABS
set tabstop=8 " Number of spaces corresponding to a tabulation
set shiftwidth=8 " Spaces used for an indentation
set softtabstop=8 " Spaces to delete if we delete a tab
set noexpandtab " Don't replace tabs
set smarttab " Tab intelligent

" {{{1 MAPPINGS

" C / D coherence
noremap Y y$

" Habit breaking, habit making
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Get rid of F1
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
nnoremap <F1> <Esc>

" Navigation in splits
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Abolish Ex mode
nnoremap Q @@

" Deactivate look-up and join functions
nnoremap K k
vnoremap K k
nnoremap J j
vnoremap J j

" Normal mode in insert mode
inoremap jj <Esc>
inoremap JJ <Esc>
inoremap jJ <Esc>
inoremap Jj <Esc>

" Latex building and Makefile execution
nnoremap <F2> :w<CR>:!pdflatex %<CR>
nnoremap <F3> :w<CR>:Make<CR>

" Bubbling text
nmap <C-Down> ]e
nmap <C-Up> [e
vmap <C-Down> ]egv
vmap <C-Up> [egv

" FOLDS
" zi = toggle fold
" zj / zk = moving with folds
" zf = creating a fold (visual mode)
" zd = delete a fold
" zM = close all folds
" zR = open all folds
nnoremap <Space> zA
vnoremap <Space> zA

" <Leader> shortcuts
" Copy / paste within clipboards
noremap <Leader>y "*y
noremap <Leader>yy "*yy
noremap <Leader>p :set paste<CR>:put	*<CR>:set nopaste<CR>

" Convert a file into binary
nnoremap <Leader>b :%!xxd<CR>
nnoremap <Leader>nb :%!xxd -r<CR>

" ,t : Change indentation parameters
noremap <Leader>t :Stab<CR>

" ,m : maximize the window
nnoremap <Leader>m <C-W>_<C-W><Bar>

" ,v : open the vim directory
nnoremap <Leader>v :e $MYVIMRC<CR>

" ,W : Save a file as root
noremap <Leader>W :w !sudo tee % >/dev/null<CR>

" ,ss : Strip trailing whitespaces
noremap <Leader>ss :call StripWhitespace()<CR>
