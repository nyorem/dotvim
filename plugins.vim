" PLUGINS

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

" Emmet
" Enable only for HTML / CSS files
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
