" Colorschemes

if has('gui_running')
	" GUI
	set guicursor+=a:blinkon0 " Deactivate cursor blinking
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
			set background=light
			let g:solarized_termtrans = 1

			" Tomorrow
			" colorscheme Tomorrow-Night-Eighties
			" set background=light
		else
			" Other Unix distribs
			colorscheme desert
			set background=light
		endif
	endif
endif
