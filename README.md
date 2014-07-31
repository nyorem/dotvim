# Setup

	cd ~
	cp -r .vim .vim.bak
	cp .vimrc .vimrc.bak
	git clone git://github.com/nyorem/dotvim.git .vim

# Symlink

	ln -s ~/.vim/vimrc ~/.vimrc

# Updating bundles

	vim +PlugInstall +qall

