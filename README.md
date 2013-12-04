# Setup

	cd
	rm -rf .vim
	rm -f .vimrc
	git clone git://github.com/nyorem/dotvim.git .vim

# Symlink

	ln -s ~/.vim/vimrc ~/.vimrc

# Updating bundles

	vim +BundleInstall +qall

