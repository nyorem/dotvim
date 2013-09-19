autocmd BufNewFile,BufRead *.m
      \ if &ft =~# '^\%(conf\|matlab\)$' |
      \   set ft=objc |
      \ else |
      \   setf objc |
      \ endif
