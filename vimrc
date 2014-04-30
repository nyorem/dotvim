" {{{1 NeoBundle
" NeoBundleList                    - list configured bundles
" NeoBundleInstall(!)              - install(update) bundles
" NeoBundleClean(!)                - confirm(or auto- approve) removal of unused bundles
set nocompatible " No reason today to assure compatibility with vi
filetype off

set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Github repos

" Helpers
NeoBundle 'bling/vim-airline'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'szw/vim-ctrlspace'

" Text manipulation
NeoBundle 'godlygeek/tabular'
NeoBundle 'tommcdo/vim-exchange'
NeoBundle 'wellle/targets.vim'
NeoBundle 'thinca/vim-visualstar'

" Support for others languages
NeoBundle 'dag/vim-fish'
NeoBundle 'freefem.vim'

" Snipmate & Snippets
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'nyorem/vim-snippets'
NeoBundle 'MarcWeber/vim-addon-mw-utils'

" Tpope
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch'

NeoBundle 'tpope/timl'

" Colorschemes
NeoBundle 'altercation/vim-colors-solarized'

" Web development
NeoBundle 'othree/html5.vim'
" Bundle 'digitaltoad/vim-jade'
" Bundle 'wavded/vim-stylus'

" Haskell
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" vim-scripts
NeoBundle 'SearchComplete'
NeoBundle 'DoxygenToolkit.vim'
NeoBundle 'a.vim'

call neobundle#end()

" {{{1 BASIC CONFIGURATION

let mapleader = ","

" UI
set t_Co=256 " 256 colors support
set ruler " Show current position
set nu " Show lines number
set relativenumber " Use relative numbers
set encoding=utf-8 " Default character encoding
set cursorline " Highlight current line
set title " Show filename in the window titlebar
set laststatus=2 " Always display status bar
set scrolloff=3 " Number of lines to see when scrolling
set visualbell " No sound !
set ttyfast " Send more characters to the screen => speed up redrawing

" Behaviors
set shell=bash " Default shell to use with :sh command
set hidden " Hidden buffer by default
set timeoutlen=1000 ttimeoutlen=0 " Avoiding delays with <Esc>
set makeprg=make "Standard make
set showmatch " Show corresponding parentheses
set backspace=indent,eol,start " Use backspace
set history=50 " Maximum numbers of commands in q:
set showcmd " Show current command
set autoread " Automatically reload a file when changed

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
let g:airline_section_warning = ''
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline_exclude_preview = 1

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

" Supertab
let g:SuperTabDefaultCompletionType = "context"

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
		autocmd FileType make,c,cpp,objc setlocal ts=8 sts=8 sw=8 noexpandtab
		autocmd FileType java setlocal ts=4 sts=4 sw=4 expandtab
		autocmd FileType haskell setlocal ts=4 sts=4 sw=4 expandtab
		autocmd FileType c,cpp,java setlocal ts=4 sts=4 sw=4 expandtab cindent cino+='(0'
		autocmd FileType r set commentstring=#\ %s
		autocmd FileType matlab set commentstring=%\ %s

		" Add new types of file
		autocmd BufNewFile,BufRead *.zsh-theme setfiletype zsh

		" Haskell
		autocmd BufNewFile,BufRead *.hs setlocal omnifunc=necoghc#omnifunc

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

" Working with buffers like tabs (better!)
nmap <Leader>l :bnext<CR>
nmap <Leader>h :bprevious<CR>
nmap <Leader>bq :bp <BAR> bd #<CR>
nmap <Leader>bn :enew<CR>

" C / D coherence
noremap Y y$

" Select text previously pasted
noremap gV `[v`]

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

" FOLDS Cheatshet
" zi = toggle fold
" zj / zk = moving with folds
" zf = creating a fold (visual mode)
" zd = delete a fold
" zM = close all folds
" zR = open all folds

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
