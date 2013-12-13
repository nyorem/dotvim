" VUNDLE
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
Bundle "garbas/vim-snipmate"
Bundle "tomtom/tlib_vim"
Bundle "nyorem/vim-snippets"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "bling/vim-airline"
Bundle "kien/ctrlp.vim"
Bundle "tpope/vim-commentary"
Bundle "godlygeek/tabular"
Bundle "tpope/vim-unimpaired"
Bundle "tpope/vim-dispatch"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-repeat"
Bundle "ervandew/supertab"
Bundle "altercation/vim-colors-solarized"
Bundle "chriskempson/vim-tomorrow-theme"
Bundle "othree/html5.vim"
Bundle "dag/vim-fish"
Bundle "mattn/emmet-vim"

" vim-scripts
Bundle "SearchComplete"

