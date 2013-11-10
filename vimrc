" VUNDLE {{{1
" BundleList          - list configured bundles
" BundleInstall(!)    - install(update) bundles
" BundleSearch(!) foo - search(or refresh cache first) for foo
" BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
set nocompatible " No reason today to assure compatibility with vi
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle "gmarik/vundle"

" Github repos
Bundle "garbas/vim-snipmate"
Bundle "tomtom/tlib_vim"
Bundle "nyorem/vim-snippets"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "bling/vim-airline"
Bundle "kien/ctrlp.vim"
Bundle "tpope/vim-commentary"
Bundle "junegunn/vim-easy-align"
Bundle "tpope/vim-dispatch"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-repeat"
Bundle "ervandew/supertab"
Bundle "altercation/vim-colors-solarized"
Bundle "chriskempson/vim-tomorrow-theme"
Bundle "othree/html5.vim"
Bundle "dag/vim-fish"

" vim-scripts
Bundle "SearchComplete"

" VARIOUS THINGS {{{1
let mapleader = "," " ',' is more accessible
set t_Co=256 " 256 colors support
set encoding=utf-8 " Default character encoding
set shell=bash " Default shell to use with :sh command
set modelines=0 " Prevent security exploits
set scrolloff=3 " Number of lines to see when scrolling
set visualbell " No sound !
set cursorline " Highlight current line
set ttyfast " Send more characters to the screen => speed up redrawing
set gdefault " g by default for substitutions
set showmatch " Show corresponding parentheses

" Mouse use
set mouse=a " Activate mouse
behave xterm
set laststatus=2 " Always display status bar
set timeoutlen=1000 ttimeoutlen=0 " Avoiding delays with <Esc>

" COLORSCHEMES {{{1
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
            " colorscheme Tomorrow-Night
            " set background=dark
        else
            " Other Unix distribs
            colorscheme desert
            set background=light
        endif
    endif
endif

" PLUGINS CONFIGURATION {{{1

" Airline {{{2
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline#extensions#whitespace#checks = [ 'indent' ]

" Ctrlp {{{2
set wildignore+=*.class,*.o

" Easy Align {{{2
vnoremap <silent> <CR> :EasyAlign<CR>
" AUTOCMD & INDENTATION {{{1

" Syntax Highlighting
filetype on
syn on
syntax on

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
                                    \   exe "normal! g`\"" |

            " Reload vimrc when saving it
            autocmd BufWritePost .vimrc,vimrc source $MYVIMRC
            " Auto folding vimrc with markers
            autocmd BufReadPost .vimrc,vimrc set foldmethod=marker
    augroup END
else
        set autoindent " Auto indent every time
endif

" TEXT FORMATTING {{{1
set wrap " Cut lines according to the window's width
set linebreak " Don't cut words in the end of lines
set showbreak=… " Starting character when a line is too long

set listchars=tab:▸\  " Invisible characters
set list " Display invisible characters

" TAB
set tabstop=8 " Number of spaces corresponding to a tabulation
set shiftwidth=8 " Spaces used for an indentation
set softtabstop=8 " Spaces to delete if we delete a tab
set noexpandtab " Don't replace tabs
set smarttab " Tab intelligent

set smartindent " Intelligent indentation

set history=50 " Maximum numbers of commands in q:
set showcmd " Show current command
set backspace=indent,eol,start " <BS> to delete characters

set ruler " Show current position
set nu " Show lines number
set hidden " Hidden buffer by default

" KEYBOARD SHORTCUTS {{{1

" Get rid of F1
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
nnoremap <F1> <Esc>

" Abolish vim regex mode !
nnoremap / /\v
vnoremap / /\v

" Habit breaking, habit making
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Normal mode in insert mode
inoremap jj <Esc>
" Saving a file as root
cab wr w !sudo tee %
" Latex compilation
nnoremap <F2> :w<CR>:!pdflatex %<CR>
" Makefile execution
nnoremap <F3> :w<CR>:Make<CR>

" Bubbling text
nnoremap <C-Down> ddp
nnoremap <C-Up> ddkP
vnoremap <C-Down> xp`[V`]
vnoremap <C-Up> xkP`[V`]

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
noremap <Leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" Transform a file into binary
noremap <Leader>b :%!xxd<CR>
noremap <Leader>nb :%!xxd -r<CR>

" ,m : maximize the window
nnoremap <Leader>m <C-W>_<C-W><Bar>

" ,<Space> : erasing old search pattern
nnoremap <Leader><Space> :noh<CR>

" Spell checking
" zg(ood) : add a word to the dictionary (zG : temporarily)
" zw : misspelled word
" zuw et zug : undoing
" :runtime spell/cleanadd.vim : cleaning spell dictionary
set spelllang=fr
" ,s : toggle spell checking
nnoremap <silent> <leader>s :set spell!<CR>

" ,i : toggle invisible characters
nnoremap <silent> <leader>i :set list!<CR>

" ,v : open vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>

" C / D coherence
noremap Y y$

" SEARCHING {{{1
set incsearch " Display current search results (during typing)
set ignorecase " Case insensitive
set smartcase " Intelligent case (if maj -> take care of the case)
set hlsearch " Search results highlighting

" SUGGESTIONS {{{1
set wildmenu " Display auto completion menu
set wildmode=list:longest,list:full " Display every possibilities
