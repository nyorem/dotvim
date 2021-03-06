" {{{1 PLUGINS
set nocompatible " No reason today to be compatible with vi
filetype off

" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle/')

" Must-have
Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'bronson/vim-visual-star-search'
Plug 'romainl/vim-cool'
Plug 'mattn/emmet-vim'
Plug 'tomtom/tcomment_vim'

" Text manipulation
Plug 'tommcdo/vim-lion'
Plug 'tommcdo/vim-exchange'

" Support for others languages
let g:polyglot_disabled = ["latex"]
Plug 'sheerun/vim-polyglot'
Plug 'mipmip/vim-run-in-blender'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Tpope
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'

" Colorschemes
Plug 'nyorem/vim-colors-solarized'

" misc
Plug 'vim-scripts/a.vim'
Plug 'lsrdg/vibusen.vim'

call plug#end()

" {{{1 BASIC OPTIONS

" Leader
let mapleader = ","
let maplocalleader = " "

" UI
set t_Co=256 " 256 color support
set ruler " Show current position
set number " Show lines number
set relativenumber " Use relative numbers
set encoding=utf-8 " Default character encoding
set cursorline " Highlight current line
set title " Show filename in the window titlebar
set laststatus=2 " Always display status bar
set scrolloff=3 " Number of lines to see when scrolling
set belloff=all " Deactivate bell rings

" Behaviors
set shell=zsh " Default shell to use with :sh command
set hidden " Hidden buffer by default
set timeoutlen=1000 ttimeoutlen=0 " Avoiding delays with <Esc>
set makeprg=make "Standard make
set showmatch " Show corresponding parentheses
set backspace=indent,eol,start " Allow using backspace in insert mode to move
set history=100 " Maximum numbers of commands in q:
set showcmd " Show current command
set autoread " Automatically reload a file when changed
set path+=$PWD/** " Add stuff to the search path (for the gf command)

" Mouse use
set mouse=a " Activate mouse
set mousehide " Hide cursor
set ttymouse=sgr " To be able to click on columns far away on the right

" Syntax Highlighting
filetype on
syntax on

" Spell checking
" zg(ood) : add a word to the dictionary (zG : temporarily)
" zw : misspelled word
" zuw et zug : undoing
" :runtime spell/cleanadd.vim : cleaning spell dictionary
set spelllang=en

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
        set background=light
        let g:solarized_termtrans = 1
    else
        colorscheme desertEx
    endif
endif

" {{{1 PLUGINS OPTIONS

" {{{2 lightline.vim
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

set noshowmode " Don't show mode since it is already in the statusline

" {{{2 tmuxline.vim
" Do not use powerline symbols
let g:tmuxline_separators = {
            \ 'left' : '',
            \ 'left_alt': '>',
            \ 'right' : '',
            \ 'right_alt' : '<',
            \ 'space' : ' '}
" Customize the tmuxline
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'c'    : '#H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '#(mpc current)',
      \'y'    : '%a',
      \'z'    : '%R'}

" {{{2 fzf.vim
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
let g:fzf_layout = { 'down': '~40%' }

" {{{2 Ultisnips
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" {{{2 a.vim
let g:alternateExtensions_vert = "tesc,tese,geom,frag"
let g:alternateExtensions_tesc = "tese,geom,frag,vert"
let g:alternateExtensions_tese = "geom,frag,vert,tesc"
let g:alternateExtensions_geom = "frag,vert,tesc,tese"
let g:alternateExtensions_frag = "vert,tesc,tese,geom"
let g:alternateExtensions_h = "ih,cpp"
let g:alternateExtensions_ih = "h,cpp"

" {{{2 vibusen.vim
let g:VibusenDefaultEngine = 'xkb:fr::fra'

" {{{2 vim-vue
let g:vue_pre_processors = []

" {{{2 emmet-vim
let g:user_emmet_leader_key = ','

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

        " New filetypes
        autocmd BufNewFile,BufRead *.geom,*.tesc,*.tese,*.comp set filetype=glsl
        autocmd BufNewFile,BufRead *.md.html set filetype=markdown
        autocmd BufNewFile,BufRead *.ih set filetype=cpp
        autocmd BufNewFile,BufRead *.dox set filetype=doxygen

        " Specific parameters for some filetypes
        autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType c,cpp,cuda,objc,java setlocal ts=4 sts=4 sw=4 expandtab cindent cino+='(0'
        autocmd FileType haskell setlocal ts=4 sts=4 sw=4 expandtab
        autocmd FileType r,cmake setlocal commentstring=#\ %s
        autocmd FileType cabal setlocal commentstring=--\ %s
        autocmd FileType matlab setlocal commentstring=%\ %s
        autocmd FileType plaintex,tex setlocal textwidth=80

        " Haskell specific
        " see: https://reddit.com/r/haskell/comments/43jauf/vim_and_haskell_in_2016/
        " au FileType haskell setlocal makeprg=ghc\ -e\ :q\ %
        autocmd FileType haskell setlocal makeprg=stack\ ghc\ --\ -e\ :q\ %
        autocmd FileType haskell setlocal errorformat=
                        \%-G,
                        \%-Z\ %#,
                        \%W%f:%l:%c:\ Warning:\ %m,
                        \%E%f:%l:%c:\ %m,
                        \%E%>%f:%l:%c:,
                        \%+C\ \ %#%m,
                        \%W%>%f:%l:%c:,
                        \%+C\ \ %#%tarning:\ %m,

        " Get back to the last cursor position
        autocmd BufReadPost * if line("'\"") | exe "'\"" | endif

        " Markdown
        " au FileType markdown setlocal nomodeline

        " Help mode bindings
        " <CR> to follow a link
        " C-t to go back
        " q to quit
        autocmd filetype help nnoremap <buffer><CR> <C-]>
        autocmd filetype help nnoremap <buffer>q :q<CR>

        " set wrapping in diff mode
        au VimEnter * if &diff | execute 'windo set wrap' | endif
    augroup END

    " Vimscript file settings
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
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

" TABS/SPACES PARAMETERS
set expandtab " Replace tabs with spaces
set tabstop=4 " Number of spaces corresponding to a tabulation
set shiftwidth=4 " Spaces used for an indentation
set softtabstop=4 " Spaces to delete if we delete a tab
set smarttab

" {{{1 MAPPINGS

" Being coherent with C / D
noremap Y y$

" vim-vinegar like mapping
function! EditCurrentDirectory()
    let l:dname = expand("%:p:h")
    execute "edit" .  l:dname
endfunction
nnoremap - :call EditCurrentDirectory()<CR>
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_sort_sequence = '[\/]$,*,\%(' . join(map(split(&suffixes, ','), 'escape(v:val, ".*$~")'), '\|') . '\)[*@]\=$'
if !exists("g:netrw_banner")
  let g:netrw_banner = 0
endif

" Consistent behaviour of j/k on wrapped lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Jump to the end of the line in insert mode like in the shell
inoremap <C-e> <C-o>$

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
inoremap jj <Esc>

" Get rid of F1
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
nnoremap <F1> <Esc>

" Restore ','
nnoremap ,, ,

" Keep search matches in the middle of the window
" and keep the same directions no matter we used '/' or '?'
nnoremap <expr> n  'Nn'[v:searchforward].'zvzz'
nnoremap <expr> N  'nN'[v:searchforward].'zvzz'

" Don't lose selection when shifting sidewards
xnoremap <  <gv
xnoremap >  >gv

" Abolish Ex mode
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Deactivate man look-up functions
nnoremap K k
vnoremap K k

" Avoid lowercasing selected text in visual mode
vnoremap u <NOP>

" Non-ASCII characters
nnoremap <Leader>a /[^\x00-\x7F]<CR>:set hlsearch<CR>

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
noremap <leader>p :set paste<CR>:put	+<CR>:set nopaste<CR>

" Switching buffers
nnoremap <leader><space> :ls<cr>:b<space>
nnoremap <leader>s<space> :ls<cr>:sb<space>
nnoremap <leader>v<space> :ls<cr>:vert sb<space>
nnoremap <leader>t<space> :ls<cr>:tab sb<space>

" ,t : Change indentation parameters
noremap <leader>t :Stab<CR>

" ,m : maximize the current window
nnoremap <leader>m <C-W>_<C-W><Bar>

" ,ev : open the vimrc and ,sv source it
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<cr>

" ,ss : Strip trailing whitespaces
nnoremap <leader>ss :call StripWhitespace()<CR>

" ,b / ,nb to convert to binary
nnoremap <leader>b :%!xxd<CR>
nnoremap <leader>nb :%!xxd -r<CR>

" Force redraw
nnoremap <silent> <leader>r :redraw!<CR>

" Don't save files named ':'
cnoremap w: w

" Common mistakes
cnoremap ww w
cnoremap qw wq

" {{{1 TERMINAL
if has("terminal")
    tnoremap <Esc><Esc> <C-\><C-n>:setlocal nonumber<cr>:setlocal norelativenumber<cr>
    cabbr te terminal ++curwin ++kill=kill
    cabbr term terminal ++curwin ++kill=kill
    cabbr vterm vert :term ++kill=kill
    cabbr hterm term ++kill=kill
endif
