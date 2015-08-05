" {{{1 VIM-PLUG
set nocompatible " No reason today to assure compatibility with vi
filetype off

" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle/')

" Github repos

" In development
Plug '~/projets/hawking/vim'
Plug '~/dev/viml/vim-potion'
Plug '~/dev/viml/vim-todo'

" Must-have
Plug 'bling/vim-airline'
Plug 'ervandew/supertab'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'szw/vim-ctrlspace'
Plug 'kien/ctrlp.vim'
Plug 'bronson/vim-visual-star-search'
Plug 'rking/ag.vim'

" Text manipulation
Plug 'tommcdo/vim-lion'
Plug 'tommcdo/vim-exchange'
Plug 'ConradIrwin/vim-bracketed-paste'

" Support for others languages
Plug 'sheerun/vim-polyglot'
Plug 'dag/vim-fish', {'for': 'fish'}
Plug 'freefem.vim', {'for': 'edp'}
Plug 'lambdatoast/elm.vim', {'for': 'elm'}
Plug 'idris-hackers/idris-vim', {'for': 'idris'}
Plug 'tikhomirov/vim-glsl', {'for': 'glsl'}

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Tpope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

" Colorschemes
Plug 'altercation/vim-colors-solarized'

" vim-scripts
Plug 'SearchComplete'
Plug 'DoxygenToolkit.vim'
Plug 'a.vim'

call plug#end()

" {{{1 BASIC OPTIONS

" Leader
let mapleader = ","
let maplocalleader = " "

" UI
set t_Co=256 " 256 colors support
set ruler " Show current position
set number " Show lines number
set relativenumber " Use relative numbers
set encoding=utf-8 " Default character encoding
set cursorline " Highlight current line
set title " Show filename in the window titlebar
set laststatus=2 " Always display status bar
set scrolloff=3 " Number of lines to see when scrolling
set visualbell " No sound!

" Behaviors
set shell=zsh " Default shell to use with :sh command
set hidden " Hidden buffer by default
set timeoutlen=1000 ttimeoutlen=0 " Avoiding delays with <Esc>
set makeprg=make "Standard make
set showmatch " Show corresponding parentheses
set backspace=indent,eol,start " Allow using backspace
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
    set background=light
    colorscheme solarized
else
    " CONSOLE
    if has("unix")
        " SOLARIZED
        colorscheme solarized
        set background=dark
        let g:solarized_termtrans = 1
    endif
endif

" {{{1 PLUGINS

" {{{2 Airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_warning = ''
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline_exclude_preview = 1

" {{{2 Tmuxline
" Not use powerline symbols
let g:tmuxline_separators = {
            \ 'left' : '',
            \ 'left_alt': '>',
            \ 'right' : '',
            \ 'right_alt' : '<',
            \ 'space' : ' '}
let g:tmuxline_preset = 'full'

" {{{2 Ctrlp
set wildignore+=.DS_Store,*~,*.swp,*.class,*.o,*/\.git/*,*/build/*,*/lib/* " Ignore some files
let g:ctrlp_max_height = 10 " Max height
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" {{{2 Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" {{{2 a.vim
" Alternate files for GLSL code
let g:alternateExtensions_vert = "frag,geom"
let g:alternateExtensions_frag = "geom,vert"
let g:alternateExtensions_geom = "vert,frag"

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

        " Specific parameters for some filetypes
        autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType c,cpp,cuda,objc,java setlocal ts=4 sts=4 sw=4 expandtab cindent cino+='(0'
        autocmd FileType haskell setlocal ts=4 sts=4 sw=4 expandtab
        autocmd FileType r,cmake setlocal commentstring=#\ %s
        autocmd FileType cabal setlocal commentstring=--\ %s
        autocmd FileType matlab setlocal commentstring=%\ %s
        autocmd FileType tex setlocal textwidth=80

        " Get back to the last cursor position
        autocmd BufReadPost * if line("'\"") | exe "'\"" | endif

        " Help mode bindings
        " <CR> to follow a link
        " C-t to go back
        " q to quit
        autocmd filetype help nnoremap <buffer><CR> <C-]>
        autocmd filetype help nnoremap <buffer>q :q<CR>
    augroup END

    " Vimscript file settings {{{
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END
    " }}}
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

" DEFAULTS TABULATIONS PARAMETERS
set expandtab " Replace tabs with spaces
set tabstop=4 " Number of spaces corresponding to a tabulation
set shiftwidth=4 " Spaces used for an indentation
set softtabstop=4 " Spaces to delete if we delete a tab
set smarttab

" {{{1 MAPPINGS

" C / D coherence
noremap Y y$

" Select text previously pasted
noremap gV `[v`]

" Habit breaking, habit making
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Use arrows for tab switching
nnoremap <Left> gT
nnoremap <Right> gt

" Sudo write a file
cmap w!! w !sudo tee > /dev/null %

" Escape in insert mode
inoremap jk <Esc>

" Get rid of F1
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
nnoremap <F1> <Esc>

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

" Restore ','
nnoremap ,, ,

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Abolish Ex mode
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Deactivate look-up functions
nnoremap K k
vnoremap K k

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

set foldmethod=marker " Default fold method

" <leader> mappings
" Copy / paste within system clipboard
noremap <leader>y "+y
noremap <leader>yy "+yy
noremap <leader>p :set paste<CR>:put	*<CR>:set nopaste<CR>

" ,t : Change indentation parameters
noremap <leader>t :Stab<CR>

" ,m : maximize the current window
nnoremap <leader>m <C-W>_<C-W><Bar>

" ,ev : open the vimrc and ,sv source it
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>

" ,ss : Strip trailing whitespaces
nnoremap <leader>ss :call StripWhitespace()<CR>

" ,tig : open tig
nnoremap <leader>tig :!tig<CR>

" ,b / ,nb to convert to binary
nnoremap <Leader>b :%!xxd<CR>
nnoremap <Leader>nb :%!xxd -r<CR>

" Force redraw
nnoremap <silent> <leader>r :redraw!<CR>

" Don't save files named ':'
cnoremap w: w

" Fix common mistakes
cnoremap ww w
cnoremap qw wq

" {{{1 NVIM
if has('nvim')
  tnoremap <Esc> <c-\><c-n>
  au WinEnter *term://* call feedkeys('i')
endif

