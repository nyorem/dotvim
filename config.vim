" BASIC CONFIGURATION

let mapleader = "," " ',' is more accessible

" UI
set t_Co=256 " 256 colors support
set ruler " Show current position
set nu " Show lines number
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

