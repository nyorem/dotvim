" PATHOGEN
runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

let mapleader = "," "<Leader> = ',' désormais
set t_Co=256 " Force le support de 256 couleurs
set encoding=utf-8 " Encodage par défaut

" Utilisation de la souris
set mouse=a
behave xterm

" AUTRES
set nocp " Non compatibilité avec les anciennes versions de vim
set laststatus=2 " Toujours afficher la barre de statut
set timeoutlen=1000 ttimeoutlen=0 " Eviter les délais lorsqu'on appui sur <Esc>
let Tlist_Ctags_Cmd = '/opt/local/bin/ctags' " Taglist

" COLORSCHEMES
if has('gui_running')
    set guicursor+=a:blinkon0 " Désactivation du clignotement du curseur
    set background=dark
    colorscheme solarized
else
    colorscheme solarized
    set background=light
    call togglebg#map("<F5>")
    let g:solarized_termtrans = 1
    let g:Powerline_symbols = 'compatible' " Powerline
endif

" INDENTATION
if has("autocmd")
    filetype plugin indent on

    augroup vimrcEx
        au!

        " Modification de paramètres pour certains types de fichiers
        autocmd FileType text setlocal textwidth=80
        autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType c setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType cpp setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType objc setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType lex setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType yacc setlocal ts=8 sts=8 sw=8 noexpandtab

        " Nouveaux types de fichiers
        autocmd BufNewFile,BufRead *.zsh-theme setfiletype zsh
        autocmd BufNewFile,BufRead *.m setfiletype objc

        " Utile pour l'indentation : revenir à la position ancienne du curseur
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |

        " Recharge le vimrc à chaque modification
        autocmd bufwritepost .vimrc source $MYVIMRC
        autocmd bufwritepost vimrc source $MYVIMRC
    augroup END
else
    set autoindent " Indentation auto dans tous les cas
endif

" COLORATION SYNTAXIQUE
filetype on
syn on
syntax on

" MISE EN FORME DU TEXTE

set wrap " Couper les lignes suivant la largeur de la fenêtre
set linebreak " Ne pas couper les mots en fin de lignes
set showbreak=…

set listchars=tab:▸\ ,eol:¬ " Invisibles

set tabstop=4 " Nombre d'espaces correspondants à des TAB
set shiftwidth=4 " Nombre d'espaces utilisés par l'indentation
set softtabstop=4 " Nombre d'espaces à supprimer lors de l'effacement d'une TAB
set expandtab " Remplace les TAB par des espaces
set smartindent
set smarttab

set history=50 " Nombre de commandes dans l'historique
set showcmd " Affiche la commande que l'on est en train de taper
set backspace=indent,eol,start " Possibilité d'utiliser Effacer et autres...

set ruler " Affiche la position courante en bas à droite
set nu " Affiche les numéros de ligne
set hidden

" RACCOURCIS CLAVIER

inoremap jk <Esc>
" Enregistre le fichier en tant que root avec :wr
cab wr w !sudo tee %
" Compilation Latex
nnoremap <F2> :w<CR>:!pdflatex %<CR>
" Exécution d'un Makefile
nnoremap <F3> :w<CR>:Make<CR>

" Ouvrir un fold
" zi = activer / désactiver le folding
" zj / zk = monter / descendre d'un fold
" zf = créer un fold (sélection visuelle)
" zd = supprimer un fold
" zM = ferme tous les folds
" zR = ouvre tous les folds
nnoremap <Space> za
vnoremap <Space> za

" On désactive les flèches directionnelles pour forcer à utiliser h/j/k/l
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Se déplacer sur une grande ligne
vnoremap <D-j> gj
vnoremap <D-k> gk
vnoremap <D-4> g$
vnoremap <D-6> g^
vnoremap <D-0> g0
nnoremap <D-j> gj
nnoremap <D-k> gk
nnoremap <D-4> g$
nnoremap <D-6> g^
nnoremap <D-0> g0

" Bouger le texte
nnoremap <C-Down> ddp
nnoremap <C-Up> ddkP
vnoremap <C-Down> xp`[V`]
vnoremap <C-Up> xkP`[V`]

" Utilisation de ','

" Copier / Coller du texte depuis l'extérieur
noremap <Leader>y "*y
noremap <Leader>yy "*Y
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

" RECHERCHE

set showmatch " Affiche les parenthèses (et autres) correspondantes
set incsearch " Affiche les résultats de la recherche au moment de la saisie
set ignorecase " Insensible à la casse
set smartcase " Casse intelligente (si MAJ alors insensible sinon non)
set hlsearch " Surbrillance des résultats d'une recherche

" SUGGESTIONS
set wildmenu " Menu de la complétion automatique
set wildmode=list:longest,list:full " Affiche toutes les possibilités

" SPÉCIFIQUE ADA
let g:ada_standard_types=1
let g:ada_line_errors=1
