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

if !has("nvim")
    " See https://github.com/pwntester/octo.nvim/issues/441
    Plug 'airblade/vim-gitgutter'
endif
Plug 'bronson/vim-visual-star-search'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dyng/ctrlsf.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'ervandew/supertab'
if !has("nvim")
    Plug 'github/copilot.vim'
endif
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'itspriddle/vim-shellcheck'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'kergoth/vim-bitbake'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nyorem/vim-colors-solarized'
if !has("nvim")
    Plug 'puremourning/vimspector'
endif
Plug 'Raimondi/delimitMate'
Plug 'romainl/vim-cool'
let g:polyglot_disabled = ["latex"]
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-lion'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
if !has("nvim")
    Plug 'tpope/vim-surround'
endif
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/a.vim'
Plug 'will133/vim-dirdiff'

call plug#end()

" {{{1 BASIC OPTIONS

" Leader
let mapleader = ","
let maplocalleader = " "

" UI
set t_Co=256 " 256 color support
set ruler " Show current position
set number " Show lines number
set encoding=utf-8 " Default character encoding
set fileencoding=utf-8 " Default file encoding
set cursorline " Highlight current line
set title " Show filename in the window titlebar
set laststatus=2 " Always display status bar
set scrolloff=3 " Number of lines to see when scrolling
set belloff=all " Deactivate bell rings

" Behaviors
set shell=bash " Default shell to use with :sh command
set hidden " Hidden buffer by default
if !has("nvim")
    " We only enable this one for vim because of this issue:
    " https://github.com/neovim/neovim/issues/29047
    set timeoutlen=1000 ttimeoutlen=0 " Avoiding delays with <Esc>
endif
set makeprg=make "Standard make
set showmatch " Show corresponding parentheses
set backspace=indent,eol,start " Allow using backspace in insert mode to move
set history=100 " Maximum numbers of commands in q:
set showcmd " Show current command
set autoread " Automatically reload a file when changed
set path+=$PWD/** " Add stuff to the search path (for the gf command)
let g:markdown_folding = 1 " Enable header folding for Markdown files

" Mouse use
set mouse=a " Activate mouse
set mousehide " Hide cursor
if !has("nvim")
    set ttymouse=sgr " To be able to click on columns far away on the right
endif

" Syntax Highlighting
filetype on
syntax on

" Spell checking
" zg(g=good) : add a word to the dictionary (zG: temporarily)
" zw: misspelled word
" zuw and zug: undoing
" :runtime spell/cleanadd.vim: cleaning spell dictionary
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
      \   'gitbranch': 'FugitiveHead'
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
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_layout = { 'down': '~40%' }

nnoremap <Space>fa :Files<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <Space>, :Buffers<CR>

" When searching in files, don't consider the filenames
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <C-f>f :Rg<CR>

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

" {{{2 coc.nvim
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> <Space>cd <Plug>(coc-definition)
nmap <silent> <Space>cr <Plug>(coc-references)

" Formatting selected code
xmap <Space>cf <Plug>(coc-format-selected)
nmap <Space>cf <Plug>(coc-format-selected)

" Remap keys for applying code actions at the cursor position
nmap <Space>ca  <Plug>(coc-codeaction-cursor)

if !has("gui_running")
    highlight CocFloating ctermbg=black ctermfg=white
    highlight CocHint ctermbg=black ctermfg=white
    highlight CocInlayHint ctermbg=black ctermfg=white
endif

" {{{2 vim-gitgutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 1

" {{{2 CurtineIncSw.vim
nnoremap <leader>sf :call CurtineIncSw()<CR>

" {{{2 netrw
let g:netrw_keepdir = 0
" let g:netrw_browse_split = 4
" let g:netrw_preview = 1
 let g:netrw_winsize = 80
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_localmovecmd = 'mv'
hi! link netrwMarkFile Search

" {{{2 ctrlsf.vim
let g:ctrlsf_default_root = "project"
nmap <C-g>g <Plug>CtrlSFPrompt
nnoremap <C-g>t :CtrlSFToggle<CR>
vmap <C-g> <Plug>CtrlSFVwordPath

" {{{2 vim-fugitive
nnoremap <Space>gg :tab Git<CR>
nnoremap <Space>gl :tab Git log<CR>
autocmd User FugitiveIndex nmap <buffer> p :Git push<CR>
autocmd User FugitiveIndex nmap <buffer> P :Git push --force-with-lease<CR>
autocmd User FugitiveIndex nmap <buffer> f :Git fetch<CR>
autocmd User FugitiveIndex nmap <buffer> F :Git pull --rebase<CR>

autocmd User FugitiveIndex nmap <buffer> l :tab Git log<CR>
autocmd User FugitiveIndex nmap <buffer> <TAB> =
autocmd User FugitiveIndex nmap <buffer> x X
autocmd User FugitiveObject setlocal foldmethod=syntax nofoldenable
autocmd User FugitiveObject,FugitiveIndex nnoremap <buffer> q :q<CR>

" {{{2 vimspector
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [ 'vscode-cpptools', 'CodeLLDB', 'debugpy' ]

nnoremap <Space>dd :call vimspector#Launch()<CR>
nnoremap <Space>de :call vimspector#Reset()<CR>
nnoremap <Space>dc :call vimspector#Continue()<CR>

nnoremap <Space>db <Plug>VimspectorBreakpoints
nnoremap <Space>dp <Plug>VimspectorBalloonEval
nnoremap <Space>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Space>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Space>dk <Plug>VimspectorRestart
nmap <Space>dh <Plug>VimspectorStepOut
nmap <Space>dl <Plug>VimspectorStepInto
nmap <Space>dj <Plug>VimspectorStepOver

" {{{2 vim-unimpaired
nmap ( [
nmap ) ]
omap ( [
omap ) ]
xmap ( [
xmap ) ]

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

function! ReadMan(text)
  :exe ":tabnew"
  " make it a scratch buffer (to not care about if being 'unsaved')
  :exe ":setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile"
  :exe ":r!man " . a:text . " | col -b"
  :exe ":goto"
  :exe ":delete"
  :exe ":set filetype=man"
endfunction

" source: https://vim.fandom.com/wiki/Open_a_window_with_the_man_page_for_the_word_under_the_cursor
function! ReadManNormal()
    call ReadMan(expand('<cword>'))
endfunction

" source: https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript/6271254#6271254
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! ReadManVisual()
    call ReadMan(s:get_visual_selection())
endfunction

nnoremap <Space>m :call ReadManNormal()<CR>
vnoremap <Space>m :call ReadManVisual()<CR>

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
        autocmd!

        " New filetypes
        autocmd BufNewFile,BufRead *.geom,*.tesc,*.tese,*.comp set filetype=glsl
        autocmd BufNewFile,BufRead *.md.html set filetype=markdown
        autocmd BufNewFile,BufRead *.ih set filetype=cpp
        autocmd BufNewFile,BufRead *.dox set filetype=doxygen
        autocmd BufNewFile,BufRead *.h++,*.ecpp setlocal filetype=cpp

        " Specific parameters for some filetypes
        autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType c,cpp,cuda,objc,java setlocal ts=2 sts=2 sw=2 expandtab cindent cino+='(0'
        autocmd FileType haskell setlocal ts=4 sts=4 sw=4 expandtab
        autocmd FileType r,cmake setlocal commentstring=#\ %s
        autocmd FileType cabal setlocal commentstring=--\ %s
        autocmd FileType matlab setlocal commentstring=%\ %s
        autocmd FileType plaintex,tex setlocal textwidth=80
        autocmd FileType cmake,c,cpp let &makeprg = "cd $(git rev-parse --show-toplevel) && cmake --build build -j 8"
        autocmd FileType cmake,c,cpp  nnoremap <buffer> <F7> :Make<CR>
        autocmd FileType sh nnoremap <buffer> <F7> :ShellCheck!<CR>
        autocmd FileType markdown setlocal foldlevel=99

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
set tabstop=2 " Number of spaces corresponding to a tabulation
set shiftwidth=2 " Spaces used for an indentation
set softtabstop=2 " Spaces to delete if we delete a tab
set smarttab

" {{{1 MAPPINGS

" Being coherent with C / D
noremap Y y$

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
nnoremap <C-Left> gT
nnoremap <C-Right> gt

" Sudo write a file
cmap w!! w !sudo tee > /dev/null %

" Escape in insert mode
inoremap jj <Esc>

" Get rid of F1
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
nnoremap <F1> <Esc>

" Duplicate current buffer in new tab
nnoremap <C-w>T :tab split<CR>

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

" K = opposite of J => split line at cursor position
nnoremap K i<CR><ESC>g;

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

" ,t : Change indentation parameters
noremap <leader>t :Stab<CR>

" ,m : maximize the current window
nnoremap <leader>m <C-W>_<C-W><Bar>

" ,ev : open the vimrc and ,sv source it
nnoremap <leader>ev :vsplit $MYVIMRC<CR>:only<CR>
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

" update quickfix list results (source:
" https://vi.stackexchange.com/questions/13662/is-there-a-way-to-update-the-quickfix-entries-after-running-cdo-cfdo)
command! UpdateQF call setqflist(map(getqflist(), 'extend(v:val, {"text": get(getbufline(v:val.bufnr, v:val.lnum),0)})'))

" prettify the whole buffer (if it's JSON)
nnoremap <Space>jp :%!jq<CR>

" {{{1 TERMINAL
if has("terminal")
  " Open terminal containing current file
  nnoremap <Space>ot :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>cd $VIM_DIR<CR>
endif

" {{{1 WSL
let s:clip = 'clip.exe'
if executable(s:clip)
    vmap <c-c> y
    set clipboard=unnamedplus

    " augroup WSLYank
    "     autocmd!
    "     autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    " augroup END
endif

if executable('wslview')
    " see https://old.reddit.com/r/neovim/comments/olq8dw/defining_the_browse_command_for_use_with/
    " wslview comes from https://github.com/wslutilities/wslu
    function OpenBrowserWsl(url)
        execute "!wslview " . escape(a:url, "#")
    endfunction

    command! -nargs=1 Browse call OpenBrowserWsl(<f-args>)
endif
