" MAPPINGS

" C / D coherence
noremap Y y$

" Habit breaking, habit making
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Get rid of F1
inoremap <F1> <Esc>
vnoremap <F1> <Esc>
nnoremap <F1> <Esc>

" Abolish vim regex mode
nnoremap / /\v
vnoremap / /\v

" Abolish Ex mode
nnoremap Q @@

" Deactivate look-up function
nnoremap K k
vnoremap K k

" Normal mode in insert mode
inoremap jj <Esc>
inoremap JJ <Esc>
inoremap jJ <Esc>
inoremap Jj <Esc>

" Latex building and Makefile execution
nnoremap <F2> :w<CR>:!pdflatex %<CR>
nnoremap <F3> :w<CR>:Make<CR>

" Bubbling text
nmap <C-Down> ]e
nmap <C-Up> [e
vmap <C-Down> ]egv
vmap <C-Up> [egv

" Yanking the entire buffer
nnoremap gy :%y+<CR>

" Select entire buffer
nnoremap vy ggVG

" Adding blank lines
nnoremap go o<Esc>0C<Esc>k
nnoremap gO O<Esc>0C<Esc>j

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
noremap <Leader>p :set paste<CR>:put	*<CR>:set nopaste<CR>

" Convert a file into binary
nnoremap <Leader>b :%!xxd<CR>
nnoremap <Leader>nb :%!xxd -r<CR>

" ,s : toggle spell checking
nnoremap <silent> <leader>s :set spell!<CR>

" ,t : Change tab
noremap <Leader>t :Stab<CR>

" ,m : maximize the window
nnoremap <Leader>m <C-W>_<C-W><Bar>

" ,<Space> : erasing old search pattern
nnoremap <Leader><Space> :noh<CR>

" ,l : toggle invisible characters
nnoremap <silent> <leader>l :set list!<CR>

" ,v : open the vim directory
nnoremap <Leader>v :e ~/.vim<CR>

" ,W : Save a file as root
noremap <Leader>W :w !sudo tee % >/dev/null<CR>

" ,ss : Strip trailing whitespaces
noremap <Leader>ss :call StripWhitespace()<CR>

" Underline the current line with '-'
nnoremap <silent> <Leader>ul :t.\|s/./-/g\|:nohls<CR>

" Underline the current line with '-'
nnoremap <silent> <Leader>uul :t.\|s/./=/g\|:nohls<CR>

" Surrent current line with lines
nnoremap <silent> <Leader>cul :normal "lyy"lpwv$r-^"lyyk"lP<CR>

