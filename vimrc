" VUNDLE {{{1
" BundleList          - list configured bundles
" BundleInstall(!)    - install(update) bundles
" BundleSearch(!) foo - search(or refresh cache first) for foo
" BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
set nocompatible " Non compatibilité avec les anciennes versions de vim
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle "gmarik/vundle"

" Github repos
Bundle "garbas/vim-snipmate"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "bling/vim-airline"
Bundle "kien/ctrlp.vim"
Bundle "tomtom/tcomment_vim"
Bundle "godlygeek/tabular"
Bundle "rhysd/accelerated-jk"
Bundle "tpope/vim-dispatch"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-surround"
Bundle "scrooloose/nerdtree"
Bundle "ervandew/supertab"
Bundle "altercation/vim-colors-solarized"
Bundle "othree/html5.vim"

" vim-scripts
Bundle "SearchComplete"

" AUTRES {{{1
let mapleader = "," "<Leader> = ',' désormais
set t_Co=256 " Support de 256 couleurs
set encoding=utf-8 " Encodage par défaut

" Utilisation de la souris
set mouse=a
behave xterm
set laststatus=2 " Toujours afficher la barre de statut
set timeoutlen=1000 ttimeoutlen=0 " Eviter les délais lorsqu'on appui sur <Esc>

" COLORSCHEMES {{{1
if has('gui_running')
    " GUI
    set guicursor+=a:blinkon0 " Désactivation du clignotement du curseur
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
            set background=dark
            let g:solarized_termtrans = 1
        else
            " Other Unix distribs
            colorscheme desertEx
            set background=light
        endif
    endif
endif

" CONFIGURATION PLUGINS {{{1

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

" INDENTATION et AUTOCMD {{{1

" COLORATION SYNTAXIQUE
filetype on
syn on
syntax on

if has("autocmd")
    filetype plugin indent on

    augroup vimrcEx
        au!

        " Modification de paramètres pour certains types de fichiers
        autocmd FileType text setlocal textwidth=80
        autocmd FileType make,c,cpp,objc setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType lex,yacc setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType java setlocal ts=4 sts=4 sw=4 noexpandtab
        autocmd FileType c,cpp,java setlocal cindent cino+='(0'

        " Nouveaux types de fichiers
        autocmd BufNewFile,BufRead *.zsh-theme setfiletype zsh

        " Indentation : revenir à la position ancienne du curseur
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |

        " Recharge le vimrc à chaque modification
        autocmd BufWritePost .vimrc,vimrc source $MYVIMRC
        " vimrc : méthode de fold = marker
        autocmd BufReadPost .vimrc,vimrc set foldmethod=marker
    augroup END
else
    set autoindent " Indentation auto dans tous les cas
endif

" MISE EN FORME DU TEXTE {{{1
set wrap " Couper les lignes suivant la largeur de la fenêtre
set linebreak " Ne pas couper les mots en fin de lignes
set showbreak=… " En cas de coupures de lignes, caractère de début de ligne

set listchars=tab:▸\ ,eol:¬ " Caractères invisibles

set tabstop=8 " Nombre d'espaces correspondants à des TAB
set shiftwidth=8 " Nombre d'espaces utilisés par l'indentation
set softtabstop=8 " Nombre d'espaces à supprimer lors de l'effacement d'une TAB
set expandtab " Remplace les TAB par des espaces
set smartindent " Indentation intelligente
set smarttab " Tab intelligent

set history=50 " Nombre de commandes dans l'historique
set showcmd " Affiche la commande que l'on est en train de taper
set backspace=indent,eol,start " Possibilité d'utiliser Effacer et autres...

set ruler " Affiche la position courante en bas à droite
set nu " Affiche les numéros de ligne
set hidden

" RACCOURCIS CLAVIER {{{1

" Accélérons la vitesse de défilement !
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" Habit breaking, habit making
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Passage en mode normal depuis le mode insertion
inoremap jk <Esc>
" Enregistre le fichier en tant que root avec :wr
cab wr w !sudo tee %
" Compilation Latex
nnoremap <F2> :w<CR>:!pdflatex %<CR>
" Exécution d'un Makefile
nnoremap <F3> :w<CR>:Make<CR>
" Tagbar
nnoremap <F11> :TagbarToggle<CR>

" Bouger le texte
nnoremap <C-Down> ddp
nnoremap <C-Up> ddkP
vnoremap <C-Down> xp`[V`]
vnoremap <C-Up> xkP`[V`]

" FOLDS
" zi = activer / désactiver le folding
" zj / zk = monter / descendre d'un fold
" zf = créer un fold (sélection visuelle)
" zd = supprimer un fold
" zM = ferme tous les folds
" zR = ouvre tous les folds
nnoremap <Space> za
vnoremap <Space> za

" Utilisation de ','
" Copier / Coller du texte depuis l'extérieur
noremap <Leader>y "*y
noremap <Leader>yy "*yy
noremap <Leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" Passer un fichier en binaire
noremap <Leader>b :%!xxd<CR>
noremap <Leader>nb :%!xxd -r<CR>

" ,m pour maximiser une fenêtre
nnoremap <Leader>m <C-W>_<C-W><Bar>

" Correction orthographique
" zg(ood) pour ajouter un mot définitivement (zG temporairement)
" zw pour marquer un mot comme mal orthographié
" zuw et zug pour enlever la modif
" :runtime spell/cleanadd.vim pour nettoyer le fichier de spell
set spelllang=fr
" ,s pour activer/désactiver la correction
nnoremap <silent> <leader>s :set spell!<CR>

" ,i pour montrer/enlever les caractères invisibles
nnoremap <silent> <leader>i :set list!<CR>

" ,v pour ouvrir le vimrc
nnoremap <Leader>v :e $MYVIMRC<CR>

" Cohérence avec C et D
noremap Y y$

" RECHERCHE {{{1
set showmatch " Affiche les parenthèses (et autres) correspondantes
set incsearch " Affiche les résultats de la recherche au moment de la saisie
set ignorecase " Insensible à la casse
set smartcase " Casse intelligente (si MAJ alors insensible sinon non)
set hlsearch " Surbrillance des résultats d'une recherche

" SUGGESTIONS {{{1
set wildmenu " Menu de la complétion automatique
set wildmode=list:longest,list:full " Affiche toutes les possibilités

" ADA {{{1
let g:ada_standard_types=1
let g:ada_line_errors=1

