# Installation :

	cd
	rm -rf .vim
	rm -f .vimrc
	git clone git://github.com/nyorem/dotvim.git .vim

# Création du lien symmbolique ::

	ln -s ~/.vim/vimrc ~/.vimrc

# Mise à jour des dépôts :

	vim +BundleInstall +qall
